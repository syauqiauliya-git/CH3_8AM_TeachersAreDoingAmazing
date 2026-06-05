//
//  ThanksView.swift
//  CH3_8AM_TeachersGood
//
//  Created by Syauqi Auliya M on 02/06/26.
//


import SwiftUI

struct ThanksView: View {
    
    @State private var stage = 0

    var body: some View {
        
        VStack {
            
            if stage >= 0 {
                VStack(spacing: 24) {
                    Spacer()
                    SpeechBubbleView(text: bubbleText, tail: .bottomRight)
                        .padding(.horizontal, 40)
                        .id(
                            stage
                        ) // forces transition to re-trigger on text change
                        .transition(.opacity)
                    
                    MascotView(size: 300, currentMode: stage >= 1 ? .normal : .blink)
                    
                    Spacer()
                }
                .transition(.opacity)
                
                NavigationLink {
                    IntervalInputView()
                } label: {
                    Text("Continue")
                        .font(.custom("Futura", size: 20))
                        .foregroundColor(.appTextPrimary)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 15)
                        .background(Color.appPrimaryLight)
                        .opacity(stage == 1 ? 1.0 : 0.0)
                }
                .cornerRadius(20)
                .padding(.horizontal, 35)
                .padding(.top, 16)
                .padding(.bottom, 32)
                .disabled(stage != 1)
            }
            
            
        }
        .background(Color.appBackground)
        .onAppear { startSequence() }

        
    }
    
    var bubbleText: String {
        switch stage {
        case 1: return "I'll be checking up on you every now and then"
        default: return "I'm always here to listen. Thank you for sharing"
        }
    }
    
    func startSequence() {
        Task {
            try? await Task.sleep(for: .seconds(1.5))
            withAnimation { stage = 1 }
        }
    }
    
}

#Preview {
    ThanksView()
}
