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
        
    @State private var currentState: RecordingState = .ready
    @State private var audioLevels: [CGFloat] = Array(repeating: 10.0, count: 7)
    @State private var showConfirmation = false
    
    @State private var speechManager = SpeechRecognitionManager()
    @State private var isOnboarding: Bool = false
    
    @State private var dynamicBubbleText: String? = nil
        
    var body: some View {
        VStack {
            
            // 1. Dynamic Top Spacer: Collapses from 80 to 20 during the AI response
            // to allow the speech bubble to safely expand upwards.
            Spacer()
                .frame(height: currentState == .next ? 20 : 80)
            
            SpeechBubbleView(
                text: dynamicBubbleText ?? currentState.bubbleText,
                tail: .bottomRight
            )
            
            Spacer()
            
            // 2. Dynamic Mascot: Shrinks from 250x250 down to 150x150
            // exclusively when moving into the .next state.
            GifWebView(gifName: currentState.thingyMode )
                .frame(
                    width: currentState == .next ? 150 : 250,
                    height: currentState == .next ? 150 : 250
                )

            Spacer()
            
            if currentState == .ready || currentState == .recording || currentState == .finished {
                RecordView(currentState: $currentState, audioLevels: $audioLevels, showConfirmation: $showConfirmation, isOnboarding: $isOnboarding)
            } else if currentState == .next {
                SuggestedStoriesView()
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
                    let currentAffirmation = affirmations.randomElement()?.tokens.map { $0.text }.joined(separator: " ") ?? "You are doing great."
                    
                    do {
                        let response = try await InferenceService.shared.generateThingyResponse(
                            transcript: userTranscript,
                            affirmation: currentAffirmation,
                            teacherName: teacherName
                        )
                        
                        await MainActor.run {
                            dynamicBubbleText = response
                            UIAccessibility.post(notification: .announcement, argument: response)
                        }
                    } catch {
                        await MainActor.run {
                            dynamicBubbleText = "I heard you, but my brain is a little foggy right now. Thank you for sharing!"
                            UIAccessibility.post(notification: .announcement, argument: dynamicBubbleText)
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
