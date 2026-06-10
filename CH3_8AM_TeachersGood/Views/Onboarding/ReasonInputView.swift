//
//  ReasonInputView.swift
//  CH3_8AM_TeachersGood
//
//  Created by Syauqi Auliya M on 26/05/26.
//

import SwiftUI

struct ReasonInputView: View {
    @Environment(\.colorScheme) var colorScheme

    @State private var finishOnboarding = false
    @State private var audioLevels: [CGFloat] = Array(repeating: 10.0, count: 7)
    @State private var currentState: RecordingState = .readyOnboarding
    @State private var showConfirmation = false
    @State private var isOnboarding = true
    
    @State private var speechManager = SpeechRecognitionManager()
    
    // NEW: Dummy state solely designed to appease the RecordView parameter requirements
    @State private var manuallyTypedText: String = ""
    @State private var finalTranscript: String = ""
    
    var body: some View {
        VStack{
            Spacer()
            
            SpeechBubbleView(
                text: currentState.bubbleText,
                tail: .bottomRight
            )

            GifWebView(gifName: currentState.thingyMode )
                .frame(width: 250, height: 250)

            Spacer()
            
            RecordView(
                currentState: $currentState,
                audioLevels: $audioLevels,
                showConfirmation: $showConfirmation,
                isOnboarding: $isOnboarding,
                typedText: $manuallyTypedText
            )
                        
        }
        .background(Color.appBackground.ignoresSafeArea())
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Text("3 of 4")
                    .font(.custom("Futura", size: 14))
                    .foregroundColor(.appPrimaryLight)
                    .opacity(0.4)
            }
            .sharedBackgroundVisibility(.hidden)

        }
        .navigationDestination(isPresented: $finishOnboarding) {
            ThanksView()
        }
        .overlay {
            if showConfirmation {
                ConfirmationOverlayView(
                    isPresented: $showConfirmation,
                    isProcessing: .constant(false),
                    showProgress: false,
                    onConfirm: { finishOnboarding = true }
                )
            }
        }
        .environment(\.colorScheme, colorScheme == .dark ? .light : .dark)
        
        .onChange(of: currentState) {
            Task {
                switch currentState {
                case .recording:
                    await speechManager.startTranscribing()
                    
                case .finishedOnboarding:
                    await speechManager.stopTranscribing()
                    
                    let userTranscript = manuallyTypedText.isEmpty ? speechManager.recognizedText : manuallyTypedText
                    
                    finalTranscript = userTranscript
                    
                    manuallyTypedText = ""
                    
                case .readyOnboarding:
                    await speechManager.stopTranscribing()
                    
                default:
                    break
                }
            }
        }
    }
}

#Preview {
    ReasonInputView()
}
