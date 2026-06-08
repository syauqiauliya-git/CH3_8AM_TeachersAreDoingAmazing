//
//  NameInputView.swift
//  CH3_8AM_TeachersGood
//
//  Created by Syauqi Auliya M on 26/05/26.
//

import SwiftUI
import SwiftData

struct NameInputView: View {
    @Environment(\.modelContext) var modelContext
    
    @Query var teachers: [Teacher]
    
    var teacher: Teacher? { teachers.first }
    
    @Binding var teacherName: String
    var onContinue: () -> Void
    
    var body: some View {
        
        VStack {
            HStack {
                Spacer()
                Text("1 of 4")
                    .font(.custom("Futura", size: 14))
                    .foregroundColor(.appPrimaryLight)
                    .opacity(0.4)
            }
            .padding(.horizontal, 24)
            .padding(.top, 20)
            .padding(.bottom, 70)
            
            
            SpeechBubbleView(
                text: "How would you like to be called?",
                tail: .bottomRight
            )
            
            Spacer()
            
            GifWebView(gifName: "ThingyIdle")
                .frame(width: 400, height: 240)
            // MascotView(size: 350)
            
            Spacer()
            
            // INSERT NAME
            
            
            TextField("", text: $teacherName, prompt:
                Text("Insert your name")
                    .foregroundColor(.appTextBnW)
            )
            .font(.custom("Nunito-Medium", size: 16))
            .opacity(0.6)
            .padding(.horizontal, 16)
            .padding(.vertical, 15)
            .background(Color.appGradeNotSelected)
            .cornerRadius(20)
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.appSliderBorder.opacity(1), lineWidth: 1)
            )
            .padding(.horizontal, 35)
            .padding(.top, 70)
            
            
            //CONTINUE BUTTON
            
            NavigationLink {
                GradeInputView()
            } label: {
                Text("Continue")
                    .font(.custom("Futura", size: 20))
                    .foregroundColor(.appTextPrimary)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 15)
                    .background(teacherName == "" ? Color.appPrimaryLight.opacity(0.6) : Color.appPrimaryLight)
            }
            .cornerRadius(20)
            .padding(.horizontal, 35)
            .padding(.top, 16)
            .padding(.bottom, 32)
            .simultaneousGesture(TapGesture().onEnded {
                if let teacher {
                    teacher.name = teacherName
                } else {
                    modelContext.insert(Teacher(name: teacherName))
                }
            })
            
        }
        .background(Color.appBackground)
        .onAppear {
            teacherName = teacher?.name ?? ""
        }
    }
    
}

#Preview {
    NameInputView(teacherName: .constant("")) {}
}
