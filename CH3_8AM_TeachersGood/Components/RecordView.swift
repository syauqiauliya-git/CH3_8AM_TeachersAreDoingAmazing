//
//  RecordView.swift
//  CH3_8AM_TeachersGood
//
//  Created by Syauqi Auliya M on 26/05/26.
//

import SwiftUI
internal import Combine

struct RecordView: View {
    
    let primaryColor = Color(red: 0.38, green: 0.43, blue: 0.70)
    
    @Binding var currentState: RecordingState
    @Binding var audioLevels: [CGFloat]
    
    @State private var isTypingMode = false
    @State private var inputText = ""
    
    @FocusState private var isTextFieldFocused: Bool
    
    let timer = Timer.publish(every: 0.15, on: .main, in: .common).autoconnect()
    
    var body: some View {
        VStack(spacing: 25) {
            
            if isTypingMode {
                VStack(spacing: 16) {
                    HStack {
                        TextField("Type your message...", text: $inputText)
                            .textFieldStyle(.roundedBorder)
                            .focused($isTextFieldFocused)
                        
                        Button(action: {
                            print("Sent: \(inputText)")
                            inputText = ""
                            withAnimation {
                                isTextFieldFocused = false
                                isTypingMode = false
                                currentState = .ready
                            }
                        }) {
                            Image(systemName: "paperplane.fill")
                                .foregroundColor(.white)
                                .padding(10)
                                .background(primaryColor)
                                .clipShape(Circle())
                        }
                    }
                    .padding(.horizontal, 20)
                    
                    Button(action: {
                        withAnimation {
                            isTextFieldFocused = false
                            isTypingMode = false
                        }
                    }) {
                        Text("Cancel")
                            .font(.caption)
                            .foregroundColor(.red)
                    }
                }
                .frame(height: 155)
                
            } else {
                HStack(spacing: 6) {
                    ForEach(0..<audioLevels.count, id: \.self) { index in
                        Capsule()
                            .fill(currentState == .recording ? .red : primaryColor.opacity(0.3))
                            .frame(width: 6, height: currentState == .recording ? audioLevels[index] : 10)
                            .animation(.easeInOut(duration: 0.15), value: audioLevels[index])
                    }
                }
                .frame(height: 50)
                
                VStack(spacing: 15) {
                    switch currentState {
                    case .ready:
                        Button(action: {
                            withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
                                currentState = .recording
                            }
                        }) {
                            ZStack {
                                Circle()
                                    .fill(AnyShapeStyle(LinearGradient(colors: [Color(red: 91/255, green: 35/255, blue: 181/255), Color(red: 210/255, green: 50/255, blue: 255/255)], startPoint: .bottomLeading, endPoint: .topTrailing)))
                                    .frame(width: 80, height: 80)
                                Image(systemName: "mic")
                                    .font(.system(size: 32, weight: .regular))
                                    .foregroundColor(.white)
                            }
                        }
                        
                        Button(action: {
                            withAnimation {
                                isTypingMode = true
                                isTextFieldFocused = true
                            }
                        }) {
                            Text("I can't speak right now")
                                .font(.caption)
                                .underline()
                                .foregroundStyle(Color(red: 74/255, green: 77/255, blue: 178/255))
                        }
                        .opacity(0.5)
                        
                    case .recording:
                        Button(action: {
                            withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
                                currentState = .finished
                            }
                        }) {
                            ZStack {
                                Circle()
                                    .fill(AnyShapeStyle(LinearGradient(colors: [Color(red: 255/255, green: 160/255, blue: 65/255), Color(red: 213/255, green: 20/255, blue: 20/255)], startPoint: .bottomLeading, endPoint: .topTrailing)))
                                    .frame(width: 80, height: 80)
                                Image(systemName: "square.fill")
                                    .font(.system(size: 28, weight: .black))
                                    .foregroundColor(.white)
                            }
                        }
                        
                    case .finished:
                        Button(action: {
                            print("Audio dikirim!")
                        }) {
                            ZStack {
                                Circle()
                                    .fill(AnyShapeStyle(LinearGradient(colors: [Color(red: 91/255, green: 35/255, blue: 181/255), Color(red: 210/255, green: 50/255, blue: 255/255)], startPoint: .bottomLeading, endPoint: .topTrailing)))
                                    .frame(width: 80, height: 80)
                                Image(systemName: "paperplane.fill")
                                    .font(.system(size: 28, weight: .bold))
                                    .foregroundColor(.white)
                                    .offset(x: -2, y: 2)
                            }
                        }
                        
                        Button(action: {
                            withAnimation {
                                currentState = .ready
                            }
                        }) {
                            Text("Re-Record")
                                .font(.caption)
                                .underline()
                                .foregroundColor(.gray)
                        }
                    }
                }
            }
        }
        .padding(.bottom, 60)
        .onReceive(timer) { _ in
            if currentState == .recording && !isTypingMode {
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
    RecordView(currentState: .constant(.ready), audioLevels: .constant(Array(repeating: 10.0, count: 7)))
}
