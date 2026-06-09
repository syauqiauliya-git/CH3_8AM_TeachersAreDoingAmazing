//
//  PrivacyPolicyView.swift
//  CH3_8AM_TeachersGood
//
//  Created by Novia Rahman Nisa on 09/06/26.
//

import SwiftUI

struct PrivacyPolicyView: View {
    var body: some View {
        ScrollView(.vertical, showsIndicators: true) {
            VStack(alignment: .leading, spacing: 20) {
                // INTRO
                Text("Welcome to SolacEd. We are dedicated to providing school teachers with a supportive space for affirmations, reflection, and growth. Your privacy is of paramount importance to us. This Privacy Policy outlines how SolacEd handles information when you use our mobile application.")
                    .font(.custom("Nunito-Medium", size: 15))
                    .foregroundColor(.primary)
                    .lineSpacing(4)
                Divider()
                    .padding(.vertical, 5)
                // SECTION 1
                VStack(alignment: .leading, spacing: 8) {
                    Text("1. Information Collection and Use")
                        .font(.custom("Futura", size: 18))
                        .foregroundColor(Color.appGradeBorder)
                    Text("Voice Recording and Apple Intelligence")
                        .font(.custom("Nunito-Bold", size: 16))
                        .padding(.top, 4)
                    Text("• Local Ecosystem Processing: SolacEd includes features that allow you to interact using your voice. All voice recordings and audio data are routed directly to Apple Intelligence and iOS system-level frameworks for processing.\n• No App Storage: Aside from passing this audio input securely to Apple Intelligence to perform your requested action, SolacEd does not record, harvest, save, or store your voice data.\n• No External Transmission: Your spoken audio never touches our servers, nor is it collected by us or shared with any non-Apple third-party databases.")
                        .font(.custom("Nunito-Medium", size: 15))
                        .lineSpacing(4)
                    Text("Local Data Storage (SwiftData)")
                        .font(.custom("Nunito-Bold", size: 16))
                        .padding(.top, 8)
                    Text("Any personal preferences you configure—such as your name, grade level, appearance settings, affirmation intervals, and bookmarked articles—are saved locally on your device using Apple’s secure SwiftData framework. This data remains on your phone to run the app layout. If you have iCloud Backup enabled on your iOS device, this data may be securely backed up to your personal iCloud account by Apple; we have no access to this information.")
                        .font(.custom("Nunito-Medium", size: 15))
                        .lineSpacing(4)
                }
                // SECTION 2
                VStack(alignment: .leading, spacing: 8) {
                    Text("2. Third-Party Services")
                        .font(.custom("Futura", size: 18))
                        .foregroundColor(Color.appGradeBorder)
                    Text("SolacEd utilizes native Apple services (including Apple Intelligence, local speech-to-text frameworks, and push notifications) to function. These ecosystem utilities operate under Apple's own strict standard Privacy Policy. We do not incorporate data-harvesting third-party SDKs, marketing trackers, or ad networks.")
                        .font(.custom("Nunito-Medium", size: 15))
                        .lineSpacing(4)
                }
                // SECTION 3
                VStack(alignment: .leading, spacing: 8) {
                    Text("3. Data Security")
                        .font(.custom("Futura", size: 18))
                        .foregroundColor(Color.appGradeBorder)
                    
                    Text("Because SolacEd offloads voice tasks to Apple Intelligence and saves your preferences locally on your hardware, your safety relies on iOS built-in architecture. We highly recommend utilizing device-level locks like biometric screening (Face ID / Touch ID) or complex alphanumeric device passcodes.")
                        .font(.custom("Nunito-Medium", size: 15))
                        .lineSpacing(4)
                }
                // SECTION 4
                VStack(alignment: .leading, spacing: 8) {
                    Text("4. Children's Privacy")
                        .font(.custom("Futura", size: 18))
                        .foregroundColor(Color.appGradeBorder)
                    
                    Text("SolacEd is a tool built expressly for school teachers. We do not intentionally target, gather, or hold profiles of children under the age of 13.")
                        .font(.custom("Nunito-Medium", size: 15))
                        .lineSpacing(4)
                }
                // SECTION 5
                VStack(alignment: .leading, spacing: 8) {
                    Text("5. Changes to This Privacy Policy")
                        .font(.custom("Futura", size: 18))
                        .foregroundColor(Color.appGradeBorder)
                    Text("We may update our Privacy Policy from time to time to reflect changes in our app development or legal guidelines. Any updates will be posted directly within the app on this page.")
                        .font(.custom("Nunito-Medium", size: 15))
                        .lineSpacing(4)
                }
            }
            .padding(.horizontal, 24)
            .padding(.top, 16)
        }
        .background(Color.appBackground.ignoresSafeArea())
        .navigationTitle("Privacy & Policy")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    PrivacyPolicyView()
}
