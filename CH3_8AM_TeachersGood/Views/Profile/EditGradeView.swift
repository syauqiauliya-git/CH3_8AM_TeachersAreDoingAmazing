//
//  EditGradeView.swift
//  CH3_8AM_TeachersGood
//
//  Created by Novia Rahman Nisa on 03/06/26.
//

import SwiftUI
import SwiftData

//struct Grade: Identifiable {
//    let id = UUID()
//    let name: String
//}

struct EditGradeView: View {
    @Environment(\.modelContext) var modelContext
    
    @Query var teachers: [Teacher]
    
    var teacher: Teacher? { teachers.first }

    @State private var selectedGrade: GradeLevel? = nil

    var body: some View {
        List {
            ForEach(GradeLevel.allCases, id: \.self) { grade in
                Button {
                    selectedGrade = grade
                    teacher?.grade = grade.rawValue
                } label: {
                    HStack {
                        Text(grade.rawValue)
                        Spacer()
                        if selectedGrade == grade {
                            Image(systemName: "checkmark")
                                .foregroundColor(.appPrimaryLight)
                                .font(.body.bold())
                        }
                    }
                }
                .foregroundStyle(.primary)
                .listRowBackground(Color.appBackground)
            }
        }
        .scrollContentBackground(.hidden)
        .shadow(color: Color.appProfileShadow.opacity(0.4), radius: 10, x: 0, y: 4)
        .background(Color.appBackground)
        .navigationTitle("Grade")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            selectedGrade = GradeLevel(rawValue: teacher?.grade ?? "")
        }
        .onChange(of: teacher?.grade) { _, newValue in
            if let newValue {
                selectedGrade = GradeLevel(rawValue: newValue)
            }
        }
    }
}

#Preview {
    EditGradeView()
}
