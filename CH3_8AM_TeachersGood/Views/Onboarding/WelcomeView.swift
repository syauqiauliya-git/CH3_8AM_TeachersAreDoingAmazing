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
                    Image("Motivateach")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 300)
                        .transition(.opacity)
                }

                // Stages 1+ mascot saying things
                if stage >= 1 {
                    VStack(spacing: 24) {
                        Spacer()
                        SpeechBubbleView(text: bubbleText, tail: .bottomLeft)
                            .padding(.horizontal, 40)
                            .id(stage) // forces transition to re-trigger on text change
                            .transition(.opacity)

                        MascotView(size: 300)
                        Spacer()

                        // Stage 4 next button
                        if stage >= 4 {
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
                            .transition(.opacity)
                        }
                    }
                    .transition(.opacity)
                }
            }
            .onAppear { startSequence() }
        }
    }

    var bubbleText: String {
        switch stage {
        case 1: return "Welcome!"
        case 2: return "I'm Thingy. My mission\nis to help lift up your \nmood."
        case 3: return "Before that, I'm\ngoing to ask you\nsome questions."
        default: return "Please answer based\non your current\nconditions, okay?"
        }
    }

    func startSequence() {
        Task {
            try? await Task.sleep(for: .seconds(1))
            withAnimation { stage = 1 }
            try? await Task.sleep(for: .seconds(1.5))
            withAnimation { stage = 2 }
            try? await Task.sleep(for: .seconds(1.5))
            withAnimation { stage = 3 }
            try? await Task.sleep(for: .seconds(1.5))
            withAnimation { stage = 4 }
        }
    }
}

#Preview {
    WelcomeView()
}
