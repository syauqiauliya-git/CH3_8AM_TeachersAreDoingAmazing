//
//  PrepareVoiceView.swift
//  CH3_8AM_TeachersGood
//
//  Created by Syauqi Auliya M on 05/06/26.
//

import SwiftUI

struct PrepareVoiceView: View {
    
    
    var body: some View {
        
        VStack {
            
            Spacer()
            
            SpeechBubbleView(
                text: "Next question is a deeper one. Express yourself openly",
                tail: .bottomRight
            )
            MascotView(size: 350)
            
            Spacer()
            
            NavigationLink {
                ReasonInputView()
            } label: {
                Text("Continue")
                    .font(.custom("Futura", size: 20))
                    .foregroundColor(.appTextPrimary)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 15)
                    .background(Color.appPrimaryLight)
            }
            .cornerRadius(20)
            .padding(.horizontal, 35)
            .padding(.top, 16)
            .padding(.bottom, 32)
            
            
        }
        .background(Color.appBackground)
        
    }
    
}

#Preview {
    PrepareVoiceView()
}

