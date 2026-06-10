//
//  FinishView.swift
//  CH3_8AM_TeachersGood
//
//  Created by Syauqi Auliya M on 02/06/26.
//

import SwiftUI
internal import Combine

struct FinishView: View {
    @AppStorage("hasCompletedOnboarding") private var hasCompletedOnboarding: Bool = false

    @State private var stage = 1
    @State private var navigateToHome = false
    @State private var progress: CGFloat = 0.0
    
    @Environment(\.accessibilityVoiceOverEnabled) var isVoiceOverEnabled
    
    let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        ZStack {
            Color.appBackground.ignoresSafeArea()
            
            if stage >= 1 {
                VStack(spacing: 24) {
                    Spacer()
                    
                    SpeechBubbleView(text: bubbleText, tail: .bottomRight)
                        .padding(.horizontal, 40)
                        .padding(.top, 50)
                        .id(stage) // Forces transition to re-trigger on text change
                        .transition(.opacity)
                    
                    GifWebView(gifName: "ThingySmile")
                        .frame(width: 250, height: 250)
                    
                    // REAL PROGRESS BAR
                    GeometryReader { proxy in
                        ZStack(alignment: .leading) {
                            // Track
                            Capsule()
                                .fill(Color.appPrimaryLight)
                                .opacity(stage >= 2 ? 0.15 : 0)
                                .frame(height: 5)
                            // Fill
                            Capsule()
                                .fill(Color.appPrimaryLight)
                                .opacity(stage >= 2 ? 1 : 0)
                                .frame(
                                    width: proxy.size.width * progress,
                                    height: 5
                                )
                        }
                    }
                    .frame(height: 5)
                    .padding(.horizontal, 60)
                    // Pushed bottom padding down to align with upstream's filler layout intention
                    .padding(.bottom, 20)
                    .transition(.opacity)
                    .accessibilityHidden(true)
                    
                    Spacer()
                    
                    Text("Tap to continue")
                        .font(.system(size: 14))
                        .foregroundColor(.appTextSecondary)
                        .opacity(stage == 1 ? 1 : 0)
                        .animation(.easeInOut, value: stage)
                        .padding(.bottom, 40)
                }
            }
        }
        .contentShape(Rectangle())
        .onTapGesture {
            guard stage == 1 else { return }
            startLoading()
        }
        .navigationBarBackButtonHidden(true)
        .navigationDestination(isPresented: $navigateToHome) {
            AffirmationsView()
                .navigationBarBackButtonHidden(true)
        }
    }

    var bubbleText: String {
        switch stage {
        case 1: return "We will meet again later. Feel free to reach out whenever you need."
        default: return "Adjusting the experience just for you..."
        }
    }

    func startLoading() {
        Task {
            // Determine delays dynamically based on current accessibility requirements
            let initialDelay = isVoiceOverEnabled ? 5.0 : 3.0
            let loadingDelay = isVoiceOverEnabled ? 3.5 : 2.0
            
            try? await Task.sleep(for: .seconds(initialDelay))
            
            withAnimation { stage = 2 }
            
            if isVoiceOverEnabled {
                UIAccessibility.post(notification: .announcement, argument: "Thingy says, \(bubbleText)")
            }
            
            withAnimation(.linear(duration: loadingDelay)) { progress = 1.0 }
            try? await Task.sleep(for: .seconds(loadingDelay))
            
            withAnimation(.easeInOut(duration: 0.5)) {
                hasCompletedOnboarding = true
            }
            
            // Trigger the stashed navigation routing after onboarding concludes
            navigateToHome = true
        }
    }
}

#Preview {
    FinishView()
}
