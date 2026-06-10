
//  InferenceService.swift
//  CH3_8AM_TeachersGood
//
//  Created by Syauqi Auliya M on 04/06/26.
//

import Foundation
import FoundationModels

@Generable
struct LabelExtractionResult {
    @Guide(description: "Emotional and professional themes present in the transcript. Only pick labels clearly supported by what the teacher said.")
    var labels: [AffirmationLabel]
}

class InferenceService {
    static let shared = InferenceService()
    private let available: Bool

    // Fallbacks that work regardless of whether entry is positive, negative, or neutral
    private let fallbackResponses = [
        "Sounds like quite a day. Whatever you're feeling right now makes sense.",
        "Thanks for sharing that with me. You showed up, and that matters.",
        "That took something to put into words. However the day went, you did it.",
        "Whatever today threw at you, you're here. That counts.",
        "Not every day goes the same way. Thanks for letting me know how this one went."
    ]

    init() {
        available = SystemLanguageModel.default.isAvailable
    }

    func extractLabels(from transcript: String) async -> [AffirmationLabel] {
        guard available else { return [.motivation, .selfCare] }

        do {
            let session = LanguageModelSession(instructions: """
                You analyze voice journal entries from school teachers.
                Extract the most relevant emotional and professional themes.
                Return a MAXIMUM of 3 labels. Only include themes clearly and strongly present.
                If in doubt, leave it out.
                """)

            let result = try await session.respond(
                to: "Extract the relevant labels from this journal entry: \"\(transcript)\"",
                generating: LabelExtractionResult.self
            )
            return result.content.labels

        } catch {
            print("extractLabels failed: \(error)")
            return [.motivation, .selfCare]
        }
    }

    func generateThingyResponse(
        transcript: String,
        affirmation: String,
        teacherName: String
    ) async -> String {
        guard available else {
            return fallbackResponses.randomElement()!
        }

        do {
            let session = LanguageModelSession(instructions: """
                You are Thingy, a warm companion for school teachers.
                You respond to their journal entries like a close friend — casual, real, never clinical.
                Do NOT use therapy phrases like "I understand how you feel", "it's okay to", "you've got this", or "you are not alone".
                Do NOT give advice or suggestions.
                Acknowledge what they went through in 1-2 sentences, then naturally close with the affirmation — don't quote it word for word.
                Keep the whole response under 3 sentences, around 50 words.
                """)

            let result = try await session.respond(to: """
                Teacher's name: \(teacherName)
                What they said: "\(transcript)"
                Affirmation to weave in: "\(affirmation)"
                """)
            return result.content

        } catch {
            print("generateThingyResponse failed: \(error)")
            return fallbackResponses.randomElement()!
        }
    }

    func rephraseAffirmation(
        _ affirmation: String,
        teacherName: String,
        whyIStarted: String
    ) async -> String {
        guard available else { return affirmation }

        do {
            let session = LanguageModelSession(instructions: """
                You rephrase teacher affirmations to feel personal and specific.
                Keep the same meaning but make it feel written just for this teacher.
                One sentence only. No filler phrases like "Remember" or "Always know that".
                """)

            let result = try await session.respond(to: """
                Teacher's name: \(teacherName)
                Why they started teaching: "\(whyIStarted)"
                Affirmation to rephrase: "\(affirmation)"
                """)
            return result.content

        } catch {
            print("rephraseAffirmation failed: \(error)")
            return affirmation
        }
    }

    func findMatchingStories(from stories: [Story], labels: [AffirmationLabel]) -> [Story] {
        let labelStrings = labels.map(\.rawValue)
        return stories.filter { story in
            story.labels.contains(where: { labelStrings.contains($0) })
        }
    }
}
