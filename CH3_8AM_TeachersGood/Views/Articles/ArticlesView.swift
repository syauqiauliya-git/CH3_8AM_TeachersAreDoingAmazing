//
//  ArticlesView.swift
//  CH3_8AM_TeachersGood
//
//  Created by Novia Rahman Nisa on 28/05/26.
//

import SwiftUI

struct ArticleSheetView: View {
    @State private var isBookmarked: Bool = false
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            VStack {
                Image("placeholder-article-pic")
                    .resizable()
                    .scaledToFill()
                    .frame(height: 250)
                Text("Behind every award-winning teacher is someone who once inspired them. As this year’s teaching award winners reflected on their journeys, many shared stories of mentors, family members, and former teachers who shaped the way they teach today. Some remembered educators who believed in them during difficult moments, while others spoke about people who showed them the importance of patience, kindness, and encouragement. Those experiences stayed with them and now influence the way they support their own students. For many winners, the award was not just a celebration of their work, but also a tribute to the people who helped them become the teachers they are today.")
                    .padding()
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
    @State private var isArticleDetailOpen = false
    
    let columns = [
        GridItem(.flexible())
    ]
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: true) {
            VStack {
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
                            colors: [
                                .clear,
                                .black.opacity(1.5)
                            ],
                            startPoint: .center,
                            endPoint: .bottom
                        )
                    }
                }
                .frame(height: 400)
                VStack {
                    HStack(spacing: 10) {
                        Text("All Stories")
                            .font(.headline.bold())
                        Image(systemName: "chevron.right")
                            .font(.body)
                        Spacer()
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
