//
//  GradeInputView.swift
//  CH3_8AM_TeachersGood
//
//  Created by Syauqi Auliya M on 26/05/26.
//

import SwiftUI

struct GradeInputView: View {
    
    @State private var selectedGrade: GradeLevel? = nil

    
    var body: some View {
        
        VStack{
            
            // PAGE NUMBER
            
            HStack {
                Spacer()
                Text("2 of 4")
                    .font(.system(size: 14))
                    .foregroundColor(.appTextSecondary)
            }
            .padding(.horizontal, 24)
            .padding(.top, 16)
        
            
            // MASCOT QUESTION
            
            HStack(alignment: .center, spacing: 12) {
                MascotView(size: 120)
                SpeechBubbleView(
                    text: "What grade do you usually teach?",
                    tail: .left
                )
                Spacer()
            }
            .padding(.horizontal, 24)
            .padding(.top, 24)
            
            Spacer()
            
            // TEACHING GROUP SELECTOR
            
            VStack(spacing: 20) {
                ForEach(GradeLevel.allCases, id: \.self) { grade in
                    HStack {
                        Text(grade.rawValue)
                            .font(.custom("Futura", size: 16))
                            .foregroundColor(selectedGrade == grade ? .appGradeSelectedText : .appGradeNotSelectedText)
                        Spacer()
                        Text(grade.ageRange)
                            .font(.custom("Futura", size: 13))
                            .foregroundColor(selectedGrade == grade ? .appGradeSelectedText : .appGradeNotSelectedText)
                        
                    }
                    .padding(.horizontal, 20)
                    .padding(.vertical, 14)
                    .background(selectedGrade == grade ? Color.appSpeechBubble : Color.appGradeNotSelected)
                    .cornerRadius(15)
                    .overlay(
                        RoundedRectangle(cornerRadius: 18)
                            .stroke(Color(hex: "#4723B5").opacity(selectedGrade == grade ? 1 : 0.2), lineWidth: selectedGrade == grade ? 2 : 1)
                    )
                    .padding(.horizontal, 24)
                    .scaleEffect(x: selectedGrade == grade ? 1.1 : 1.0, y: selectedGrade == grade ? 1.2 : 1.0)
                    .animation(.spring(response: 0.3, dampingFraction: 0.6), value: selectedGrade)
                    .onTapGesture {
                        selectedGrade = grade
                    }
                    .opacity(selectedGrade == grade ? 1  : 0.6 )
                }
            }
            .padding(.horizontal, 15)
            
            // CONTINUE BUTTONT
            
            Spacer()
            
            NavigationLink {
                ReasonInputView()
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
    GradeInputView()
}
