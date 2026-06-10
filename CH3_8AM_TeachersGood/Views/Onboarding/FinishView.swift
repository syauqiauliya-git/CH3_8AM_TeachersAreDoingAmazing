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
            
            
            //
            if stage >= 1 {
                VStack(spacing: 24) {
                    Spacer()
                    SpeechBubbleView(text: bubbleText, tail: .bottomRight)
                        .padding(.horizontal, 40)
                        .padding(.top, 50)
                        .id(
                            stage
                        ) // forces transition to re-trigger on text change
                        .transition(.opacity)
                    
                    // MascotView(size: 300, currentMode: stage >= 2 ? .normal : .blink)
                    GifWebView(gifName: "ThingySmile")
                        .frame(width: 250, height: 250)
                    
                    // FILLER FOR LAYOUTING
                    if stage < 2 {
                        ZStack(alignment: .leading) {
                            // Track
                            Capsule()
                                .fill(Color.appPrimaryLight)
                                .opacity(0)
                                .frame(height: 5)
                            // Fill
                            Capsule()
                                .fill(Color.appPrimaryLight)
                                .opacity(0)
                                .frame(
                                    width: 4,
                                    height: 5
                                )
                        }
                        .accessibilityHidden(true)
                    }
                    
                    //REAL PROGRESS BAR
                    
                    GeometryReader { proxy in
                        ZStack(alignment: .leading) {
                            // Track
                            Capsule()
                                .fill(Color.appPrimaryLight)
                                .opacity(stage == 2 ? 0.15 : 0)
                                .frame(height: 5)
                            // Fill
                            Capsule()
                                .fill(Color.appPrimaryLight)
                                .frame(
                                    width: proxy.size.width * progress,
                                    height: 5
                                )
                        }
                    }
                    .frame(height: 5)
                    .padding(.horizontal, 60)
                    .padding(.bottom, 100)
                    .transition(.opacity)
                    .accessibilityHidden(true)
                    
                    Spacer()
                    
                    if stage == 3 {
                        AffirmationsView()
                    }
                }
                .transition(.opacity)
            }
        }
        .navigationBarBackButtonHidden(true)
//        .navigationDestination(isPresented: $navigateToHome) {
//            AffirmationsView()
//                .navigationBarBackButtonHidden(true)
//        }
        .onAppear { startSequence() }
    }
    
    var bubbleText: String {
        switch stage {
        case 1: return "We will meet again later. Feel free to reach out to me whenever you need"
        default: return "Adjusting the experience just for you"
        }
    }
    
    //    func startSequence() {
    //        Task {
    //            //Later put actual async loading thing here for the app
    //            try? await Task.sleep(for: .seconds(1.5))
    //            withAnimation { stage = 2 }
    //            withAnimation(.linear(duration: 1.5)) { progress = 1.0 }
    //            try? await Task.sleep(for: .seconds(1.5))
    //            navigateToHome = true
    //        }
    //    }
    
    func startSequence() {
        Task {
            let initialDelay = isVoiceOverEnabled ? 5.0 : 3
            let loadingDelay = isVoiceOverEnabled ? 3.5 : 2
            
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
        }
    }
}

#Preview {
    FinishView()
}
