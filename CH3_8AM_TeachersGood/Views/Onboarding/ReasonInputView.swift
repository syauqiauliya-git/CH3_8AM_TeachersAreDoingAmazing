//
//  ReasonInputView.swift
//  CH3_8AM_TeachersGood
//
//  Created by Syauqi Auliya M on 26/05/26.
//

import SwiftUI

struct ReasonInputView: View {
    
    @State private var isRecording = false
    @State private var finishOnboarding = false
    @State private var audioLevels: [CGFloat] = Array(repeating: 10.0, count: 7)
    @State private var currentState: RecordingState = .ready
    @State private var showConfirmation = false
    
    @State private var isOnboarding = true
    
    
    var body: some View {
        VStack{
            // PAGE NUMBER
            
            HStack {
                Spacer()
                Text("3 of 4")
                    .font(.system(size: 14))
                    .foregroundColor(.appTextSecondary)
            }
            .padding(.horizontal, 24)
            .padding(.top, 16)
            
            Spacer()
            
            // SPEECH BUBBLESlider
            SpeechBubbleView(
                text: "What made you become a teacher?",
                tail: .bottomRight
            )

            //MASCOT
            
            MascotView(size: 250)
            
            Spacer()
            
            //RECORD
            RecordView(currentState: $currentState, audioLevels: $audioLevels, showConfirmation: $showConfirmation, isOnboarding: $isOnboarding)
            
            
            Spacer()
            
        }
        .background(Color.appBackground)
        .navigationDestination(isPresented: $finishOnboarding) {
            ThanksView()
        }
        .overlay {
            if showConfirmation {
                ConfirmationOverlayView(isPresented: $showConfirmation,
                onConfirm: { finishOnboarding = true }  )
            }
        }
    }
}

#Preview {
    ReasonInputView()
}
