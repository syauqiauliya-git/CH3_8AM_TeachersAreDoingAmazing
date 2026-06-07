//
//  EditNameView.swift
//  CH3_8AM_TeachersGood
//
//  Created by Novia Rahman Nisa on 07/06/26.
//

import SwiftUI

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
    @State private var userInput = ""
    
    var body: some View {
        NavigationStack {
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
                        Button(action: {
                            userInput = ""
                        }) {
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
                .shadow(color: Color.appProfileShadow.opacity(0.4), radius: 10, x: 0, y: 4)
                Spacer()
            }
            .background(Color.appBackground)
            .padding(20)
            .navigationTitle("Name")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    EditNameView()
}
