//
//  QuoteView.swift
//  CH3_8AM_TeachersGood
//
//  Created by Novia Rahman Nisa on 26/05/26.
//

import SwiftUI
import SwiftData

struct AffirmationsView: View {
    @Environment(\.modelContext) var modelContext
    
    @Query var affirmations: [Affirmation]
    @Query var teachers: [Teacher]
    
    var teacher: Teacher? { teachers.first }
    
    @State private var selectedAffirmation: Affirmation?
    
    //    var mainQuote: AttributedString {
    //        var result = AttributedString("“I want to change the future by educating younger generations.”")
    //
    //        if let range = result.range(of: "change the future") {
    //            result[range].foregroundColor = .appMascotOrange
    //        }
    //
    //        if let range = result.range(of: "educating") {
    //            result[range].foregroundColor = .appPrimaryLight
    //        }
    //
    //        return result
    //    }
    
    var body: some View {
        VStack {
//                        NavigationLink {
//                            ProfileView()
//                        } label: {
//                            Image(systemName: "person")
//                                .font(.system(size: 20))
//                                .foregroundStyle(Color.appPrimaryLight)
//                        }
//                        .frame(width: 50, height: 50)
//                        .frame(maxWidth: .infinity, alignment: .topTrailing)
//                        .buttonBorderShape(.circle)
//                        .buttonStyle(.glass)
//                        .controlSize(ControlSize.large)
            Spacer()
            VStack(spacing: 20) {
                //                Text(mainQuote)
                if let affirmation = selectedAffirmation {
                    Text(render(affirmation))
                        .font(.custom("Canela-Regular", size: 34))
                    //                        .font(.system(size: 48))
                }
            }
            Spacer()
            //            HStack {
            //                NavigationLink {
            //                    ArticlesView()
            //                } label: {
            //                    Image(systemName: "book.pages")
            //                        .font(.system(size: 20))
            //                        .foregroundStyle(Color.appPrimaryLight)
            //                }
            //                .frame(width: 50, height: 50)
            //                .frame(maxWidth: .infinity, alignment: .bottomLeading)
            //                .buttonBorderShape(.circle)
            //                .buttonStyle(.glass)
            //                .controlSize(ControlSize.regular)
            //                Spacer()
            //                NavigationLink {
            //                    MainVoiceInputView()
            //                } label: {
            //                    Circle()
            //                        .fill(Color.appPrimaryLight)
            //                        .frame(width: 50, height: 50)
            //                        .overlay(Image(systemName: "ellipsis.message.fill"))
            //                        .font(.system(size: 20))
            //                        .foregroundColor(.white)
            //                }
            //                .frame(maxWidth: .infinity, alignment: .bottomTrailing)
            //            }
        }
        .padding(25)
        .background(Color.appBackground)
        .navigationBarBackButtonHidden(true)
        .toolbarBackground(.visible, for: .navigationBar)
        .toolbarBackground(Color.appBackground, for: .navigationBar)
        .toolbarBackground(.visible, for: .bottomBar)
        .toolbarBackground(Color.appBackground, for: .bottomBar)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                NavigationLink {
                    ProfileView()
                } label: {
                    Image(systemName: "person")
                        .font(.system(size: 20))
                        .foregroundStyle(Color.appGradientPurpleStart)
                }
                .buttonStyle(.plain)
            }
            ToolbarItem(placement: .bottomBar) {
                NavigationLink {
                    ArticlesView()
                } label: {
                    Image(systemName: "book.pages")
                        .font(.system(size: 20))
                        .foregroundStyle(Color.appGradientPurpleStart)
                }
                .buttonStyle(.plain)
            }
            ToolbarItem(placement: .bottomBar) { Spacer() }
            ToolbarItem(placement: .bottomBar) {
                NavigationLink {
                    MainVoiceInputView()
                } label: {
                    Circle()
                        .fill(Color.appGradientPurpleStart)
                        .frame(width: 50, height: 50)
                        .overlay(
                            Image(systemName: "ellipsis.message.fill")
                                .font(.system(size: 20))
                                .foregroundColor(.white)
                        )
                }
                .buttonStyle(.plain)
            }
        }
        .onAppear {
            seedIfNeeded(context: modelContext)
            selectedAffirmation = affirmations.randomElement()
        }
    }
    
    func render(_ affirmation: Affirmation) -> AttributedString {
        var result = AttributedString()
        
        for token in affirmation.tokens.sorted(by: { $0.order < $1.order }) {
            var part = AttributedString(token.text + " ")
            
            switch token.style {
            case .normal: part.foregroundColor = .appTextBnW
            case .purple: part.foregroundColor = .appGradientPurpleStart
            case .orange: part.foregroundColor = .appMascotOrange
            }
            
            result += part
        }
        
        return result
    }
    
    func seedIfNeeded(context: ModelContext) {
        do {
            let existing = try context.fetch(FetchDescriptor<Affirmation>())
            
            guard existing.isEmpty else { return }
            
            for affirmation in AffirmationSeedData.all {
                context.insert(affirmation)
            }
            
            try context.save()
            
        } catch {
            print("Seeding error:", error)
        }
    }
    
