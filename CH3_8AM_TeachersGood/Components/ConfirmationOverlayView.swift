//
//  ConfirmationOverlayView.swift
//  CH3_8AM_TeachersGood
//
//  Created by Ahmad Taufiq Hidayat on 29/05/26.
//

import SwiftUI

struct ConfirmationOverlayView: View {
    @Binding var isPresented: Bool
    @Binding var isProcessing: Bool
    var showProgress: Bool = false
    var onConfirm: () -> Void

    @State private var animating = false

    var body: some View {
        ZStack {
            Color.black.opacity(0.3)
                .ignoresSafeArea()

            VStack {
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

                    Text(showProgress
                        ? "Your voice entry has been sent\nand is being processed!"
                        : "Your voice entry has been sent")
                        .font(.subheadline)
                        .fontWeight(.medium)
                        .foregroundColor(.appTextAlt)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 20)

                    if showProgress {
                        Capsule()
                            .fill(Color.appPrimaryLight.opacity(0.2))
                            .frame(height: 4)
                            .overlay(
                                Capsule()
                                    .fill(Color.appPrimaryLight)
                                    .frame(width: 80)
                                    .offset(x: animating ? 90 : -90)
                                    .animation(
                                        .easeInOut(duration: 0.8).repeatForever(autoreverses: true),
                                        value: animating
                                    )
                            )
                            .clipped()
                            .padding(.horizontal, 20)
                            .padding(.bottom, 10)
                    }
                }
                .frame(width: 300)
                .background(Color.appBackground)
                .cornerRadius(24)
                .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 5)
            }
        }
        .onAppear {
            onConfirm()
            if showProgress {
                animating = true
            } else {
                // Original behaviour — auto dismiss after 2 seconds
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    withAnimation { isPresented = false }
                }
            }
        }
        .onChange(of: isProcessing) { _, newValue in
            if showProgress, !newValue {
                withAnimation { isPresented = false }
            }
        }
    }
}

#Preview {
    ConfirmationOverlayView(
        isPresented: .constant(true),
        isProcessing: .constant(true),
        onConfirm: {}
    )
}

