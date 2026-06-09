//
//  SolaceWidget.swift
//  SolaceWidget
//
//  Created by Syauqi Auliya M on 04/06/26.
//


import WidgetKit
import SwiftUI

struct AffirmationEntry: TimelineEntry {
    let date: Date
    let affirmation: String
}

struct AffirmationProvider: TimelineProvider {
    
    // Helper function to extract the shared text, keeping provider methods clean
    private func fetchSharedAffirmation() -> String {
        let sharedDefaults = UserDefaults(suiteName: "group.com.Solaced")
        return sharedDefaults?.string(forKey: "activeAffirmation") ?? "You are capable of amazing things."
    }

    func placeholder(in context: Context) -> AffirmationEntry {
        AffirmationEntry(date: Date(), affirmation: fetchSharedAffirmation())
    }
    
    func getSnapshot(in context: Context, completion: @escaping (AffirmationEntry) -> ()) {
        completion(AffirmationEntry(date: Date(), affirmation: fetchSharedAffirmation()))
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<AffirmationEntry>) -> ()) {
        let currentAffirmation = fetchSharedAffirmation()
        let entry = AffirmationEntry(date: Date(), affirmation: currentAffirmation)
        
        // We set the policy to .never because the main app dictates when the text changes.
        // Whenever AffirmationsView loads a new quote, WidgetCenter forces this timeline to rebuild anyway.
        let timeline = Timeline(entries: [entry], policy: .never)
        completion(timeline)
    }
}

struct SolaceWidgetEntryView: View {
    var entry: AffirmationEntry
    @Environment(\.widgetFamily) var family

    var body: some View {
        switch family {
        case .systemSmall:  small
        case .systemMedium: medium
        default:            small
        }
    }

    // Affirmation top, Thingy bottom right
    var small: some View {
        ZStack(alignment: .bottomTrailing) {
            VStack(alignment: .leading) {
                Text(entry.affirmation)
                    .font(.system(size: 13, design: .serif))
                    .foregroundColor(.primary)
                    .multilineTextAlignment(.leading)
                    .lineLimit(5)
                Spacer()
            }
            .padding(14)

            Image("Thingy")
                .resizable()
                .scaledToFit()
                .frame(width: 52, height: 52)
                .padding(8)
        }
    }

    // Thingy left, affirmation right
    var medium: some View {
        HStack(spacing: 16) {
            Image("Thingy")
                .resizable()
                .scaledToFit()
                .frame(width: 72, height: 72)

            Text(entry.affirmation)
                .font(.system(size: 14, design: .serif))
                .foregroundColor(.primary)
                .multilineTextAlignment(.leading)
                .lineLimit(5)

            Spacer()
        }
        .padding(20)
    }
}

struct SolaceWidget: Widget {
    let kind: String = "SolaceWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: AffirmationProvider()) { entry in
            SolaceWidgetEntryView(entry: entry)
                .containerBackground(.fill.tertiary, for: .widget)
        }
        .configurationDisplayName("Daily Affirmation")
        .description("A daily reminder from Thingy.")
        .supportedFamilies([.systemSmall, .systemMedium])
    }
}

#Preview(as: .systemSmall) {
    SolaceWidget()
} timeline: {
    AffirmationEntry(date: .now, affirmation: "You are becoming a better educator every day bitch.")
}

#Preview(as: .systemMedium) {
    SolaceWidget()
} timeline: {
    AffirmationEntry(date: .now, affirmation: "You are becoming a better educatordfvfdbdfbfdb every day.")
}
