//
//  EditAffirmationFrequencyView.swift
//  CH3_8AM_TeachersGood
//
//  Created by Novia Rahman Nisa on 07/06/26.
//

import SwiftUI
import SwiftData

struct EditAffirmationFrequencyView: View {
    @Query var teachers: [Teacher]
    
    var teacher: Teacher? { teachers.first }
    
    @State private var selectedInterval: IntervalTime = .onetime
    
    var body: some View {
        List {
            ForEach(IntervalTime.allCases) { interval in
                Button {
                    selectedInterval = interval
                    teacher?.affirmationInterval = interval.rawValue
                    NotificationService.shared.schedule(for: interval)
                } label: {
                    HStack {
                        Text(interval.rawValue)
                        Spacer()
                        if selectedInterval == interval {
                            Image(systemName: "checkmark")
                                .foregroundStyle(Color.appGradientPurpleStart)
                        }
                    }
                }
                .foregroundStyle(.primary)
            }
        }
        .navigationTitle("Affirmation Frequency")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            if let saved = teacher?.affirmationInterval {
                selectedInterval = IntervalTime(rawValue: saved) ?? .onetime
            }
        }
    }
}

#Preview {
    EditAffirmationFrequencyView()
}
