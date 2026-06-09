//
//  ArticlesView.swift
//  CH3_8AM_TeachersGood
//
//  Created by Novia Rahman Nisa on 28/05/26.
//

import SwiftUI
import SwiftData
import MarkdownUI

struct ArticleSheetView: View {
    @Environment(\.dismiss) var dismiss
    
    let story: Story
    
    var body: some View {
        let markdown = MarkdownLoader.load(story.mdFileName)
        
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading) {
                    Image(story.image)
                        .resizable()
                        .scaledToFill()
                        .frame(maxWidth: .infinity, minHeight: 250, maxHeight: 250)
                        .clipped()
                    Markdown(markdown)
                        .markdownTextStyle(\.text) {
                            FontFamily(.custom("Nunito"))
                        }
                        .font(.custom("Nunito", size: 18, relativeTo: .body))
                        .padding(30)
                }
            }
            .ignoresSafeArea(edges: .top)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button { dismiss() } label: {
                        Label("Close", systemImage: "xmark")
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        story.isBookmarked.toggle()
                    } label: {
                        Image(systemName: story.isBookmarked ? "bookmark.fill" : "bookmark")
                            .foregroundStyle(Color.appPrimaryLight)
                    }
                }
            }
        }
    }
}

enum SortOption {
    case recent, alphabetical
}

struct ArticlesView: View {
    @Environment(\.modelContext) var modelContext
    
    @Query var stories: [Story]
    
    @State private var currentIndex = 0
    @State private var selectedStory: Story?
    @State private var selectedStoryTab = "All Stories"
    @State private var sortOption: SortOption = .recent
    
    let filterStoryOptions: [String] = ["All Stories", "Favourites"]
    
    var filteredStories: [Story] {
        let filtered: [Story]
        switch selectedStoryTab {
        case "Favourites": filtered = stories.filter { $0.isBookmarked }
        default: filtered = stories
        }
        
        switch sortOption {
        case .recent:       return filtered.sorted { $0.storyDate > $1.storyDate }
        case .alphabetical: return filtered.sorted { $0.title < $1.title }
        }
    }
    
    let columns = [GridItem(.flexible())]
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: true) {
            VStack {
                TabView(selection: $currentIndex) {
                    ForEach(0..<min(3, stories.count), id: \.self) { index in
                        let story = stories[index]
                        Button {
                            selectedStory = story
                        } label: {
                            VStack(alignment: .leading, spacing: 6) {
                                Text(story.title)
                                    .font(.title.bold())
                                Text(story.summary)
                                    .font(.subheadline)
                                    .lineLimit(2)
                                    .opacity(0.8)
                            }
                            .foregroundStyle(Color.white)
                            .padding(20)
                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomLeading)
                            .background {
                                ZStack {
                                    Image(story.image)
                                        .resizable()
                                        .scaledToFill()
                                    LinearGradient(
                                        colors: [.clear, .black.opacity(1.5)],
                                        startPoint: .center,
                                        endPoint: .bottom
                                    )
                                }
                            }
                        }
                        .buttonStyle(.plain)
                        .tag(index)
                    }
                }
                .tabViewStyle(.page(indexDisplayMode: .never))
                .frame(height: 400)
                HStack(spacing: 8) {
                    ForEach(0..<min(3, stories.count), id: \.self) { index in
                        Circle()
                            .fill(currentIndex == index ? Color.appGradeBorder : Color.appGradeBorder.opacity(0.3))
                            .frame(width: 8, height: 8)
                    }
                }
                .padding(.top, 6)
                Picker("HomePicker", selection: $selectedStoryTab) {
                    ForEach(filterStoryOptions, id: \.self) { option in
                        Text(option).tag(option)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding(.horizontal, 25)
                .padding(.vertical, 10)
                .onAppear {
                    UISegmentedControl.appearance().selectedSegmentTintColor = UIColor(Color.appSpeechBubble)
                    UISegmentedControl.appearance().backgroundColor = UIColor(Color(uiColor: .systemBackground))
                    UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor(Color.appTextBnW)], for: .selected)
                    UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor(Color.appTextBnW)], for: .normal)
                }
<<<<<<< HEAD
//                }
=======
>>>>>>> novia
                VStack {
                    HStack(spacing: 10) {
                        Text(sortOption == .recent ? "Recents" : "A–Z")
                            .font(.headline.bold())
                        Spacer()
                        Menu {
                            Button {
                                sortOption = .recent
                            } label: {
                                Label("Recent", systemImage: sortOption == .recent ? "checkmark" : "")
                            }
                            Button {
                                sortOption = .alphabetical
                            } label: {
                                Label("Alphabetical", systemImage: sortOption == .alphabetical ? "checkmark" : "")
                            }
                        } label: {
                            Image(systemName: "line.3.horizontal.decrease")
                                .font(.body)
                        }
                        .buttonStyle(.plain)
                    }
                    LazyVGrid(columns: columns, spacing: 15) {
                        ForEach(filteredStories) { story in
                            GeometryReader { proxy in
                                Button {
                                    selectedStory = story
                                } label: {
                                    VStack(alignment: .leading, spacing: 0) {
                                        Image(story.image)
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: proxy.size.width, height: 200)
                                            .clipped()
                                        VStack(alignment: .leading, spacing: 6) {
                                            Text(story.title)
                                                .font(.title2.bold())
                                                .foregroundStyle(.primary)
                                            Text(story.summary)
                                                .font(.subheadline)
                                                .foregroundStyle(.secondary)
                                                .lineLimit(2)
                                        }
                                        .padding(16)
                                    }
                                    .background(Color(uiColor: .systemBackground))
                                    .clipShape(RoundedRectangle(cornerRadius: 25))
                                }
                                .buttonStyle(.plain)
                            }
                            .frame(height: 320)
                        }
                    }
                }
                .padding(.horizontal, 25)
            }
        }
        .background(Color.appBackground)
        .sheet(item: $selectedStory) { story in
            ArticleSheetView(story: story)
        }
        .ignoresSafeArea(edges: .top)
        .onAppear {
            seedStoriesIfNeeded(context: modelContext)
        }
    }
    
    func seedStoriesIfNeeded(context: ModelContext) {
        do {
            let existing = try context.fetch(FetchDescriptor<Story>())
            guard existing.isEmpty else { return }
            for story in StorySeedData.all {
                context.insert(story)
            }
            try context.save()
        } catch {
            print("Story seeding error:", error)
        }
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Story.self, configurations: config)
    let context = container.mainContext
    
    context.insert(Story(
        title: "A Rare Dedication to Education",
        mdFileName: "rare-dedication",
        image: "placeholder-article-pic",
        summary: "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
        isBookmarked: false,
        storyDate: Date()
    ))
    
    return ArticlesView()
        .modelContainer(container)
}
