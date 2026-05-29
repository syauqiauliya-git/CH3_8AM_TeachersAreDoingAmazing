//
//  ReasonInputView.swift
//  CH3_8AM_TeachersGood
//
//  Created by Syauqi Auliya M on 26/05/26.
//

import SwiftUI

struct ReasonInputView: View {
    
    @State private var isRecording = false
    @State private var audioLevels: [CGFloat] = Array(repeating: 10.0, count: 7)
    @State private var currentState: RecordingState = .ready
    @State private var showConfirmation = false
    
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
            .padding(.vertical, 50)
            
            Spacer()
            
            // SPEECH BUBBLESlider(value: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Value@*/.constant(10)/*@END_MENU_TOKEN@*/)
                        
            SpeechBubbleView(text: "Why did you start teaching?", tail: .bottomLeft)
            
            //MASCOT
            
            MascotView(size: 300)
                        
            //RECORD
            RecordView(currentState: $currentState, audioLevels: $audioLevels, showConfirmation: $showConfirmation)
            
            
            //PLACEHOLDER CONTINUE BUTTON WHILE WAITING FOR THE COMPLETE SCREEN DESIGNS
            NavigationLink {
                MotivationInputView()
            } label: {
                Text("Continue")
                    .font(.system(size: 17, weight: .semibold))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 20)
                    .background(Color.appPrimary)
            }
            .cornerRadius(20)
            .padding(.horizontal, 24)
            .padding(.top, 16)
            .padding(.bottom, 32)
        }
        .background(Color.appBackground)
        .overlay {
            if showConfirmation {
                ConfirmationOverlayView(isPresented: $showConfirmation)
                    .transition(.opacity.combined(with: .scale(scale: 0.92)))
            }
        }
    }
}

#Preview {
    ReasonInputView()
}
