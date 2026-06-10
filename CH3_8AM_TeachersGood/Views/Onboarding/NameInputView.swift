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
    
    @State private var teacherName: String = ""
    
    var body: some View {
        
        VStack {
            
            SpeechBubbleView(
                text: "How would you like to be called?",
                tail: .bottomRight
            )
            .padding(.top, 20)
            
            Spacer()
            
            GifWebView(gifName: "ThingyIdle")
                .frame(width: 250, height: 250)
                .accessibilityElement(children: .ignore)
                .accessibilityLabel("Thingy is idling, waiting for your answer")
                .accessibilityAddTraits(.isImage)
            // MascotView(size: 350)
            
            Spacer()
            
            // INSERT NAME
            
            
            TextField("", text: $teacherName, prompt:
                        Text("Insert your name")
                .foregroundColor(.appTextAlt)
            )
            .font(.custom("Nunito-Medium", size: 16))
            .opacity(0.6)
            .padding(.horizontal, 16)
            .padding(.vertical, 15)
            .background(Color.appSpeechBubble)
            .cornerRadius(20)
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.appSliderBorder.opacity(1), lineWidth: 1)
            )
            .padding(.horizontal, 35)
            .padding(.top, 70)
            
        }
        .safeAreaInset(edge: .bottom) {
            // CONTINUE BUTTON (Extracted from VStack)
            NavigationLink {
                GradeInputView()
            } label: {
                Text("Continue")
                    .font(.custom("Futura", size: 20))
                    .foregroundColor(.appBackground)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 15)
                    .background(teacherName == "" ? Color.startSendRecord.opacity(0.6) : Color.startSendRecord)
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
            .disabled(teacherName == "")
            // Optional: Add a background to the inset if you want to prevent the TextField from showing behind the button when scrolling
            // .background(Color.appBackground)
        }
        .background(Color.appBackground.ignoresSafeArea())
        .onAppear {
            teacherName = teacher?.name ?? ""
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Text("1 of 4")
                    .font(.custom("Futura", size: 14))
                    .foregroundColor(.appPrimaryLight)
                    .opacity(0.4)
            }
            .sharedBackgroundVisibility(.hidden)
            
        }
    }
}

#Preview {
    NameInputView()
}

//#Preview {
//    NameInputView(teacherName: .constant("")) {}
//}
