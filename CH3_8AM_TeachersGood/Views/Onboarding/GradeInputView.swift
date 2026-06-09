//
//  GradeInputView.swift
//  CH3_8AM_TeachersGood
//
//  Created by Syauqi Auliya M on 26/05/26.
//

import SwiftUI
import SwiftData

struct GradeInputView: View {
    @Environment(\.modelContext) var modelContext
    
    @Query var teachers: [Teacher]
    
    var teacher: Teacher? { teachers.first }
    
    @State private var selectedGrade: GradeLevel? = nil
    
    var body: some View {
        
        VStack{
            // PAGE NUMBER
            
            HStack {
                Spacer()
                Text("2 of 4")
                    .font(.custom("Futura", size: 14))
                    .foregroundColor(.appPrimaryLight)
                    .opacity(0.4)
            }
            .padding(.horizontal, 24)
            .padding(.top, 40)
            
            Spacer()
            
            
            // MASCOT QUESTION
            
            HStack(alignment: .center, spacing: 12) {
                //  MascotView(size: 130)
                GifWebView(gifName: ThingyState.lookright.mode)
                    .frame(width: 80, height: 80)
                    .padding(.trailing, 10)
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
            
            VStack(spacing: 17) {
                ForEach(GradeLevel.allCases, id: \.self) { grade in
                    HStack {
                        Text(grade.rawValue)
                            .font(.custom(selectedGrade == grade ? "Nunito-Bold" : "Nunito-SemiBold" , size: 16))
                            .foregroundColor(selectedGrade == grade ? .appGradeSelectedText : .appGradeNotSelectedText)
                        Spacer()
                        Text(grade.ageRange)
                            .font(.custom(selectedGrade == grade ? "Nunito-Bold" : "Nunito-SemiBold", size: 13))
                            .foregroundColor(selectedGrade == grade ? .appGradeSelectedText : .appGradeNotSelectedText)
                        
                    }
                    .padding(.horizontal, 20)
                    .padding(.vertical, 14)
                    .background(selectedGrade == grade ? Color.appSpeechBubble : Color.appGradeNotSelected)
                    .cornerRadius(20)
                    .overlay(
                        RoundedRectangle(cornerRadius: 18)
                            .stroke(Color.appGradeBorder.opacity(selectedGrade == grade ? 1 : 0.2), lineWidth: selectedGrade == grade ? 2 : 1)
                    )
                    .padding(.horizontal, 24)
                    .scaleEffect(x: selectedGrade == grade ? 1.1 : 1.0, y: selectedGrade == grade ? 1.2 : 1.0)
                    .animation(.spring(response: 0.3, dampingFraction: 0.6), value: selectedGrade)
                    .onTapGesture {
                        selectedGrade = grade
                    }
                    .accessibilityAddTraits(.isButton)
                    .accessibilityLabel(Text("\(grade.rawValue)"))
                    .opacity(selectedGrade == grade ? 1  : 0.6 )
                }
            }
            .padding(.horizontal, 15)
            
            // CONTINUE BUTTONT
            
            Spacer()
            
            
            NavigationLink {
                PrepareVoiceView()
            } label: {
                Text("Continue")
                    .font(.custom("Futura", size: 20))
                    .foregroundColor(.appBackground)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 15)
                    .background(selectedGrade == nil ? Color.startSendRecord.opacity(0.6) : Color.startSendRecord)
            }
            .cornerRadius(20)
            .padding(.horizontal, 35)
            .padding(.top, 16)
            .padding(.bottom, 32)
            .simultaneousGesture(TapGesture().onEnded {
                if let teacher {
                    teacher.grade = selectedGrade?.rawValue ?? ""
                }
            })
            .disabled(selectedGrade == nil)
            .onAppear {
                selectedGrade = GradeLevel(rawValue: teacher?.grade ?? "")
            }
        }
        .background(Color.appBackground.ignoresSafeArea())

    }
}

#Preview {
    GradeInputView()
}
