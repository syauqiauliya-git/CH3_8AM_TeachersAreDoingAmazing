//
//  InferenceTestView.swift
//  CH3_8AM_TeachersGood
//
//  Created by Syauqi Auliya M on 04/06/26.
//

import SwiftUI

struct InferenceTestView: View {
    @State private var transcript = "Today was exhausting. The students kept ignoring me and I stayed two hours late marking. I don't know if I'm cut out for this."
    @State private var teacherName = "Sarah"
    @State private var whyIStarted = "I want to be the teacher I never had growing up."
    
    @State private var extractedLabels: [AffirmationLabel] = []
    @State private var thingyResponse = ""
    @State private var rephrasedAffirmation = ""
    @State private var isLoading = false
    @State private var errorMessage = ""
    
    let sampleAffirmation = "You cannot fix everything in one day. Forgive yourself."
    
    @State private var selectedAffirmation = ""
    
    let inference = InferenceService.shared
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                
                // Inputs
                Group {
                    label("Transcript")
                    TextEditor(text: $transcript)
                        .frame(height: 100)
                        .padding(8)
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                    
                    label("Teacher name")
                    TextField("Name", text: $teacherName)
                        .textFieldStyle(.roundedBorder)
                    
                    label("Why I started teaching")
                    TextField("Reason", text: $whyIStarted)
                        .textFieldStyle(.roundedBorder)
                }
                
                Divider()
                
                // Results
                if !extractedLabels.isEmpty {
                    label("Extracted labels")
                    Text(extractedLabels.map(\.rawValue).joined(separator: ", "))
                        .font(.system(.body, design: .monospaced))
                        .foregroundColor(.appPrimaryLight)
                }
                
                if !thingyResponse.isEmpty {
                    label("Thingy response")
                    Text(thingyResponse)
                        .padding()
                        .background(Color.appSpeechBubble)
                        .cornerRadius(12)
                }
                
                if !rephrasedAffirmation.isEmpty {
                    label("Rephrased affirmation")
                    Text(rephrasedAffirmation)
                        .italic()
                        .foregroundColor(.appTextSecondary)
                }
                
                if !errorMessage.isEmpty {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .font(.caption)
                }
                
                Divider()
                
                if !selectedAffirmation.isEmpty {
                    label("Matched affirmation")
                    Text(selectedAffirmation)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(12)
                }
                
                // Run buttons
                if isLoading {
                    ProgressView("Running...")
                        .frame(maxWidth: .infinity)
                } else {
                    Button("Run label extraction") {
                        runLabelExtraction()
                    }
                    .font(.system(size: 17, weight: .semibold))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 20)
                    .background(Color.appPrimaryLight)
                    .cornerRadius(20)
                    
                    Button("Run Thingy response") {
                        runThingyResponse()
                    }
                    .font(.system(size: 17, weight: .semibold))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 20)
                    .background(Color.appPrimaryLight)
                    .cornerRadius(20)
                    
                    Button("Run rephrase affirmation") {
                        runRephrase()
                    }
                    .font(.system(size: 17, weight: .semibold))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 20)
                    .background(Color.appPrimaryLight)
                    .cornerRadius(20)
                }
            }
            .padding(24)
        }
        .navigationTitle("Inference test")
    }
    
    private func selectAffirmation(for labels: [AffirmationLabel]) -> String {
        struct AffirmationSeed: Codable {
            let text: String
            let labels: [String]
        }

        guard let url = Bundle.main.url(forResource: "affirmations", withExtension: "json"),
              let data = try? Data(contentsOf: url),
              let all = try? JSONDecoder().decode([AffirmationSeed].self, from: data)
        else { return sampleAffirmation }

        let labelStrings = labels.map(\.rawValue)

        let matches = all.filter { affirmation in
            affirmation.labels.contains(where: { labelStrings.contains($0) })
        }

        return matches.randomElement()?.text ?? sampleAffirmation
    }
    
    private func label(_ text: String) -> some View {
        Text(text)
            .font(.caption)
            .foregroundColor(.appTextSecondary)
            .textCase(.uppercase)
    }
    
    private func runLabelExtraction() {
        isLoading = true
        errorMessage = ""
        extractedLabels = []
        selectedAffirmation = ""
        rephrasedAffirmation = ""
        thingyResponse = ""
        
        Task {
            do {
                let labels = try await inference.extractLabels(from: transcript)
                extractedLabels = labels
                selectedAffirmation = selectAffirmation(for: labels)
            } catch {
                errorMessage = error.localizedDescription
            }
            isLoading = false
        }
    }
    
    private func runThingyResponse() {
        isLoading = true
        errorMessage = ""
        Task {
            do {
                thingyResponse = try await inference.generateThingyResponse(
                    transcript: transcript,
                    affirmation: selectedAffirmation,
                    teacherName: teacherName
                )
            } catch {
                errorMessage = error.localizedDescription
            }
            isLoading = false
        }
    }

    private func runRephrase() {
        isLoading = true
        errorMessage = ""
        Task {
            do {
                rephrasedAffirmation = try await inference.rephraseAffirmation(
                    selectedAffirmation,
                    teacherName: teacherName,
                    whyIStarted: whyIStarted
                )
            } catch {
                errorMessage = error.localizedDescription
            }
            isLoading = false
        }
    }
}

#Preview {
    NavigationStack {
        InferenceTestView()
    }
}
