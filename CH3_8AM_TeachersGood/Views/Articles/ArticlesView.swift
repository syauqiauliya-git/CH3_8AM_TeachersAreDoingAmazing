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
    @State private var isBookmarked: Bool = false
    
    @Environment(\.dismiss) var dismiss
    
    let markdown = MarkdownLoader.load("rare-dedication")
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading) {
                    Image("placeholder-article-pic")
                        .resizable()
                        .scaledToFill()
                        .frame(height: 250)
                        .clipped()
                    
                    Markdown(markdown)
                        .markdownTextStyle(\.text) {
                            FontFamily(.custom("Nunito"))
                        }
                        .font(.custom("Nunito", size: 18, relativeTo: .body))
                        .padding(30)
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: {
                        dismiss()
                    }) {
                        Label("Close", systemImage: "xmark")
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        isBookmarked.toggle()
                    } label: {
                        Image(systemName: isBookmarked ? "bookmark.fill" : "bookmark")
                            .foregroundStyle(Color.appPrimaryLight)
                    }
                }
            }
        }
    }
}

struct ArticlesView: View {
    @Environment(\.modelContext) var modelContext
    
    @Query var stories: [Story]
    
    @State private var currentIndex = 0
    @State private var isArticleDetailOpen = false
    @State private var selectedStoryTab = "All Stories"
    
    let filterStoryOptions: [String] = [
        "All Stories", "Favourites"
    ]
    
    let columns = [
        GridItem(.flexible())
    ]
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: true) {
            VStack {
                TabView(selection: $currentIndex) {
                    ForEach(0..<3, id: \.self) { index in
                        VStack(alignment: .leading) {
                            Text("Inspirational teachers")
                                .font(.title.bold())
                            Text("Teaching Award winners share who made an impact on them.")
                                .font(.body)
                        }
                        .foregroundStyle(Color.white)
                        .padding(20)
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomLeading)
                        .background {
                            ZStack {
                                Image("placeholder-article-pic")
                                    .resizable()
                                    .scaledToFill()
                                LinearGradient(
                                    colors: [.clear, .black.opacity(1.5)],
                                    startPoint: .center,
                                    endPoint: .bottom
                                )
                            }
                        }
                        .tag(index) // this is the key part
                    }
                }
                .tabViewStyle(.page(indexDisplayMode: .never))
                .frame(height: 400)
                HStack(spacing: 8) {
                    ForEach(0..<3, id: \.self) { index in
                        Circle()
                            .fill(currentIndex == index ? Color.appGradeBorder : Color.appGradeBorder.opacity(0.3))
                            .frame(width: 8, height: 8)
                    }
                }
                .padding(.top, 6)
                Picker("HomePicker", selection: $selectedStoryTab) {
                    ForEach(filterStoryOptions, id: \.self) { index in
                        Text(index).tag(index)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding(.horizontal, 25)
                .padding(.vertical, 10)
                VStack {
                    HStack(spacing: 10) {
                        Text("Recents")
                            .font(.headline.bold())
                        Spacer()
                        Image(systemName: "line.3.horizontal.decrease")
                            .font(.body)
                    }
                    LazyVGrid(columns: columns, spacing: 15) {
                        ForEach(1...10, id: \.self) { index in
                            Button {
                                isArticleDetailOpen = true
                            } label: {
                                RoundedRectangle(cornerRadius: 25)
                                    .frame(maxWidth: .infinity)
                                    .frame(height: 250)
                                    .overlay {
                                        ZStack {
                                            Image("placeholder-article-pic")
                                                .resizable()
                                                .scaledToFill()
                                            LinearGradient(
                                                colors: [
                                                    .clear,
                                                    .black.opacity(0.9)
                                                ],
                                                startPoint: .center,
                                                endPoint: .bottom
                                            )
                                            VStack(alignment: .leading) {
                                                Text("Inspirational teachers")
                                                    .font(.title2.bold())
                                                Text("Teaching Award winners share who made an impact on them.")
                                                    .font(.subheadline)
                                            }
                                            .foregroundStyle(.white)
                                            .padding(20)
                                            .frame(
                                                maxWidth: .infinity,
                                                maxHeight: .infinity,
                                                alignment: .bottomLeading
                                            )
                                            .multilineTextAlignment(.leading)
                                        }
                                        .clipShape(RoundedRectangle(cornerRadius: 25))
                                    }
                            }
                        }
                    }
                }
                .padding(.horizontal, 25)
            }
        }
        .background(Color.appBackground)
        .sheet(isPresented: $isArticleDetailOpen) {
            ArticleSheetView()
        }
        .ignoresSafeArea(edges: .top)
    }
}

#Preview {
    ArticlesView()
}
