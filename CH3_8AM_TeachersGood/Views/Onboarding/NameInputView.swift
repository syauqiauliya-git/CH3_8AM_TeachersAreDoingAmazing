//
//  NameInputView.swift
//  CH3_8AM_TeachersGood
//
//  Created by Syauqi Auliya M on 26/05/26.
//

import SwiftUI

struct NameInputView: View {
    
    @Binding var teacherName: String
    var onContinue: () -> Void
    
    var body: some View {
        
        VStack {
            HStack {
                Spacer()
                Text("1 of 4")
                    .font(.system(size: 14))
                    .foregroundColor(.appTextSecondary)
            }
            .padding(.horizontal, 24)
            .padding(.top, 16)
            
            Spacer()
            
            SpeechBubbleView(
                text: "How would you like\n to be called?",
                tail: .bottomRight
            )
            MascotView(size: 300)
            
            Spacer()
            
            TextField("Insert your name", text: $teacherName)
                .padding(.horizontal, 16)
                .padding(.vertical, 14)
                .background(Color(.systemGray6))
                .cornerRadius(20)
                .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color(hex: "#4723B5").opacity(0.2), lineWidth: 2)
                    )
                    .padding(.horizontal, 24)
            
            NavigationLink {
                GradeInputView()
            } label: {
                Text("Continue")
                    .font(.system(size: 17, weight: .semibold))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 16)
                    .background(Color.appPrimary)
            }
            .cornerRadius(20)
            .padding(.horizontal, 24)
            .padding(.top, 16)
            .padding(.bottom, 32)
            
            
        }
        
        
    }
    
}

#Preview {
    NameInputView(teacherName: .constant("")) {}
}
