//
//  IntervalInputView.swift
//  CH3_8AM_TeachersGood
//
//  Created by Syauqi Auliya M on 04/06/26.
//


import SwiftUI

struct IntervalInputView: View {
    
    @State private var selectedInterval: IntervalTime? = nil
    @State private var navigateToFinish = false
    @State private var notificationGranted = false
    
    
    var body: some View {
        
        VStack{
            
            // PAGE NUMBER
            
            HStack {
                Spacer()
                Text("2 of 4")
                    .font(.system(size: 14))
                    .foregroundColor(.appTextSecondary)
            }
            .padding(.horizontal, 24)
            .padding(.top, 16)
            
            
            // MASCOT QUESTION
            
            HStack(alignment: .center, spacing: 12) {
                MascotView(size: 120)
                SpeechBubbleView(
                    text: "How often do you want to receive affirmations?",
                    tail: .left
                )
                Spacer()
            }
            .padding(.horizontal, 24)
            .padding(.top, 24)
            
            Spacer()
            
            // TEACHING GROUP SELECTOR
            
            VStack(spacing: 20) {
                ForEach(IntervalTime.allCases, id: \.self) { interval in
                    HStack {
                        Text(interval.rawValue)
                            .font(.custom("Futura", size: 16))
                            .foregroundColor(selectedInterval == interval ? .appGradeSelectedText : .appGradeNotSelectedText)
                        Spacer()
                    }
                    .padding(.horizontal, 20)
                    .padding(.vertical, 14)
                    .background(selectedInterval == interval ? Color.appSpeechBubble : Color.appGradeNotSelected)
                    .cornerRadius(15)
                    .overlay(
                        RoundedRectangle(cornerRadius: 18)
                            .stroke(Color(hex: "#4723B5").opacity(selectedInterval == interval ? 1 : 0.2), lineWidth: selectedInterval == interval ? 2 : 1)
                    )
                    .padding(.horizontal, 24)
                    .scaleEffect(x: selectedInterval == interval ? 1.1 : 1.0, y: selectedInterval == interval ? 1.2 : 1.0)
                    .animation(.spring(response: 0.3, dampingFraction: 0.6), value: selectedInterval)
                    .onTapGesture {
                        selectedInterval = interval
                    }
                    .opacity(selectedInterval == interval ? 1  : 0.6 )
                }
            }
            .padding(.horizontal, 15)
            
            // CONTINUE BUTTONT
            
            Spacer()
            
            Text("\(Image(systemName: "info.circle")) This will also affect how often you receive notifications if you activate them. This can be later modified on settings.")
                .font(.system(size: 13))
                .foregroundColor(.appPrimaryLight)
                .padding(.horizontal, 30)
            
            //Use button_navdest because i need async task, the notifcs to run
            Button {
                Task {
                    let granted = await NotificationService.shared.requestPermission()
                    if granted {
                        NotificationService.shared.schedule(for: selectedInterval ?? .onetime)
                    }
                    navigateToFinish = true
                }
            } label: {
                Text("Continue")
                    .font(.custom("Futura", size: 20))
                    .foregroundColor(.appTextPrimary)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 20)
                    .background(selectedInterval == nil ? Color.appPrimaryLight.opacity(0.4) : Color.appPrimaryLight)
            }
            .cornerRadius(20)
            .padding(.horizontal, 24)
            .padding(.top, 16)
            .padding(.bottom, 32)
            .disabled(selectedInterval == nil)
            .navigationDestination(isPresented: $navigateToFinish) {
                FinishView()
            }
            
        }
        .background(Color.appBackground)
        
    }
}

#Preview {
    IntervalInputView()
}

