//
//  EditAffirmationFrequencyView.swift
//  CH3_8AM_TeachersGood
//
//  Created by Novia Rahman Nisa on 07/06/26.
//

import SwiftUI

struct AffirmationFrequency: Identifiable {
    let id = UUID()
    let name: String
}

struct EditAffirmationFrequencyView: View {
    let affirmationFrequencies = [
        AffirmationFrequency(name: "Daily"),
        AffirmationFrequency(name: "Twice a day"),
        AffirmationFrequency(name: "3 times a day"),
        AffirmationFrequency(name: "4 times a day")
    ]
    
    @State private var selectedAffirmationFrequency: UUID?
    
    var body: some View {
        NavigationStack {
            VStack {
                List(affirmationFrequencies) { affirmationFrequency in
                    HStack {
                        Text(affirmationFrequency.name)
                        Spacer()
                        if selectedAffirmationFrequency == affirmationFrequency.id {
                            Image(systemName: "checkmark")
                                .foregroundColor(.appPrimaryLight)
                                .font(.body.bold())
                        }
                    }
                    .contentShape(Rectangle())
                    .onTapGesture {
                        selectedAffirmationFrequency = affirmationFrequency.id
                    }
                }
                .scrollContentBackground(.hidden)
                .shadow(color: Color.appProfileShadow.opacity(0.4), radius: 10, x: 0, y: 4)
            }
            .background(Color.appBackground)
            .navigationTitle("Affirmation Frequency")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    EditAffirmationFrequencyView()
}
