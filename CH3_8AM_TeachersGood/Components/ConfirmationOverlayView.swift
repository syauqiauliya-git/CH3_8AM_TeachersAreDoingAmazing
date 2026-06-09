//
//  ConfirmationOverlayView.swift
//  CH3_8AM_TeachersGood
//
//  Created by Ahmad Taufiq Hidayat on 29/05/26.
//

import SwiftUI

struct ConfirmationOverlayView: View {
    @Binding var isPresented: Bool
    var onConfirm: () -> Void
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.3)
                .ignoresSafeArea()
                // Retaining the tap gesture provides an optional immediate bypass for impatient users,
                // though you can remove this modifier if you want the delay to be strictly enforced.
                .onTapGesture {
                    executeTransition()
                }
            
            VStack() {
                VStack(spacing: 20) {
                    ZStack {
                        Circle()
                            .fill(Color.appSuccessGreen)
                            .frame(width: 76, height: 76)
                        
                        Image(systemName: "checkmark")
                            .font(.system(size: 36, weight: .bold))
                            .foregroundColor(.white)
                    }
                    .padding(.top, 10)
                    .accessibilityHidden(true)
                    
                    Text("Your voice entry has been sent")
                        .font(.subheadline)
                        .fontWeight(.medium)
                        .foregroundColor(.appTextAlt)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 20)
                }
                .frame(width: 280, height: 170)
                .background(Color.appBackground)
                .cornerRadius(24)
                .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 5)
                .accessibilityElement(children: .combine)
            }
        }
        .onAppear {
            // Initiates a 2-second countdown the moment the overlay appears on screen
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                executeTransition()
            }
        }
    }
    
    /// Consolidates the transition logic to ensure consistent state management
    /// regardless of whether the dismissal was triggered automatically or manually.
    private func executeTransition() {
        withAnimation {
            isPresented = false
            onConfirm()
        }
    }
}

#Preview {
    ConfirmationOverlayView(isPresented: .constant(true), onConfirm: {} )
}
