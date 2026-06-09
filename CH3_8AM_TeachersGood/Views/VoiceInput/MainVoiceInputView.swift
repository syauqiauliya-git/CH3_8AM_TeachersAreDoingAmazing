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
    @Query var stories: [Story] // Underlying database records
        
    @State private var currentState: RecordingState = .ready
    @State private var audioLevels: [CGFloat] = Array(repeating: 10.0, count: 7)
    @State private var showConfirmation = false
    
    @State private var speechManager = SpeechRecognitionManager()
    @State private var isOnboarding: Bool = false
    
    @State private var dynamicBubbleText: String? = nil
    @State private var suggestedStories: [Story] = []
    
    // NEW: Handles full context sheet launching straight from this voice orchestrator view
    @State private var sheetSelectedStory: Story?
        
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
                RecordView(currentState: $currentState, audioLevels: $audioLevels, showConfirmation: $showConfirmation, isOnboarding: $isOnboarding)
            } else if currentState == .next {
                // Pass binding connection so row actions filter straight into this base view hierarchy
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
        // Sheet handles instant lookups directly over your tracking bindings
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

                    let userTranscript = speechManager.recognizedText
                    let teacherName = teachers.first?.name ?? "Teacher"
                    let currentAffirmation = affirmations.randomElement()?.tokens
                        .sorted(by: { $0.order < $1.order })
                        .map(\.text)
                        .joined(separator: " ") ?? "You are doing great."

                    do {
                        let labels = try await InferenceService.shared.extractLabels(from: userTranscript)
                        var matched = InferenceService.shared.findMatchingStories(from: stories, labels: labels)
                        
                        // MANDATORY GUARD: If no direct matches are discovered, populate
                        // using basic baseline elements from the database as a safe fallback
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
                            // Ensure fallback stories are loaded even on network/inference error bounds
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
        }
    }
}
