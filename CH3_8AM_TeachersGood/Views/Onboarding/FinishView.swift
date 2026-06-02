//
//  FinishView.swift
//  CH3_8AM_TeachersGood
//
//  Created by Syauqi Auliya M on 02/06/26.
//


import SwiftUI


struct FinishView: View {
    @State private var stage = 1
    @State private var navigateToHome = false

    var body: some View {
        ZStack {
            Color.appBackground.ignoresSafeArea()

            //
            if stage >= 1 {
                VStack(spacing: 24) {
                    Spacer()
                    SpeechBubbleView(text: bubbleText, tail: .bottomRight)
                        .padding(.horizontal, 40)
                        .id(
                            stage
                        ) // forces transition to re-trigger on text change
                        .transition(.opacity)

                    MascotView(size: 300)
                    Spacer()
                        
                    if stage == 3 {
                        QuoteView()
                    }
                }
                .transition(.opacity)
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationDestination(isPresented: $navigateToHome) {
            QuoteView()
                .navigationBarBackButtonHidden(true)
        }
        .onAppear { startSequence() }
    }

    var bubbleText: String {
        switch stage {
        case 1: return "Thank you for answering!"
        default: return "Personalizing the app for you..."
        }
    }

    func startSequence() {
        Task {
            try? await Task.sleep(for: .seconds(1.5))
            withAnimation { stage = 2 }
            try? await Task.sleep(for: .seconds(1.5))
            withAnimation { navigateToHome = true }
        }
    }
}

#Preview {
    FinishView()
}