//    func refreshIfNeeded() {
//        guard let teacher else { return }
//        
//        let interval = IntervalTime(rawValue: teacher.affirmationInterval) ?? .onetime
//        
//        if shouldRefresh(for: interval, last: teacher.lastShownAt) {
//            let next = affirmations
//                .filter { $0.id.uuidString != teacher.currentAffirmationID }
//                .randomElement() ?? affirmations.randomElement()
//            
//            if let next {
//                teacher.currentAffirmationID = next.id.uuidString
//                teacher.lastShownAt = Date()
//                selectedAffirmation = next
//            }
//        } else {
//            selectedAffirmation = affirmations.first { $0.id.uuidString == teacher.currentAffirmationID }
//            ?? affirmations.randomElement()
//        }
//    }
    
//    func times(for interval: IntervalTime) -> [(hour: Int, minute: Int)] {
//        switch interval {
//        case .onetime:    return [(7, 30)]
//        case .twotimes:   return [(7, 30), (16, 0)]
//        case .threetimes: return [(7, 30), (12, 0), (18, 0)]
//        case .fourtimes:  return [(7, 30), (10, 0), (13, 0), (16, 0)]
//        }
//    }
//    
//    func shouldRefresh(for interval: IntervalTime, last: Date) -> Bool {
//        let now = Date()
//        let calendar = Calendar.current
//        
//        let todaySlots = times(for: interval).map { slot in
//            calendar.date(bySettingHour: slot.hour, minute: slot.minute, second: 0, of: now) ?? now
//        }
//        
//        guard let mostRecentSlot = todaySlots.filter({ $0 <= now }).max() else {
//            print("No slot found before now")
//            return false
//        }
//        
//        print("Last shown: \(last)")
//        print("Most recent slot: \(mostRecentSlot)")
//        print("Should refresh: \(last < mostRecentSlot)")
//        
//        return last < mostRecentSlot
//    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    
    let container = try! ModelContainer(
        for: Affirmation.self, AffirmationToken.self,
        configurations: config
    )
    
    let context = container.mainContext
    
    context.insert(
        Affirmation(tokens: [
            AffirmationToken(text: "You", style: .normal, order: 0),
            AffirmationToken(text: "are", style: .normal, order: 1),
            AffirmationToken(text: "capable", style: .purple, order: 2),
            AffirmationToken(text: "of", style: .normal, order: 3),
            AffirmationToken(text: "amazing", style: .orange, order: 4),
            AffirmationToken(text: "things.", style: .normal, order: 5)
        ])
    )
    
    context.insert(
        Affirmation(tokens: [
            AffirmationToken(text: "Progress", style: .purple, order: 0),
            AffirmationToken(text: "is", style: .normal, order: 1),
            AffirmationToken(text: "progress.", style: .purple, order: 2)
        ])
    )
    
    context.insert(
        Affirmation(tokens: [
            AffirmationToken(text: "Good", style: .normal, order: 0),
            AffirmationToken(text: "job!", style: .orange, order: 1),
            AffirmationToken(text: "You've", style: .normal, order: 2),
            AffirmationToken(text: "got", style: .orange, order: 3),
            AffirmationToken(text: "this!", style: .orange, order: 4)
        ])
    )
    
    return AffirmationsView()
        .modelContainer(container)
}
