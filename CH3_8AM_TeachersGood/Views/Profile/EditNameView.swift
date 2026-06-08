//
//  EditNameView.swift
//  CH3_8AM_TeachersGood
//
//  Created by Novia Rahman Nisa on 07/06/26.
//

import SwiftUI
import SwiftData

struct OvalTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding(15)
            .padding(.trailing, 35)
        //            .background(Color.white)
        //            .cornerRadius(25)
        //            .shadow(color: Color.appProfileShadow.opacity(0.4), radius: 10, x: 0, y: 4)
    }
}

struct EditNameView: View {
    @Environment(\.modelContext) var modelContext
    
    @Query var teachers: [Teacher]
    
    var teacher: Teacher? { teachers.first }
    
    @State private var userInput = ""
    
    var body: some View {
        VStack {
            ZStack(alignment: .trailing) {
                TextField(
                    "Type name here...",
                    text: $userInput,
                    prompt: Text("Type name here...")
                        .foregroundStyle(.gray)
                )
                .disableAutocorrection(true)
                .textFieldStyle(OvalTextFieldStyle())
                if !userInput.isEmpty {
                    Button {
                        userInput = ""
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.gray)
                    }
                    .buttonStyle(.borderless)
                    .padding(.trailing, 15)
                    .transition(.scale)
                }
            }
            .background(Color.white)
            .cornerRadius(25)
            .compositingGroup()
            .shadow(color: Color.appProfileShadow.opacity(0.4), radius: 10, x: 0, y: 4)
            Spacer()
        }
        .padding(20)
        .background(Color.appBackground)
        .navigationTitle("Name")
        .navigationBarTitleDisplayMode(.inline)
        .toolbarBackground(Color.appBackground, for: .navigationBar)
        .onAppear {
            userInput = teacher?.name ?? ""
        }
        .onChange(of: teacher?.name) { _, newValue in
            if let newValue, userInput.isEmpty {
                userInput = newValue
            }
        }
        .onChange(of: userInput) { _, newValue in
            teacher?.name = newValue
        }
    }
}

//struct EditNameView: View {
//    @State private var userInput = ""
//
//    var body: some View {
//        VStack {
//            ZStack(alignment: .trailing) {
//                TextField(
//                    "Type name here...",
//                    text: $userInput,
//                    prompt: Text("Type name here...")
//                        .foregroundStyle(.gray)
//                )
//                .disableAutocorrection(true)
//                .textFieldStyle(OvalTextFieldStyle())
//                if !userInput.isEmpty {
//                    Button(action: {
//                        userInput = ""
//                    }) {
//                        Image(systemName: "xmark.circle.fill")
//                            .foregroundColor(.gray)
//                    }
//                    .buttonStyle(.borderless)
//                    .padding(.trailing, 15)
//                    .transition(.scale)
//                }
//            }
//            .background(Color.white)
////            .environment(\.colorScheme, .light)
//            .cornerRadius(25)
//            .compositingGroup()
//            .shadow(color: Color.appProfileShadow.opacity(0.4), radius: 10, x: 0, y: 4)
//            Spacer()
//        }
//        .padding(20)
//        .background(Color.appBackground)
//        .navigationTitle("Name")
//        .navigationBarTitleDisplayMode(.inline)
//    }
//}

#Preview {
    EditNameView()
}
