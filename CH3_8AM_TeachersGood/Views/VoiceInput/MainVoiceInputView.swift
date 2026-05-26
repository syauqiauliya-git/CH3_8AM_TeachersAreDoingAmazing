//
//  MainVoiceInputView.swift
//  CH3_8AM_TeachersGood
//
//  Created by Ahmad Taufiq Hidayat on 26/05/26.
//

import SwiftUI
internal import Combine

struct MainVoiceInputView: View {
    
    @State private var isRecording = false
    @State private var audioLevels: [CGFloat] = Array(repeating: 10.0, count: 7)
    
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
            
            RecordView(isRecording: $isRecording, audioLevels: $audioLevels)
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.white)
        .ignoresSafeArea(.all, edges: .bottom)
    }
}

#Preview {
    MainVoiceInputView()
}
