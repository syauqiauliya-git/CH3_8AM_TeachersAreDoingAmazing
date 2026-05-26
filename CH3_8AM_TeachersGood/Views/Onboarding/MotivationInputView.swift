//
//  MotivationInputView.swift
//  CH3_8AM_TeachersGood
//
//  Created by Syauqi Auliya M on 26/05/26.
//

import SwiftUI

struct MotivationInputView: View {
    
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
            
            // SPEECH BUBBLESl
            
            SpeechBubbleView(text: "How are you currently \nfeeling about teaching??", tail: .bottomLeft)
            
            //MASCOT
            
            MascotView(size: 350)
            
            Spacer()
            
            // SLIDER
            
            SliderView()
            HStack {
                Text("Not Motivated")
                    .padding(.leading,30)
                Spacer()
                Text("Very Motivated")
                    .padding(.trailing,30)

            }
            .padding(.vertical, 15)
            .foregroundStyle(Color.appTextTertiary)
            Spacer()
            
            NavigationLink {
                QuoteView()
            } label: {
                Text("Continue")
                    .font(.system(size: 17, weight: .semibold))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 20)
                    .background(Color.appPrimary)
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
    MotivationInputView()
}
