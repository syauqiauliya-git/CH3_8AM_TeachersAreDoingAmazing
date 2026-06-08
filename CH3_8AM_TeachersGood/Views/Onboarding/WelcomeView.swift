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
                // Stage 0 logo
                if stage == 0 {
                    VStack {
                        Spacer()
                        MascotView(size: 250)
                        //  GifWebView(gifName: "ThingyIdle")
                        Text("SolacEd")
                            .font(.custom("Futura", size: 30))
                            .foregroundColor(.appTextAlt)
                        
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
                        
                        //MascotView(size: 350)
                        GifWebView(gifName: ThingyState.idle.mode)
<<<<<<< Updated upstream
                            .frame(width: 400, height: 240)
                        
=======
                            .frame(width: 300, height: 300)
                                                
>>>>>>> Stashed changes
                        Spacer()
                        
                        NavigationLink {
                            //                            NameInputView(teacherName: .constant("")) {}
                            NameInputView()
                        } label: {
                            Text("Let's get started!")
                                .font(.system(size: 17, weight: .semibold))
                                .foregroundColor(.appBackground)
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 20)
                                .background(Color.startSendRecord)
                                .cornerRadius(20)
                        }
                        .padding(.horizontal, 35)
                        .padding(.top, 16)
                        .padding(.bottom, 32)
                        .opacity(stage >= 5 ? 1 : 0)
                        .disabled(stage < 5)
                        .animation(.easeInOut, value: stage)
                    }
                }
            }
            .onAppear { startSequence() }
            .background(Color.appBackground.ignoresSafeArea())

        }
    }
    
    
    var bubbleText: String {
        switch stage {
        case 1: return "\nHey!\n"
        case 2: return "I'm Thingy. I'm going to help you lift up your mood!!"
        case 3: return "In order to help you, I want to ask you some questions"
        case 4: return "Be honest and sincere. I’ll keep it between us."
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
            try? await Task.sleep(for: .seconds(2))
            withAnimation { stage = 5 }
        }
    }
}

#Preview {
    WelcomeView()
}
