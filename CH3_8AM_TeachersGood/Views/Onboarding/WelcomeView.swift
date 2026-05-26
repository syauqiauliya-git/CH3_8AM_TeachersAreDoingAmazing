//
//  WelcomeView.swift
//  CH3_8AM_TeachersGood
//
//  Created by Syauqi Auliya M on 26/05/26.
//

import SwiftUI

struct WelcomeView: View {
    
    var body: some View {
        
        NavigationStack {
            ZStack {
                Color.appBackground
                    .ignoresSafeArea()
                VStack {
                    MascotView(size: 300)
                    SpeechBubbleView(text: "Welcome", tail: .topRight)
                    
                    NavigationLink("Start") {
                        NameInputView(teacherName: .constant("")) {}
                    }
                }
            }
            
        }
        
    }
    
}

#Preview {
    WelcomeView()
}
