//
//  SpeechRecognitionManager.swift
//  CH3_8AM_TeachersGood
//
//  Created by Ahmad Taufiq Hidayat on 28/05/26.
//

import SwiftUI
import Speech
import AVFoundation
import Observation

@Observable
@MainActor
public class SpeechRecognitionManager {
    
    public var transcript: AttributedString {
        var combined = finalizedTranscript
        combined.append(volatileTranscript)
        return combined
    }
    
    // NEW: Add this property to extract plain text for the AI inference
    public var recognizedText: String {
        return String(transcript.characters)
    }
    
    private var finalizedTranscript: AttributedString = ""
    private var volatileTranscript: AttributedString = ""
    
    private var audioEngine = AVAudioEngine()
    private var transcriber: SpeechTranscriber?
    private var analyzer: SpeechAnalyzer?
    private let converter = BufferConverter()
    
    private var inputBuilder: AsyncStream<AnalyzerInput>.Continuation?
    private var recognizerTask: Task<Void, Never>?
    
    private var currentLocale = Locale(identifier: "en-US")
    
    public init() {}
    
    public func updateLocale(identifier: String) {
        currentLocale = Locale(identifier: identifier)
    }
    
    public func startTranscribing() async {
        finalizedTranscript = ""
        volatileTranscript = AttributedString("Listening...")
        volatileTranscript.foregroundColor = .gray.opacity(0.7)
        
        do {
            try await setupAudioSession()
            try await setupAnalyzer()
            try await startAudioEngine()
        } catch {
            volatileTranscript = AttributedString("\nError: \(error.localizedDescription)")
            volatileTranscript.foregroundColor = .red
        }
    }
    
    public func stopTranscribing() async {
        audioEngine.stop()
        audioEngine.inputNode.removeTap(onBus: 0)
        
        inputBuilder?.finish()
        inputBuilder = nil
        
        do {
            try await analyzer?.finalizeAndFinishThroughEndOfInput()
        } catch {
            print("Failed to turn off analyzer \(error)")
        }
        
        recognizerTask?.cancel()
        recognizerTask = nil
        
        if !volatileTranscript.characters.isEmpty {
            var finalPiece = volatileTranscript
            finalPiece.foregroundColor = .primary
            finalizedTranscript.append(finalPiece)
            volatileTranscript = ""
        }
    }
    
    private func setupAudioSession() async throws {
        let audioSession = AVAudioSession.sharedInstance()
        guard await AVAudioApplication.requestRecordPermission() else {
            throw NSError(domain: "Audio", code: 1, userInfo: [NSLocalizedDescriptionKey: "Mic access denied"])
        }
        try audioSession.setCategory(.playAndRecord, mode: .measurement, options: .duckOthers)
        try audioSession.setActive(true, options: .notifyOthersOnDeactivation)
    }
    
    private func setupAnalyzer() async throws {
        transcriber = SpeechTranscriber(
            locale: currentLocale,
            transcriptionOptions: [],
            reportingOptions: [.volatileResults],
            attributeOptions: [.audioTimeRange]
        )
        guard let transcriber else { throw NSError(domain: "Speech", code: 2, userInfo: [NSLocalizedDescriptionKey: "Failed to Initialize Trascriber"]) }
        
        analyzer = SpeechAnalyzer(modules: [transcriber])
        
        let (stream, continuation) = AsyncStream<AnalyzerInput>.makeStream()
        self.inputBuilder = continuation
        
        recognizerTask = Task { [weak self] in
            guard let self else { return }
            do {
                for try await result in transcriber.results {
                    var text = result.text
                    
                    if result.isFinal {
                        text.foregroundColor = .primary
                        self.finalizedTranscript.append(text)
                        self.volatileTranscript = ""
                    } else {
                        text.foregroundColor = .blue.opacity(0.5)
                        self.volatileTranscript = text
                    }
                }
            } catch {
                print("Transcription process stopped: \(error)")
            }
        }
        
        try await analyzer?.start(inputSequence: stream)
    }
    
    private func startAudioEngine() async throws {
        let inputNode = audioEngine.inputNode
        let recordingFormat = inputNode.outputFormat(forBus: 0)
        
        let analyzerFormat = await SpeechAnalyzer.bestAvailableAudioFormat(compatibleWith: [transcriber!])
        
        inputNode.installTap(onBus: 0, bufferSize: 4096, format: recordingFormat) { [weak self] (buffer, time) in
            guard let self = self, let analyzerFormat = analyzerFormat else { return }
            
            do {
                let convertedBuffer = try self.converter.convertBuffer(buffer, to: analyzerFormat)
                let input = AnalyzerInput(buffer: convertedBuffer)
                
                self.inputBuilder?.yield(input)
            } catch {
                print("Failed to convert audio buffer: \(error)")
            }
        }
        
        audioEngine.prepare()
        try audioEngine.start()
        
        volatileTranscript = ""
    }
}

class BufferConverter {
    enum Error: Swift.Error {
        case failedToCreateConverter
        case failedToCreateConversionBuffer
        case conversionFailed(NSError?)
    }
    
    private var converter: AVAudioConverter?
    
    func convertBuffer(_ buffer: AVAudioPCMBuffer, to format: AVAudioFormat) throws -> AVAudioPCMBuffer {
        let inputFormat = buffer.format
        guard inputFormat != format else {
            return buffer
        }
        
        if converter == nil || converter?.outputFormat != format {
            converter = AVAudioConverter(from: inputFormat, to: format)
            converter?.primeMethod = .none
        }
        
        guard let converter else {
            throw Error.failedToCreateConverter
        }
        
        let sampleRateRatio = converter.outputFormat.sampleRate / converter.inputFormat.sampleRate
        let scaledInputFrameLength = Double(buffer.frameLength) * sampleRateRatio
        let frameCapacity = AVAudioFrameCount(scaledInputFrameLength.rounded(.up))
        
        guard let conversionBuffer = AVAudioPCMBuffer(pcmFormat: converter.outputFormat, frameCapacity: frameCapacity) else {
            throw Error.failedToCreateConversionBuffer
        }
        
        var nsError: NSError?
        var bufferProcessed = false
        
        let status = converter.convert(to: conversionBuffer, error: &nsError) { packetCount, inputStatusPointer in
            defer { bufferProcessed = true }
            inputStatusPointer.pointee = bufferProcessed ? .noDataNow : .haveData
            return bufferProcessed ? nil : buffer
        }
        
        guard status != .error else {
            throw Error.conversionFailed(nsError)
        }
        
        return conversionBuffer
    }
}
