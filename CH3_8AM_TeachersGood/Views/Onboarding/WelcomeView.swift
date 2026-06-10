//
//  WelcomeView.swift
//  CH3_8AM_TeachersGood
//
//  Created by Syauqi Auliya M on 26/05/26.
//

import SwiftUI

struct WelcomeView: View {
    @State private var stage = 0
    
    @Environment(\.accessibilityVoiceOverEnabled) var isVoiceOverEnabled
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.appBackground.ignoresSafeArea()

                if stage == 0 {
                    VStack {
                        Spacer()
                        MascotView(size: 250)
                        Text("SolacEd")
                            .font(.custom("Futura", size: 30))
                            .foregroundColor(.appTextAlt)
                        Spacer()
                    }
                }

                if stage >= 1 {
                    VStack(spacing: 24) {
                        Spacer()

                        SpeechBubbleView(text: bubbleText, tail: .bottomRight)
                            .padding(.horizontal, 40)
                            .id(stage)
                            .transition(.opacity)

                        GifWebView(gifName: ThingyState.idle.mode)
                            .frame(width: 250, height: 250)
                            .accessibilityElement(children: .ignore)
                            .accessibilityLabel("Thingy is idling")
                            .accessibilityAddTraits(.isImage)

                        Spacer()

                        // Only shown at stage 1 to teach the mechanic
                        Text("Tap to continue")
                            .font(.custom("Futura", size: 13))
                            .foregroundColor(.appTextAlt)
                            .opacity(stage == 1 ? 0.5 : 0)
                            .animation(.easeInOut, value: stage)

                        NavigationLink {
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
                        .padding(.bottom, 32)
                        .opacity(stage >= 5 ? 1 : 0)
                        .disabled(stage < 5)
                        .animation(.easeInOut, value: stage)
                    }
                }
            }
            // Captures taps across the entire screen real estate
            .contentShape(Rectangle())
            .onTapGesture {
                guard stage < 5 else { return }
                withAnimation { stage += 1 }
            }
            .background(Color.appBackground.ignoresSafeArea())
            .onAppear {
                // Determines initialization trajectory based on accessibility status
                if isVoiceOverEnabled {
                    stage = 5
                } else {
                    startSequence()
                }
            }
        }
    }
    
    var bubbleText: String {
        if isVoiceOverEnabled {
            return "Hey! I'm Thingy, an orange blob who will accompany you on your journey to better days. I'm going to help you lift up your mood!! In order to help you, I want to ask you some questions. Be honest and sincere. I’ll keep it between us. Please answer based on your current conditions, okay?"
        }
        
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
        }
    }
}

#Preview {
    WelcomeView()
}
