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
    @State private var currentState: RecordingState = .ready
    @State private var showConfirmation = false
    
    
    @State private var isOnboarding = true
    
    
    var body: some View {
        VStack{
            // PAGE NUMBER
            
            HStack {
                Spacer()
                Text("3 of 4")
                    .font(.custom("Futura", size: 14))
                    .foregroundColor(.appPrimaryLight)
                    .opacity(0.4)
            }
            .padding(.horizontal, 24)
            .padding(.top, 40)
            
            Spacer()
            
            // SPEECH BUBBLESlider
            SpeechBubbleView(
                text: currentState.bubbleText,
                tail: .bottomRight
            )

            //MASCOT
            
          //  MascotView(size: 350)
            GifWebView(gifName: currentState.thingyMode )
                .frame(width: 300, height: 300)

            Spacer()
            
            //RECORD
            RecordView(currentState: $currentState, audioLevels: $audioLevels, showConfirmation: $showConfirmation, isOnboarding: $isOnboarding)
            
                        
        }
        .background(Color.appBackground.ignoresSafeArea())
        .navigationDestination(isPresented: $finishOnboarding) {
            ThanksView()
        }
        .overlay {
            if showConfirmation {
                ConfirmationOverlayView(isPresented: $showConfirmation,
                onConfirm: { finishOnboarding = true }  )
            }
        }
        .environment(\.colorScheme, colorScheme == .dark ? .light : .dark)

    }
}

#Preview {
    ReasonInputView()
}
