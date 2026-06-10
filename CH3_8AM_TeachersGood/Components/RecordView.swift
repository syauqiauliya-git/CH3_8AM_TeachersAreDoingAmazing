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
    @Binding var isOnboarding: Bool
    
    // NEW: Data conduit to pass typed responses up to the AI inference engine
    @Binding var typedText: String
        
    @State private var isTypingMode = false
    @State private var inputText = ""
    @FocusState private var isTextFieldFocused: Bool
    
    let timer = Timer.publish(every: 0.15, on: .main, in: .common).autoconnect()
    
    var body: some View {
        ZStack {
            typingModeView
                .opacity(isTypingMode ? 1.0 : 0.0)
                .allowsHitTesting(isTypingMode)
            
            VStack(spacing: 25) {
                audioVisualizer
                    .opacity(currentState == .ready || currentState == .recording ? 1.0 : 0.0)
                
                recordingControls
            }
            .opacity(isTypingMode ? 0.0 : 1.0)
            .allowsHitTesting(!isTypingMode)
        }
        .padding(.bottom, 60)
        .onReceive(timer, perform: updateAudioLevels)
    }
}

extension RecordView {
    
    private var typingModeView: some View {
        VStack(spacing: 16) {
            HStack {
                TextField("", text: $inputText, prompt: Text("Type here").foregroundColor(.appTextTertiary)            .font(.custom("Nunito-Medium", size: 16)))
                    .foregroundColor(.appTextBnW)
                    .font(.custom("Nunito-Medium", size: 16))
                    .padding(.vertical, 14)
                    .padding(.horizontal, 20)
                    .background(Color.appBackground)
                    .cornerRadius(25)
                    .overlay(
                        RoundedRectangle(cornerRadius: 25)
                            .stroke(Color.appSpeechBubble, lineWidth: 2.0)
                    )
                    .focused($isTextFieldFocused)
                
                Button(action: handleSendText) {
                    Image(systemName: "paperplane.fill")
                        .foregroundColor(.white)
                        .padding(13)
                        .background(
                            inputText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
                            ? Color.startSendRecord.opacity(0.6)
                            : Color.startSendRecord
                        )
                        .clipShape(Circle())
                }
                .disabled(inputText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                .accessibilityLabel(Text("Send text message to thingy"))
            }
            .padding(.horizontal, 20)
            
            Button(action: cancelTypingMode) {
                Text("I prefer to speak")
                    .font(.caption)
                    .foregroundStyle(Color.stopRecord)

            }
        }
        .frame(height: 155)
    }
    
    private var audioVisualizer: some View {
        HStack(spacing: 6) {
            ForEach(0..<audioLevels.count, id: \.self) { index in
                Capsule()
                    .fill(currentState == .recording ? .stopRecord : primaryColor.opacity(0.3))
                    .frame(width: 6, height: currentState == .recording ? audioLevels[index] : 10)
                    .animation(.easeInOut(duration: 0.15), value: audioLevels[index])
            }
        }
        .frame(height: 50)
    }
    
    private var recordingControls: some View {
        ZStack(alignment: .top) {
            readyControls
                .opacity(currentState == .ready || currentState == .readyOnboarding ? 1.0 : 0.0)
                .allowsHitTesting(currentState == .ready || currentState == .readyOnboarding)
            
            recordingActiveControls
                .opacity(currentState == .recording ? 1.0 : 0.0)
                .allowsHitTesting(currentState == .recording)
            
            finishedControls
                .opacity(currentState == .finished || currentState == .finishedOnboarding ? 1.0 : 0.0)
                .allowsHitTesting(currentState == .finished || currentState == .finishedOnboarding)
            
            nextControls
                .opacity(currentState == .next && isOnboarding ? 1.0 : 0.0)
                .allowsHitTesting(currentState == .next && isOnboarding)
        }
    }
    
    private var readyControls: some View {
        VStack(spacing: 15) {
            Button(action: {
                withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
                    currentState = .recording
                }
            }) {
                gradientButton(
                    imageName: "mic",
                    imageSize: 32,
                    fontWeight: .regular,
                    colors: .startSendRecord
                )
            }
            .accessibilityLabel(Text("Start talking to thingy"))
            
            Button(action: {
                withAnimation {
                    isTypingMode = true
                    isTextFieldFocused = true
                }
            }) {
                Text("I can't speak right now")
                    .font(.caption)
                    .underline()
                    .foregroundStyle(Color.appTextAlt)
            }
            .opacity(0.5)
            .accessibilityLabel(Text("Type a message instead"))
        }
    }
    
