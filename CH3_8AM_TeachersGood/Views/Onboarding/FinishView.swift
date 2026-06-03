//
//  FinishView.swift
//  CH3_8AM_TeachersGood
//
//  Created by Syauqi Auliya M on 02/06/26.
//


import SwiftUI
internal import Combine


struct FinishView: View {
    @State private var stage = 1
    @State private var navigateToHome = false
    @State private var progress: CGFloat = 0.0
    
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
                        .id(
                            stage
                        ) // forces transition to re-trigger on text change
                        .transition(.opacity)
                    
                    MascotView(size: 300)
                    
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
                    .transition(.opacity)
                    
                    
                    Spacer()
                    
                    if stage == 3 {
                        AffirmationsView()
                    }
                }
                .transition(.opacity)
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationDestination(isPresented: $navigateToHome) {
            AffirmationsView()
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
            //Later put actual async loading thing here for the app
            try? await Task.sleep(for: .seconds(1.5))
            withAnimation { stage = 2 }
            withAnimation(.linear(duration: 1.5)) { progress = 1.0 }
            try? await Task.sleep(for: .seconds(1.5))
            navigateToHome = true
        }
    }
}

#Preview {
    FinishView()
}
