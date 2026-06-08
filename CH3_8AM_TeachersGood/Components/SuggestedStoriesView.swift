//
//  SuggestedStoriesView.swift
//  CH3_8AM_TeachersGood
//
//  Created by Ahmad Taufiq Hidayat on 02/06/26.
//


import SwiftUI

struct SuggestedStoriesView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack(spacing: 15) {
            
            HStack() {
                Text("Suggested stories")
                    .font(.custom("Futura", size: 17))
                    .foregroundColor(.appTextAlt)
                
                Image(systemName: "apple.intelligence")
                    .foregroundStyle(
                        LinearGradient(
                            colors: [
                                .aiTeal,
                                .aiBlue,
                                .aiPurple,
                                .aiRed,
                                .aiYellow
                            ],
                            startPoint: .topTrailing,
                            endPoint: .bottomLeading
                        )
                    )
                    .font(.title2)
            }
            
            HStack(spacing: 8) {
                StoryCardView(title: "Inspirational\nteachers", imageName: "teacher_image")
                StoryCardView(title: "Inspirational\nteachers", imageName: "teacher_image")
            }
            
            Button(action: {
                dismiss()
            }) {
                Text("Continue")
                    .font(.custom("Futura", size: 20))
                    .foregroundColor(.appBackground)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 20)
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
        HStack(spacing: 6) {
            
            if let uiImage = UIImage(named: imageName) {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 75, height: 75)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
            } else {
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color.gray.opacity(0.3))
                    .frame(width: 75, height: 75)
                    .overlay(
                        Image(systemName: "photo")
                            .foregroundColor(.gray)
                    )
            }
            
            Text(title)
                .font(.custom("Futura", size: 13))
                .padding(.trailing, 4)
                .foregroundColor(.appTextAlt)
                .multilineTextAlignment(.leading)
            
        }
        .padding(4)
        .background(Color.appSpeechBubble)
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }
}

#Preview {
    SuggestedStoriesView()
}
