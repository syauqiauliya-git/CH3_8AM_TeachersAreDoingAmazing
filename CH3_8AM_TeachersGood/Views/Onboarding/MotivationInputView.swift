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
                Text("4 of 4")
                    .font(.system(size: 14))
                    .foregroundColor(.appTextSecondary)
            }
            .padding(.horizontal, 24)
            .padding(.top, 16)
            
            Spacer()
            
            // SPEECH BUBBLESl
            
            SpeechBubbleView(
                text: "How are you feeling about teaching?",
                tail: .bottomRight
            )
            
            //Mascot
            MascotView(size: 350)
            
            Spacer()
            
            // SLIDER
            
            SliderView()
            HStack {
                Text("Struggling")
                    .padding(.leading,30)
                Spacer()
                Text("Thriving")
                    .padding(.trailing,30)

            }
            .padding(.vertical, 15)
            .foregroundStyle(Color.appPrimaryLight)
            Spacer()
            
            NavigationLink {
                FinishView()
            } label: {
                Text("Save")
                    .font(.custom("Futura", size: 20))
                    .foregroundColor(.appTextPrimary)
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
    MotivationInputView()
}
