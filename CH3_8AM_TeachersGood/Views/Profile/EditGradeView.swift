//
//  EditGradeView.swift
//  CH3_8AM_TeachersGood
//
//  Created by Novia Rahman Nisa on 03/06/26.
//

import SwiftUI

struct Grade: Identifiable {
    let id = UUID()
    let name: String
}

struct EditGradeView: View {
    let grades = [
        Grade(name: "Preschool"),
        Grade(name: "Elementary"),
        Grade(name: "Middle School"),
        Grade(name: "High School")
    ]
    
    @State private var selectedGrade: UUID?
    
    var body: some View {
        NavigationStack {
            VStack {
                List(grades) { grade in
                    HStack {
                        Text(grade.name)
                        Spacer()
                        if selectedGrade == grade.id {
                            Image(systemName: "checkmark")
                                .foregroundColor(.appPrimaryLight)
                                .font(.body.bold())
                        }
                    }
                    .contentShape(Rectangle())
                    .onTapGesture {
                        selectedGrade = grade.id
                    }
                }
                .scrollContentBackground(.hidden)
                .shadow(color: Color.appProfileShadow.opacity(0.4), radius: 10, x: 0, y: 4)
            }
            .background(Color.appBackground)
            .navigationTitle("Grade")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    EditGradeView()
}
