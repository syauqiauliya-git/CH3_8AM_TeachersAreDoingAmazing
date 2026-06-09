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
    
    let markdown = MarkdownLoader.load("story-1")
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading) {
                    Image("placeholder-article-pic")
                        .resizable()
                        .scaledToFill()
                        .frame(height: 250)
                        .clipped()
                    
                        .accessibilityHidden(true)
                    
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
                    .accessibilityLabel(Text(isBookmarked ? "Remove bookmark" : "Bookmark article"))
                }
            }
        }
    }
}

struct ArticlesView: View {
    @Environment(\.modelContext) var modelContext
    
    @Query var stories: [Story]
    
    @State private var isArticleDetailOpen = false
    
    let columns = [
        GridItem(.flexible())
    ]
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: true) {
            VStack {
                TabView {
                    ForEach(1...3, id: \.self) { index in
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
                                    .accessibilityHidden(true)
                                LinearGradient(
                                    colors: [
                                        .clear,
                                        .black.opacity(1.5)
                                    ],
                                    startPoint: .center,
                                    endPoint: .bottom
                                )
                            }
                        }
                        .accessibilityElement(children: .combine)
                    }
                }
                .tabViewStyle(.page)
                .frame(height: 400)
                VStack {
                    HStack(spacing: 10) {
                        Text("All Stories")
                            .font(.headline.bold())
                        Image(systemName: "chevron.right")
                            .font(.body)
                            .accessibilityHidden(true)
                        Spacer()
                    }
                    .accessibilityElement(children: .combine)
                    .accessibilityAddTraits(.isHeader)
                    
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
                                                .accessibilityHidden(true)
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
                .padding(20)
            }
        }
        .sheet(isPresented: $isArticleDetailOpen) {
            ArticleSheetView()
        }
        .ignoresSafeArea(edges: .top)
    }
}

#Preview {
    ArticlesView()
}
