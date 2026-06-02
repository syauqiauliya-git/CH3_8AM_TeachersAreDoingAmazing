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
        VStack(spacing: 32) {
            
            HStack(spacing: 8) {
                Text("Suggested stories")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundColor(.appPrimaryLight)
                
                // is using and modifying this logo allowed?
                Image(systemName: "apple.intelligence")
                    .foregroundStyle(
                        LinearGradient(
                            colors: [.appGradientOrangeStart, .appGradientPurpleEnd],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .font(.title2)
            }
            .padding(.top, 24)
            
            HStack(spacing: 16) {
                StoryCardView(title: "Inspirational\nteachers", imageName: "teacher_image")
                StoryCardView(title: "Inspirational\nteachers", imageName: "teacher_image")
            }
            .padding(.horizontal, 20)
            
            Button(action: {
                dismiss()
            }) {
                Text("Continue")
                    .font(.custom("Futura", size: 20))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 20)
                    .background(Color.appPrimaryLight)
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
        HStack(spacing: 12) {
            
            if let uiImage = UIImage(named: imageName) {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 64, height: 64)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
            } else {
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color.gray.opacity(0.3))
                    .frame(width: 64, height: 64)
                    .overlay(
                        Image(systemName: "photo")
                            .foregroundColor(.gray)
                    )
            }
            
            Text(title)
                .font(.subheadline)
                .fontWeight(.semibold)
                .foregroundColor(.appTextPrimary)
                .lineLimit(2)
                .multilineTextAlignment(.leading)
            
            Spacer(minLength: 0)
        }
        .padding(8)
        .padding(.trailing, 8)
        .background(Color.appSpeechBubble)
        .clipShape(RoundedRectangle(cornerRadius: 24))
    }
}

#Preview {
    SuggestedStoriesView()
}
