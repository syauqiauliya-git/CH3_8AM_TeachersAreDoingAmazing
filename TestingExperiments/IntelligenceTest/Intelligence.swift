//
//  Intelligence.swift
//  CH3_8AM_TeachersGood
//
//  Created by Syauqi Auliya M on 25/05/26.
//

import FoundationModels

class Intelligence {
    private let session: LanguageModelSession
    
    init(systemPrompt: String) {
        session = LanguageModelSession(instructions: systemPrompt)
    }
    
    func send(prompt: String) async throws -> String {
        let model = SystemLanguageModel.default
        
        guard model.isAvailable else {
            return "Apple Intelligence not available on this device"
        }
        
        let response = try await session.respond(to: prompt)
        return response.content
    }
}



//
//let inference = Intelligence(
//    systemPrompt: "You are a warm, supportive assistant for school teachers."
//)
//@State private var response = "Tap the button"
//@State private var isLoading = false
//
//var body: some View {
//    VStack(spacing: 24) {
//        if isLoading {
//            ProgressView("Thinking...")
//        } else {
//            Text(response)
//                .padding()
//                .multilineTextAlignment(.center)
//        }
//
//        Button("Test Apple Intelligence") {
//            Task {
//                isLoading = true
//                do {
//                    response = try await inference.send(
//                        prompt: "Say hello to a tired teacher in one warm sentence."
//                    )
//                } catch {
//                    response = "Error: \(error)"
//                }
//                isLoading = false
//            }
//        }
//        .buttonStyle(.borderedProminent)
//    }
//    .padding()
//}
