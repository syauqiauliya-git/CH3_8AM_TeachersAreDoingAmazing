
//  InferenceService.swift
//  CH3_8AM_TeachersGood
//
//  Created by Syauqi Auliya M on 04/06/26.
//

import Foundation
import FoundationModels

//apple intelligence generable output
@Generable
struct LabelExtractionResult {
    @Guide(description: "Emotional and professional themes present in the transcript. Only pick labels clearly supported by what the teacher said.")
    var labels: [AffirmationLabel]
}

class InferenceService {
    static let shared = InferenceService()

    private let available: Bool

    init() {
        available = SystemLanguageModel.default.isAvailable
    }

    // rxtractingin labels from transcript

    func extractLabels(from transcript: String) async throws -> [AffirmationLabel] {
        guard available else {
            // Mock for simulator
            return [.patience, .selfCare, .mistake]
        }

        let session = LanguageModelSession(instructions: """
            You analyze voice journal entries from school teachers.
            Extract the most relevant emotional and professional themes.
            Return a MAXIMUM of 3 labels. Only include themes that are clearly and strongly present.
            If in doubt, leave it out.
            """)

        let result = try await session.respond(
            to: "Extract the relevant labels from this journal entry: \"\(transcript)\"",
            generating: LabelExtractionResult.self
        )

        return result.content.labels
    }

    // generate Thingy response using transcript + affirmation

    func generateThingyResponse(
        transcript: String,
        affirmation: String,
        teacherName: String
    ) async throws -> String {
        guard available else {
            return "That sounds like a really tough day, \(teacherName). \(affirmation)"
        }

        let session = LanguageModelSession(instructions: """
            You are Thingy, a warm companion for school teachers.
            You respond to their journal entries like a close friend would — casual, real, never clinical.
            Do NOT use therapy phrases like "I understand how you feel", "it's okay to", "you've got this", or "you are not alone".
            Do NOT give advice or suggestions.
            Just acknowledge what they went through in 1-2 sentences, then naturally close with the affirmation — don't quote it word for word, make it feel like your own thought.
            Keep the whole response under 3 sentences, around 50 words. Be mindful of unnecessary spacings and white space.
            """)

        let result = try await session.respond(to: """
            Teacher's name: \(teacherName)
            What they said: "\(transcript)"
            Affirmation to weave in: "\(affirmation)"
            """)

        return result.content
    }

    // rephrase affirmation for daily quote

    func rephraseAffirmation(
        _ affirmation: String,
        teacherName: String,
        whyIStarted: String
    ) async throws -> String {
        guard available else {
            return affirmation
        }

        let session = LanguageModelSession(instructions: """
            You rephrase teacher affirmations to feel personal and specific.
            Keep the same meaning but make it feel like it was written just for this teacher.
            One sentence only. Do not add filler phrases like "Remember" or "Always know that".
            """)

        let result = try await session.respond(to: """
            Teacher's name: \(teacherName)
            Why they started teaching: "\(whyIStarted)"
            Affirmation to rephrase: "\(affirmation)"
            """)

        return result.content
    }
    
    func findMatchingStories(from stories: [Story], labels: [AffirmationLabel]) -> [Story] {
        let labelStrings = labels.map(\.rawValue)
        return stories.filter { story in
            story.labels.contains(where: { labelStrings.contains($0) })
        }
    }
}
