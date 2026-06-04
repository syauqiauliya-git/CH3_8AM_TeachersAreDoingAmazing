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

struct AffirmationProvider: TimelineProvider{
    func placeholder(in context: Context) -> AffirmationEntry {
        AffirmationEntry(date: Date(), affirmation: "You are becoming a better educator every day.")
    }
    
    func getSnapshot(in context: Context, completion: @escaping (AffirmationEntry) -> ()) {
        completion(AffirmationEntry(date: Date(), affirmation: "You are becoming a better educator every day."))
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<AffirmationEntry>) -> ()) {
        let entry = AffirmationEntry(date: Date(), affirmation: "You are becoming a better educator every day.")
        
        // Refresh at next midnight
        let midnight = Calendar.current.startOfDay(
            for: Calendar.current.date(byAdding: .day, value: 1, to: Date())!
        )
        let timeline = Timeline(entries: [entry], policy: .after(midnight))
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
