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

                    Spacer()
                    
                    // ZStack to cleanly swap the bottom layout elements based on the current stage
                    ZStack(alignment: .bottom) {
                        
                        // STAGE 3: REAL PROGRESS BAR
                        GeometryReader { proxy in
                            ZStack(alignment: .leading) {
                                Capsule()
                                    .fill(Color.appPrimaryLight)
                                    .opacity(stage >= 3 ? 0.15 : 0)
                                    .frame(height: 5)
                                Capsule()
                                    .fill(Color.appPrimaryLight)
                                    .opacity(stage >= 3 ? 1 : 0)
                                    .frame(
                                        width: proxy.size.width * progress,
                                        height: 5
                                    )
                            }
                        }
                        .frame(height: 5)
                        .padding(.horizontal, 60)
                        .padding(.bottom, 150)
                        .opacity(stage == 3 ? 1 : 0)
                        .animation(.easeInOut, value: stage)
                        .accessibilityHidden(true)
                    
                                                
                        // STAGE 2: APPLE INTELLIGENCE PROMPT
                        if stage == 2 {
                            VStack(spacing: 16) {
                                HStack(alignment: .top, spacing: 4) {
                                    Image(systemName: "info.circle")
                                    Text("Apple Intelligence is supported on iPhone 15 Pro models and all iPhone 16 models or later.")
                                }
                                .font(.custom("Nunito-Medium", size: 13))
                                .foregroundColor(.appPrimaryLight)
                                .opacity(0.6)
                                .padding(.horizontal, 20)
                                
                                Button(action: {
                                    // Deep link directly to the iOS Settings app
                                    if let url = URL(string: UIApplication.openSettingsURLString) {
                                        UIApplication.shared.open(url)
                                    }
                                    startLoading()
                                }) {
                                    Text("Go to Settings")
                                        .font(.system(size: 17, weight: .semibold))
                                        .foregroundColor(.appBackground)
                                        .frame(maxWidth: .infinity)
                                        .padding(.vertical, 16)
                                        .background(Color.startSendRecord)
                                        .cornerRadius(20)
                                }
                                
                                Button(action: {
                                    startLoading()
                                }) {
                                    Text("Skip")
                                        .font(.system(size: 17, weight: .semibold))
                                        .foregroundColor(.startSendRecord)
                                        .frame(maxWidth: .infinity)
                                        .padding(.vertical, 16)
                                        .background(Color.clear)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 20)
                                                .stroke(Color.startSendRecord, lineWidth: 1)
                                        )
                                }
                            }
                            .padding(.horizontal, 35)
                            .padding(.bottom, 32)
                            .transition(.opacity.combined(with: .move(edge: .bottom)))
                        }
                    }
                    
                }
            }
        }
        .contentShape(Rectangle())
        .onTapGesture {
            // Only allow standard screen taps to progress Stage 1
            guard stage == 1 else { return }
            withAnimation { stage = 2 }
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
        case 2: return "For a better experience, please turn on Apple Intelligence, if available on your device."
        default: return "Adjusting the experience just for you..."
        }
    }

    func startLoading() {
        // Immediately progress to the final loading state
        withAnimation { stage = 3 }
        
        Task {
            let loadingDelay = isVoiceOverEnabled ? 3.5 : 2.0
            
            if isVoiceOverEnabled {
                UIAccessibility.post(notification: .announcement, argument: "Thingy says, \(bubbleText)")
            }
            
            withAnimation(.linear(duration: loadingDelay)) { progress = 1.0 }
            try? await Task.sleep(for: .seconds(loadingDelay))
            
            withAnimation(.easeInOut(duration: 0.5)) {
                hasCompletedOnboarding = true
            }
            
            navigateToHome = true
        }
    }
}

#Preview {
    FinishView()
}
