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
                MascotView(size: 150)
                SpeechBubbleView(
                    text: "What grade do\nyou usually teach?",
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
                            .fontWeight(selectedGrade == grade ? .bold : .regular)
                            .foregroundColor(selectedGrade == grade ? .appGradeSelectedText : .appGradeNotSelectedText)
                        Spacer()
                        Text(grade.ageRange)
                            .font(.system(size: 14))
                            .opacity(0.7)
                            .foregroundColor(selectedGrade == grade ? .appGradeSelectedText : .appGradeNotSelectedText)
                        
                    }
                    .padding(.horizontal, 20)
                    .padding(.vertical, 14)
                    .background(selectedGrade == grade ? Color.appGradeSelected : Color.appGradeNotSelected)
                    .cornerRadius(15)
                    .shadow(
                        color: selectedGrade == grade ? Color.appGradeSelected.opacity(0.5) : .clear,
                        radius: 8, x: 0, y: 4
                    )
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color(hex: "#4723B5").opacity(0.2), lineWidth: selectedGrade == grade ? 0 : 1)
                    )
                    .padding(.horizontal, 24)
                    .scaleEffect(x: selectedGrade == grade ? 1.1 : 1.0, y: selectedGrade == grade ? 1.15 : 1.0)
                    .animation(.spring(response: 0.3, dampingFraction: 0.6), value: selectedGrade)
                    .onTapGesture {
                        selectedGrade = grade
                    }
                }
            }
            .padding(.horizontal, 15)
            
            // CONTINUE BUTTONT
            
            Spacer()
            
            NavigationLink {
                ReasonInputView()
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
            
            Spacer()
            
        }
        .background(Color.appBackground)
        
    }
}

#Preview {
    GradeInputView()
}
