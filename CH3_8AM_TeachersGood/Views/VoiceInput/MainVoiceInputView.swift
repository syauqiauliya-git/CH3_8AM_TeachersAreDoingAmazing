//
//  MainVoiceInputView.swift
//  CH3_8AM_TeachersGood
//
//  Created by Ahmad Taufiq Hidayat on 26/05/26.
//

import SwiftUI
internal import Combine

struct MainVoiceInputView: View {
    let primaryColor = Color(red: 0.38, green: 0.43, blue: 0.70)
    
    @State private var isRecording = false
    @State private var audioLevels: [CGFloat] = Array(repeating: 10.0, count: 7)

    let timer = Timer.publish(every: 0.15, on: .main, in: .common).autoconnect()
    
    var body: some View {
        VStack {
            Spacer()
                .frame(height: 80)
            
            SpeechBubbleView(
                text: "How was your day?",
                tail: .bottomRight
            )
            
            MascotView(size: 300)
            
            Spacer()
            
            VStack(spacing: 25) {
                
                HStack(spacing: 6) {
                    ForEach(0..<audioLevels.count, id: \.self) { index in
                        Capsule()
                            .fill(isRecording ? .red : primaryColor.opacity(0.3))
                            .frame(width: 6, height: isRecording ? audioLevels[index] : 10)
                            .animation(.easeInOut(duration: 0.15), value: audioLevels[index])
                    }
                }
                .frame(height: 50)
                
                Button(action: {
                    withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
                        isRecording.toggle()
                    }
                }) {
                    ZStack {
                        Circle()
                            .fill(isRecording ?
                                  AnyShapeStyle(
                                      LinearGradient(
                                          colors: [
                                              Color(red: 255/255, green: 160/255, blue: 65/255),
                                              Color(red: 213/255, green: 20/255, blue: 20/255)
                                          ],
                                      startPoint: .bottomLeading,
                                      endPoint: .topTrailing
                                      )
                                  ):
                                    AnyShapeStyle(
                                        LinearGradient(
                                            colors: [
                                                Color(red: 91/255, green: 35/255, blue: 181/255),
                                                Color(red: 210/255, green: 50/255, blue: 255/255)
                                            ],
                                        startPoint: .bottomLeading,
                                        endPoint: .topTrailing
                                        )
                                    )
                            )
                            .frame(width: 80, height: 80)
                        
                        if isRecording {
                            Image(systemName: "square.fill")
                                .font(.system(size: 28, weight: .black))
                                .foregroundColor(.white)
                        } else {
                            Image(systemName: "mic")
                                .font(.system(size: 32, weight: .regular))
                                .foregroundColor(.white)
                        }
                    }
                }
                
                Button(action: {
                    print("text clicked")
                }) {
                    Text("I can't speak right now")
                        .font(.caption)
                        .underline()
                        .foregroundStyle(Color(red: 74/255, green: 77/255, blue: 178/255))
                }
                .opacity(0.5)
            }
            .padding(.bottom, 60)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.white)
        .ignoresSafeArea(.all, edges: .bottom)
        .onReceive(timer) { _ in
            if isRecording {
                for i in 0..<audioLevels.count {
                    audioLevels[i] = CGFloat.random(in: 10...50)
                }
            } else {
                for i in 0..<audioLevels.count {
                    audioLevels[i] = 10.0
                }
            }
        }
    }
}

#Preview {
    MainVoiceInputView()
}
