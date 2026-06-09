//
//  MainVoiceInputView.swift
//  CH3_8AM_TeachersGood
//
//  Created by Ahmad Taufiq Hidayat on 26/05/26.
//

import SwiftUI
internal import Combine
import SwiftData

struct MainVoiceInputView: View {
    @Query var teachers: [Teacher]
    @Query var affirmations: [Affirmation]
    @Query var stories: [Story]
        
    @State private var currentState: RecordingState = .ready
    @State private var audioLevels: [CGFloat] = Array(repeating: 10.0, count: 7)
    @State private var showConfirmation = false
    
    @State private var speechManager = SpeechRecognitionManager()
    @State private var isOnboarding: Bool = false
    
    @State private var dynamicBubbleText: String? = nil
    @State private var suggestedStories: [Story] = []
    
    @State private var sheetSelectedStory: Story?
    
    // NEW: Captures manually entered transcripts to override audio results
    @State private var manuallyTypedText: String = ""
        
    var body: some View {
        VStack {
            Spacer()
                .frame(height: currentState == .next ? 20 : 80)
            
            SpeechBubbleView(
                text: dynamicBubbleText ?? currentState.bubbleText,
                tail: .bottomRight,
                customMaxWidth: 250
            )
            
            Spacer()
            
            GifWebView(gifName: currentState.thingyMode )
                .frame(
                    width: currentState == .next ? 150 : 250,
                    height: currentState == .next ? 150 : 250
                )

            Spacer()
            
            if currentState == .ready || currentState == .recording || currentState == .finished {
                // Pass the binding into the child component
                RecordView(currentState: $currentState, audioLevels: $audioLevels, showConfirmation: $showConfirmation, isOnboarding: $isOnboarding, typedText: $manuallyTypedText)
            } else if currentState == .next {
                SuggestedStoriesView(stories: suggestedStories, externalSelectedStory: $sheetSelectedStory)
            }
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background {
            Color.appBackground
                .ignoresSafeArea(.all, edges: [.bottom, .top])
        }
        .overlay {
            if showConfirmation {
                ConfirmationOverlayView(isPresented: $showConfirmation, onConfirm: {})
            }
        }
        .sheet(item: $sheetSelectedStory) { story in
            ArticleSheetView(story: story)
        }
        .onChange(of: currentState) {
            Task {
                switch currentState {
                case .recording:
                    dynamicBubbleText = nil
                    await speechManager.startTranscribing()
                    
                case .finished, .finishedOnboarding:
                    await speechManager.stopTranscribing()
                    dynamicBubbleText = nil
                    
                case .next:
                    await speechManager.stopTranscribing()
                    dynamicBubbleText = "Give me a second to process that..."

                    // INFERENCE SWITCH: Evaluate typed text first, utilizing the voice manager as a secondary fallback
                    let userTranscript = manuallyTypedText.isEmpty ? speechManager.recognizedText : manuallyTypedText
                    
                    // Clear the buffer immediately to prevent bleeding into subsequent sessions
                    manuallyTypedText = ""
                    
                    let teacherName = teachers.first?.name ?? "Teacher"
                    let currentAffirmation = affirmations.randomElement()?.tokens
                        .sorted(by: { $0.order < $1.order })
                        .map(\.text)
                        .joined(separator: " ") ?? "You are doing great."

                    do {
                        let labels = try await InferenceService.shared.extractLabels(from: userTranscript)
                        var matched = InferenceService.shared.findMatchingStories(from: stories, labels: labels)
                        
                        if matched.isEmpty {
                            matched = Array(stories.shuffled().prefix(2))
                        }
                        
                        let finalSelection = Array(matched.prefix(2))
                        
                        await MainActor.run {
                            suggestedStories = finalSelection
                        }

                        let response = try await InferenceService.shared.generateThingyResponse(
                            transcript: userTranscript,
                            affirmation: currentAffirmation,
                            teacherName: teacherName
                        )
                        await MainActor.run {
                            dynamicBubbleText = response
                        }
                    } catch {
                        await MainActor.run {
                            if suggestedStories.isEmpty {
                                suggestedStories = Array(stories.prefix(2))
                            }
                            dynamicBubbleText = "I heard you, but my brain is a little foggy right now. Here are some comforting stories for you!"
                        }
                    }
                    
                case .ready, .readyOnboarding:
                    await speechManager.stopTranscribing()
                    dynamicBubbleText = nil
                }
            }
            
            if dynamicBubbleText == nil {
                UIAccessibility.post(notification: .announcement, argument: currentState.bubbleText)
            }
        }
    }
}

#Preview("Main Voice Input") {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    
    // 1. Register all the models your view and its child views rely on
    let container = try! ModelContainer(
        for: Teacher.self, Affirmation.self, AffirmationToken.self, Story.self,
        configurations: config
    )
    
    let context = container.mainContext
    
    // 2. Insert a mock Teacher so the inference engine has a name to use
    // (Adjust the properties if your Teacher model requires different initialization)
    context.insert(Teacher(
        name: "Coki",
        affirmationInterval: "onetime"
    ))
    
    // 3. Insert a mock Story so the SuggestedStoriesView has fallback data
    context.insert(Story(
        title: "A Rare Dedication to Education",
        mdFileName: "rare-dedication",
        image: "placeholder-article-pic",
        summary: "The inspiring story of a veteran teacher.",
        isBookmarked: false,
        isFeatured: true,
        storyDate: Date()
    ))
    
    // 4. Insert a mock Affirmation so the response generator doesn't fail
    context.insert(
        Affirmation(tokens: [
            AffirmationToken(text: "You", style: .normal, order: 0),
            AffirmationToken(text: "are", style: .normal, order: 1),
            AffirmationToken(text: "doing", style: .purple, order: 2),
            AffirmationToken(text: "great.", style: .orange, order: 3)
        ])
    )
    
    return MainVoiceInputView()
        .modelContainer(container)
}
