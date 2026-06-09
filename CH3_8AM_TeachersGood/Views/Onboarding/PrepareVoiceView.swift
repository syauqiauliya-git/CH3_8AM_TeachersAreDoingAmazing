//
//  PrepareVoiceView.swift
//  CH3_8AM_TeachersGood
//
//  Created by Syauqi Auliya M on 05/06/26.
//

import SwiftUI

struct PrepareVoiceView: View {
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        
        VStack {
            
            Spacer()
            
            SpeechBubbleView(
                text: "Next question is a deeper one. Express yourself openly",
                tail: .bottomRight
            )
            .padding(.bottom, 40)
            //MascotView(size: 350)
            GifWebView(gifName: "ThingyIdle")
                .frame(width: 250, height: 250)

            Spacer()
            
            NavigationLink {
                ReasonInputView()
            } label: {
                Text("Continue")
                    .font(.custom("Futura", size: 20))
                    .foregroundColor(.appBackground)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 15)
                    .background(Color.startSendRecord)
            }
            .cornerRadius(20)
            .padding(.horizontal, 35)
            .padding(.top, 16)
            .padding(.bottom, 32)
            
            
        }
        .background(Color.appBackground.ignoresSafeArea())
        .environment(\.colorScheme, colorScheme == .dark ? .light : .dark)


    }
    
}

#Preview {
    PrepareVoiceView()
}

