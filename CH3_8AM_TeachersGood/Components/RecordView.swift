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
    
    @Binding var showConfirmation: Bool
    
    @State private var isTypingMode = false
    @State private var inputText = ""
    
    @FocusState private var isTextFieldFocused: Bool
    
    let timer = Timer.publish(every: 0.15, on: .main, in: .common).autoconnect()
    
    var body: some View {
        VStack(spacing: 25) {
            
            if isTypingMode {
                VStack(spacing: 16) {
                    HStack {
                        TextField("", text: $inputText, prompt: Text("Type here").foregroundColor(.appTextTertiary))
                            .foregroundColor(.appTextPrimary)
                            .padding(.vertical, 14)
                            .padding(.horizontal, 20)
                            .background(Color.appBackground)
                            .cornerRadius(25)
                            .overlay(
                                RoundedRectangle(cornerRadius: 25)
                                    .stroke(Color.appSpeechBubble, lineWidth: 2.0)
                            )
                            .focused($isTextFieldFocused)
                        
                        Button(action: {
                            print("Sent: \(inputText)")
                            
                            withAnimation(.spring()) {
                                isTextFieldFocused = false
                                isTypingMode = false
                                showConfirmation = true
                            }
                            
                            inputText = ""
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                                withAnimation {
                                    showConfirmation = false
                                    currentState = .ready
                                }
                            }
                        }) {
                            Image(systemName: "paperplane.fill")
                                .foregroundColor(.white)
                                .padding(13)
                                .background(LinearGradient(
                                    colors: [.appGradientPurpleStart, .appGradientPurpleEnd],
                                    startPoint: .bottomLeading,
                                    endPoint: .topTrailing
                                ))
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
                                    .fill(
                                        LinearGradient(
                                            colors: [.appGradientPurpleStart, .appGradientPurpleEnd],
                                            startPoint: .bottomLeading,
                                            endPoint: .topTrailing
                                        )
                                    )
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
                                    .fill(
                                        LinearGradient(
                                            colors: [.appGradientOrangeStart, .appGradientRedEnd],
                                            startPoint: .bottomLeading,
                                            endPoint: .topTrailing
                                        )
                                    )
                                    .frame(width: 80, height: 80)
                                Image(systemName: "square.fill")
                                    .font(.system(size: 28, weight: .black))
                                    .foregroundColor(.white)
                            }
                        }
                        
                    case .finished:
                        Button(action: {
                        withAnimation(.spring()) {
                            showConfirmation = true
                        }
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                            withAnimation {
                                showConfirmation = false
                                currentState = .ready
                            }
                        }
                    }) {
                        ZStack {
                            Circle()
                                .fill(
                                    LinearGradient(
                                        colors: [.appGradientPurpleStart, .appGradientPurpleEnd],
                                        startPoint: .bottomLeading,
                                        endPoint: .topTrailing
                                    )
                                )
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
    RecordView(currentState: .constant(.ready), audioLevels: .constant(Array(repeating: 10.0, count: 7)), showConfirmation: .constant(false))
}
