//
//  SuggestedStoriesView.swift
//  CH3_8AM_TeachersGood
//
//  Created by Ahmad Taufiq Hidayat on 02/06/26.
//


import SwiftUI

struct SuggestedStoriesView: View {
    @Environment(\.dismiss) private var dismiss
    var stories: [Story] = []
    
    // NEW: Binding connection to bubble selection up to the main input canvas
    @Binding var externalSelectedStory: Story?

    var body: some View {
        VStack(spacing: 15) {
            HStack {
                Text("Suggested stories")
                    .font(.custom("Futura", size: 17))
                    .foregroundColor(.appTextAlt)

                Image(systemName: "apple.intelligence")
                    .foregroundStyle(
                        LinearGradient(
                            colors: [.aiTeal, .aiBlue, .aiPurple, .aiRed, .aiYellow],
                            startPoint: .topTrailing,
                            endPoint: .bottomLeading
                        )
                    )
                    .font(.title2)
            }
            .accessibilityElement(children: .combine)
            .accessibilityAddTraits(.isHeader)

            // A single story can't fill the width, so center it instead of
            // letting the horizontal scroll view pin it to the leading edge.
            if stories.count == 1, let story = stories.first {
                Button(action: {
                    externalSelectedStory = story
                }) {
                    StoryCardView(title: story.title, imageName: story.image)
                }
                .buttonStyle(.plain)
                .frame(maxWidth: .infinity)
                .padding(.horizontal, 24)
            } else {
                // Horizontal layout wrapped inside a scroll container to gracefully manage size bounds
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 12) {
                        ForEach(stories, id: \.id) { story in
                            Button(action: {
                                externalSelectedStory = story
                            }) {
                                StoryCardView(title: story.title, imageName: story.image)
                            }
                            .buttonStyle(.plain)
                        }
                    }
                    .padding(.horizontal, 24)
                }
            }

            Button(action: { dismiss() }) {
                Text("Continue")
                    .font(.custom("Futura", size: 20))
                    .foregroundColor(.appBackground)
                    .frame(maxWidth: .infinity)
                    .frame(height: 57)
                    .background(Color.startSendRecord)
            }
            .cornerRadius(20)
            .padding(.horizontal, 24)
            .padding(.bottom, 32)
        }
        .background(Color.appBackground)
    }
}

struct StoryCardView: View {
    let title: String
    let imageName: String
    
    var body: some View {
        HStack(spacing: 8) {
            if let uiImage = UIImage(named: "placeholder-article-pic") {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 60, height: 60)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .accessibilityHidden(true)
            } else {
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.gray.opacity(0.3))
                    .frame(width: 60, height: 60)
                    .overlay(
                        Image(systemName: "photo")
                            .foregroundColor(.gray)
                    )
                    .accessibilityHidden(true)
            }
            
            Text(title)
                .font(.custom("Futura", size: 12))
                .foregroundColor(.appTextAlt)
                .multilineTextAlignment(.leading)
                .lineLimit(2) // Lock vertical lines to prevent unbounded sizing
                .truncationMode(.tail) // Formats trailing text gracefully
            
            Spacer(minLength: 0)
        }
        .padding(8)
        .frame(width: 160, height: 76) // Rigid dimensional frame mapping
        .background(Color.appSpeechBubble)
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}

#Preview("Single story") {
    SuggestedStoriesView(
        stories: [
            Story(title: "Caring for Little Hearts", image: "placeholder-article-pic")
        ],
        externalSelectedStory: .constant(nil)
    )
}

#Preview("Multiple stories") {
    SuggestedStoriesView(
        stories: [
            Story(title: "Caring for Little Hearts", image: "placeholder-article-pic"),
            Story(title: "A Hope in Every Click", image: "placeholder-article-pic"),
            Story(title: "Rare Dedication", image: "placeholder-article-pic")
        ],
        externalSelectedStory: .constant(nil)
    )
}
