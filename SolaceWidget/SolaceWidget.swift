//
//  SolaceWidget.swift
//  SolaceWidget
//
//  Created by Syauqi Auliya M on 04/06/26.
//

import WidgetKit
import SwiftUI

// 1. Define lightweight codable structs to read the JSON from UserDefaults
struct WidgetToken: Codable {
    let text: String
    let styleRawValue: String // Store the enum as a string for easy transport
    let order: Int
}

struct AffirmationEntry: TimelineEntry {
    let date: Date
    let tokens: [WidgetToken] // Pass the tokens instead of a plain string
}

struct AffirmationProvider: TimelineProvider {
    
    // Helper function to extract and decode the token array
    private func fetchSharedTokens() -> [WidgetToken] {
        let sharedDefaults = UserDefaults(suiteName: "group.com.Solaced")
        
        guard let data = sharedDefaults?.data(forKey: "activeAffirmationTokens"),
              let tokens = try? JSONDecoder().decode([WidgetToken].self, from: data) else {
            // Fallback tokens if nothing is found
            return [
                WidgetToken(text: "You", styleRawValue: "normal", order: 0),
                WidgetToken(text: "are", styleRawValue: "normal", order: 1),
                WidgetToken(text: "capable", styleRawValue: "purple", order: 2),
                WidgetToken(text: "of", styleRawValue: "normal", order: 3),
                WidgetToken(text: "amazing", styleRawValue: "orange", order: 4),
                WidgetToken(text: "things.", styleRawValue: "normal", order: 5)
            ]
        }
        return tokens
    }
    
    func placeholder(in context: Context) -> AffirmationEntry {
        AffirmationEntry(date: Date(), tokens: fetchSharedTokens())
    }
    
    func getSnapshot(in context: Context, completion: @escaping (AffirmationEntry) -> ()) {
        completion(AffirmationEntry(date: Date(), tokens: fetchSharedTokens()))
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<AffirmationEntry>) -> ()) {
        let currentTokens = fetchSharedTokens()
        let entry = AffirmationEntry(date: Date(), tokens: currentTokens)
        
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
    
    private var coloredAffirmation: AttributedString {
        var result = AttributedString()
        
        for token in entry.tokens.sorted(by: { $0.order < $1.order }) {
            var part = AttributedString(token.text + " ")
            
            switch token.styleRawValue {
            case "purple": part.foregroundColor = .purpleHighlight
            case "orange": part.foregroundColor = .orangeHighlight
            default: part.foregroundColor = .primary
            }
            
            result += part
        }
        
        return result
    }
    
    // Pure text representation
    var small: some View {
        Text(coloredAffirmation)
            .font(.system(size: 28, weight: .medium, design: .serif)) // Bumped up base size significantly
            .minimumScaleFactor(0.4) // Allows graceful shrinking for longer quotes
            .multilineTextAlignment(.leading)
            .lineLimit(6)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading) // Centers vertically, aligns left
            .padding(16)
    }
    
    // Thingy left, affirmation right
        var medium: some View {
            HStack(spacing: 16) { // Tightened spacing slightly so it doesn't feel disconnected
                Image("Thingy")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 60, height: 60) // Shrunk Thingy significantly

                Text(coloredAffirmation)
                    .font(.system(size: 24, weight: .medium, design: .serif))
                    .minimumScaleFactor(0.5)
                    .multilineTextAlignment(.leading)
                    .lineLimit(4)

                Spacer(minLength: 0)
            }
            .padding(24)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
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

#Preview("Small Widget", as: .systemSmall) {
    SolaceWidget()
} timeline: {
    AffirmationEntry(date: .now, tokens: [
        WidgetToken(text: "You", styleRawValue: "normal", order: 0),
        WidgetToken(text: "are", styleRawValue: "normal", order: 1),
        WidgetToken(text: "capable", styleRawValue: "purple", order: 2),
        WidgetToken(text: "of", styleRawValue: "normal", order: 3),
        WidgetToken(text: "amazing", styleRawValue: "orange", order: 4),
        WidgetToken(text: "things.", styleRawValue: "normal", order: 5)
    ])
}

#Preview("Medium Widget", as: .systemMedium) {
    SolaceWidget()
} timeline: {
    AffirmationEntry(date: .now, tokens: [
        WidgetToken(text: "Progress", styleRawValue: "purple", order: 0),
        WidgetToken(text: "is", styleRawValue: "normal", order: 1),
        WidgetToken(text: "progress.", styleRawValue: "purple", order: 2)
    ])
}