    private var recordingActiveControls: some View {
        VStack(spacing: 15) {
            Button(action: {
                withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
                    currentState = .finished
                }
            }) {
                gradientButton(
                    imageName: "square.fill",
                    imageSize: 28,
                    fontWeight: .black,
                    colors: .stopRecord
                )
            }
        }
    }
    
    private var finishedControls: some View {
        VStack(spacing: 15) {
            Button(action: handleConfirmation) {
                gradientButton(
                    imageName: "paperplane.fill",
                    imageSize: 28,
                    fontWeight: .bold,
                    colors: .startSendRecord,
                    offset: CGSize(width: -2, height: 2)
                )
            }
            .accessibilityLabel(Text("Send to thingy"))
            reRecordButton
        }
    }
    
    private var nextControls: some View {
        VStack(spacing: 15) {
            Button(action: handleConfirmation) {
                gradientButton(
                    imageName: "paperplane.fill",
                    imageSize: 28,
                    fontWeight: .bold,
                    colors: .startSendRecord,
                    offset: CGSize(width: -2, height: 2)
                )
            }
            .accessibilityLabel(Text("Confirm and send to thingy"))
            reRecordButton
        }
    }
    
    private var reRecordButton: some View {
        Button(action: {
            withAnimation { currentState = .ready }
        }) {
            Text("Want to try that again?")
                .font(.caption)
                .underline()
                .foregroundColor(.appTextAlt)
        }
        .accessibilityLabel(Text("Discard and re-record"))
    }
}

extension RecordView {
    
    @ViewBuilder
    private func gradientButton(imageName: String, imageSize: CGFloat, fontWeight: Font.Weight, colors: Color, offset: CGSize = .zero) -> some View {
        ZStack {
            Circle()
                .fill(
                    colors
                )
                .frame(width: 80, height: 80)
            Image(systemName: imageName)
                .font(.system(size: imageSize, weight: fontWeight))
                .foregroundColor(.appBackground)
                .offset(offset)
        }
    }
    
    private func handleSendText() {
        
        guard !inputText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else { return }
        
        print("Sent: \(inputText)")
        
        // Capture the value globally before resetting the UI state
        typedText = inputText
        
        withAnimation(.spring()) {
            isTextFieldFocused = false
            isTypingMode = false
            showConfirmation = true
        }
        inputText = ""
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            withAnimation {
                showConfirmation = false
                currentState = .next // CORRECTED: Advancing to the final evaluation phase
            }
        }
    }
    
    private func cancelTypingMode() {
        withAnimation {
            isTextFieldFocused = false
            isTypingMode = false
        }
    }
    
    private func handleConfirmation() {
        withAnimation(.spring()) {
            showConfirmation = true
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            withAnimation {
                showConfirmation = false
                currentState = .next
            }
        }
    }
    
    private func updateAudioLevels(_ output: Timer.TimerPublisher.Output) {
        if currentState == .recording && !isTypingMode {
            for i in audioLevels.indices {
                audioLevels[i] = CGFloat.random(in: 10...50)
            }
        } else if currentState == .ready {
            for i in audioLevels.indices {
                audioLevels[i] = 10.0
            }
        } else {
            for i in audioLevels.indices {
                audioLevels[i] = 0.0
            }
        }
    }
}

#Preview {
    RecordView(currentState: .constant(.ready), audioLevels: .constant(Array(repeating: 10.0, count: 7)), showConfirmation: .constant(false), isOnboarding: .constant(true), typedText: .constant(""))
}
