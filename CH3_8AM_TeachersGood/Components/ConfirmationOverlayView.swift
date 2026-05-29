//
//  ConfirmationOverlayView.swift
//  CH3_8AM_TeachersGood
//
//  Created by Ahmad Taufiq Hidayat on 29/05/26.
//


import SwiftUI

struct ConfirmationOverlayView: View {
    @Binding var isPresented: Bool
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.3)
                .ignoresSafeArea()
                .onTapGesture {
                    withAnimation {
                        isPresented = false
                    }
                }
            
            VStack() {
                VStack(spacing: 20) {
                    ZStack {
                        Circle()
                            .fill(Color(red: 92/255, green: 184/255, blue: 60/255))
                            .frame(width: 76, height: 76)
                        
                        Image(systemName: "checkmark")
                            .font(.system(size: 36, weight: .bold))
                            .foregroundColor(.white)
                    }
                    .padding(.top, 10)
                    
                    Text("Your voice entry has been sent!")
                        .font(.subheadline)
                        .fontWeight(.medium)
                        .foregroundColor(Color(red: 112/255, green: 111/255, blue: 207/255))
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 20)
                }
                .frame(width: 280, height: 170)
                .background(Color.white)
                .cornerRadius(24)
                .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 5)
            }
            
        }
    }
}

#Preview {
    ConfirmationOverlayView(isPresented: .constant(true))
}
