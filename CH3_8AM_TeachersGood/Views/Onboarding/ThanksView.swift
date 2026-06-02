//
//  ThanksView.swift
//  CH3_8AM_TeachersGood
//
//  Created by Syauqi Auliya M on 02/06/26.
//


import SwiftUI

struct ThanksView: View {
    
    
    var body: some View {
        
        VStack {
            
            Spacer()
            
            SpeechBubbleView(
                text: "Wow. Thank you for sharing!",
                tail: .bottomRight
            )
            MascotView(size: 350)
            
            Spacer()
            
            
            NavigationLink {
                MotivationInputView()
            } label: {
                Text("Continue")
                    .font(.custom("Futura", size: 20))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 20)
                    .background(Color.appPrimaryLight)
            }
            .cornerRadius(20)
            .padding(.horizontal, 24)
            .padding(.top, 16)
            .padding(.bottom, 32)
            
            
        }
        .background(Color.appBackground)
        
    }
    
}

#Preview {
    ThanksView()
}
