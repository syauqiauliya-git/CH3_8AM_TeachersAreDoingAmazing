//
//  IntervalInputView.swift
//  CH3_8AM_TeachersGood
//
//  Created by Syauqi Auliya M on 04/06/26.
//


import SwiftUI
import SwiftData

struct IntervalInputView: View {
    @Environment(\.modelContext) var modelContext
    @Query var teachers: [Teacher]
    var teacher: Teacher? { teachers.first }
    
    @State private var selectedInterval: IntervalTime? = nil
    @State private var navigateToFinish = false
    @State private var notificationGranted = false
    
    
    var body: some View {
        
        VStack{
            
            // PAGE NUMBER
            
            HStack {
                Spacer()
                Text("4 of 4")
                    .font(.custom("Futura", size: 14))
                    .foregroundColor(.appPrimaryLight)
                    .opacity(0.4)
            }
            .padding(.horizontal, 24)
            .padding(.top, 40)
            
            Spacer()
            
            
            // MASCOT QUESTION
            
            HStack(alignment: .center, spacing: 12) {
                //MascotView(size: 120)
                GifWebView(gifName: ThingyState.lookright.mode)
                    .frame(width: 100, height: 100)
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
                            .font(.custom(selectedInterval == interval ? "Nunito-Bold" : "Nunito-SemiBold", size: 16))
                            .foregroundColor(selectedInterval == interval ? .appGradeSelectedText : .appGradeNotSelectedText)
                        Spacer()
                    }
                    .padding(.horizontal, 20)
                    .padding(.vertical, 14)
                    .background(selectedInterval == interval ? Color.appSpeechBubble : Color.appGradeNotSelected)
                    .cornerRadius(15)
                    .overlay(
                        RoundedRectangle(cornerRadius: 18)
                            .stroke(Color.appGradeBorder.opacity(selectedInterval == interval ? 1 : 0.2), lineWidth: selectedInterval == interval ? 2 : 1)
                    )
                    .padding(.horizontal, 24)
                    .scaleEffect(x: selectedInterval == interval ? 1.1 : 1.0, y: selectedInterval == interval ? 1.2 : 1.0)
                    .animation(.spring(response: 0.3, dampingFraction: 0.6), value: selectedInterval)
                    .onTapGesture {
                        selectedInterval = interval
                    }
                    .accessibilityAddTraits(.isButton)
                    .accessibilityLabel(Text("\(interval.rawValue)"))
                    .opacity(selectedInterval == interval ? 1  : 0.6 )
                }
            }
            .padding(.horizontal, 15)
            
            
            Spacer()
            
            
            // DISCLAIMER
            
            
            Text("\(Image(systemName: "info.circle")) This will also affect how often you receive notifications if you activate them. This can be later modified on settings.")
                .font(.custom("Nunito-Medium", size: 13))
                .foregroundColor(.appPrimaryLight)
                .opacity(0.6)
                .padding(.horizontal, 35)
            
            //BUTTON
            //Use button_navdest because i need async task, the notifcs to run
            Button {
                Task {
                    let granted = await NotificationService.shared.requestPermission()
                    if granted {
                        NotificationService.shared.schedule(for: selectedInterval ?? .onetime)
                    }
                    teacher?.affirmationInterval = (selectedInterval ?? .onetime).rawValue
                    navigateToFinish = true
                }
            } label: {
                Text("Continue")
                    .font(.custom("Futura", size: 20))
                    .foregroundColor(.appBackground)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 15)
                    .background(selectedInterval == nil ? Color.startSendRecord.opacity(0.6) : Color.startSendRecord)
            }
            .cornerRadius(20)
            .padding(.horizontal, 35)
            .padding(.top, 16)
            .padding(.bottom, 32)
            .disabled(selectedInterval == nil)
            .navigationDestination(isPresented: $navigateToFinish) {
                FinishView()
            }
            
        }
        .background(Color.appBackground.ignoresSafeArea())
        .onAppear {
            if let saved = teacher?.affirmationInterval {
                selectedInterval = IntervalTime(rawValue: saved)
            }
        }
    }
}

#Preview {
    IntervalInputView()
}

