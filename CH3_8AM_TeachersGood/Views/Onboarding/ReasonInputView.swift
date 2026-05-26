//
//  ReasonInputView.swift
//  CH3_8AM_TeachersGood
//
//  Created by Syauqi Auliya M on 26/05/26.
//

import SwiftUI

struct ReasonInputView: View {
    
    @State private var isRecording = false
    @State private var audioLevels: [CGFloat] = Array(repeating: 10.0, count: 7)
    
    var body: some View {
        VStack{
            // PAGE NUMBER
            
            HStack {
                Spacer()
                Text("3 of 4")
                    .font(.system(size: 14))
                    .foregroundColor(.appTextSecondary)
            }
            .padding(.horizontal, 24)
            .padding(.vertical, 50)
            
            Spacer()
            
            // SPEECH BUBBLE
                        
            SpeechBubbleView(text: "\nWhy did you start teaching?\n", tail: .bottomLeft)
            
            //MASCOT
            
            MascotView(size: 300)
            
            Spacer()

            //RECORD
            RecordView(isRecording: $isRecording, audioLevels: $audioLevels)
        }
        .background(Color.appBackground)

    }
}

#Preview {
    ReasonInputView()
}
