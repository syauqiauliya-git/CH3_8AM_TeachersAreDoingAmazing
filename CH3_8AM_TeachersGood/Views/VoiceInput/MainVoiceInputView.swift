//
//  MainVoiceInputView.swift
//  CH3_8AM_TeachersGood
//
//  Created by Ahmad Taufiq Hidayat on 26/05/26.
//

import SwiftUI
internal import Combine

struct MainVoiceInputView: View {
    
    @State private var currentState: RecordingState = .ready
    @State private var audioLevels: [CGFloat] = Array(repeating: 10.0, count: 7)
    @State private var showConfirmation = false
    
    @State private var speechManager = SpeechRecognitionManager()
    
    @State private var isOnboarding: Bool = false
    
    var body: some View {
        VStack {
            Spacer()
                .frame(height: 80)
            
            SpeechBubbleView(
                text: currentState.bubbleText,
                tail: .bottomRight
            )
            
            MascotView(size: 300)
            
            if currentState == .recording || currentState == .finished {
                ScrollView {
                    Text(speechManager.transcript)
                        .font(.body)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                }
                .frame(maxHeight: 100)
            }
                        
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
                    await speechManager.startTranscribing()
                case .finished:
                    await speechManager.stopTranscribing()
                case .ready:
                    await speechManager.stopTranscribing()
                case .next:
                    await speechManager.stopTranscribing()
                }
            }
        }
    }
}

#Preview {
    MainVoiceInputView()
}
