//
//  WelcomeView.swift
//  CH3_8AM_TeachersGood
//
//  Created by Syauqi Auliya M on 26/05/26.
//

import SwiftUI

struct WelcomeView: View {
    @State private var stage = 0
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.appBackground.ignoresSafeArea()
                
                // Stage 0 logo
                if stage == 0 {
                    VStack {
                        Spacer()
                        MascotView(size: 250)
                        Text("TrueTeach")
                            .font(.custom("Futura", size: 30))
                            .foregroundColor(.appPrimaryLight)
                        
                        Spacer()
                        
                    }
                }
                
                // Stages 1+ mascot saying things
                if stage >= 1 {
                    VStack(spacing: 24) {
                        Spacer()
                        
                        SpeechBubbleView(text: bubbleText, tail: .bottomRight)
                            .padding(.horizontal, 40)
                            .id(stage)
                            .transition(.opacity)
                        
                        MascotView(size: 300)
                        
                        Spacer()
                        
                        NavigationLink {
                            NameInputView(teacherName: .constant("")) {}
                        } label: {
                            Text("Let's get started!")
                                .font(.system(size: 17, weight: .semibold))
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 20)
                                .background(Color.appPrimaryLight)
                                .cornerRadius(20)
                        }
                        .padding(.horizontal, 24)
                        .opacity(stage >= 4 ? 1 : 0)
                        .disabled(stage < 4)
                        .animation(.easeInOut, value: stage)
                        .padding(.bottom, 32)
                    }
                }
            }
            .onAppear { startSequence() }
        }
    }
    
    var bubbleText: String {
        switch stage {
        case 1: return "\nWelcome!\n"
        case 2: return "I'm Thingy. My mission is to help lift up your mood."
        case 3: return "Before that, I would like to ask you some questions."
        default: return "Please answer based on your current conditions, okay?"
        }
    }
    
    func startSequence() {
        Task {
            try? await Task.sleep(for: .seconds(1.5))
            withAnimation { stage = 1 }
            try? await Task.sleep(for: .seconds(2))
            withAnimation { stage = 2 }
            try? await Task.sleep(for: .seconds(2))
            withAnimation { stage = 3 }
            try? await Task.sleep(for: .seconds(2))
            withAnimation { stage = 4 }
        }
    }
}

#Preview {
    WelcomeView()
}
