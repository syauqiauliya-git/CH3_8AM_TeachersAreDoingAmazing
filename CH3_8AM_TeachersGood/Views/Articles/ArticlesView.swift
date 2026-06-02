//
//  ArticlesView.swift
//  CH3_8AM_TeachersGood
//
//  Created by Novia Rahman Nisa on 28/05/26.
//

import SwiftUI

struct ArticlesView: View {
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
                            RoundedRectangle(cornerRadius: 25)
                                .fill(.gray)
                                .frame(maxWidth: .infinity)
                                .frame(height: 200)
                        }
                    }
                }
                .padding(20)
            }
        }
        .ignoresSafeArea(edges: .top)
    }
}

#Preview {
    ArticlesView()
}
