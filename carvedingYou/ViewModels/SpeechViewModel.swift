//
//  SpeechViewModel.swift
//  carvedingYou
//
//  Created by José João Silva Nunes Alves on 23/06/21.
//
import SwiftUI
import Speech
import AVFoundation

class SpeechViewModel: ObservableObject {

    var recordAutorizaded: Bool = false
    var transcribeAutorizaded: Bool = false

    @Published var titleButton: String = "Aperte para gravar"
    @Published var endRecord: Bool = true
    @Published var newView: Bool = false
    @Published var textRocgnized: String = ""

    var sound: AVAudioPlayer!
    var recordingSession: AVAudioSession! = AVAudioSession()
    var audioRecorder: AVAudioRecorder! = AVAudioRecorder()
    var audioFilename: URL?
    
    let synthesizer = AVSpeechSynthesizer()
}

extension SpeechViewModel {
    public func recordPermissions() {
        do {
            try recordingSession.setCategory(.playAndRecord, mode: .default)
            try recordingSession.setActive(true)

            recordingSession.requestRecordPermission { allowed in
                DispatchQueue.main.async {
                    self.recordAutorizaded = allowed
                }
            }
        } catch {
            self.recordAutorizaded = false
        }
    }

    private func startRecording() {
        self.audioFilename = getDocumentsDirectory().appendingPathComponent("recording.m4a")

        let settings = [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
            AVSampleRateKey: 12000,
            AVNumberOfChannelsKey: 1,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
        ]

        do {
            audioRecorder = try AVAudioRecorder(url: audioFilename!, settings: settings)
            audioRecorder.record()

            self.endRecord = false
            self.titleButton = "Aperte para parar"
        } catch {
            finishRecording(success: false)
        }
    }

    private func finishRecording(success: Bool) {
        self.endRecord = true
        self.titleButton = "Aperte para gravar"

        audioRecorder.stop()

        self.transcribeAudio()

        audioRecorder = nil
    }

    private func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }

    public func recordTapped() {
        if audioRecorder == nil {
            startRecording()
        } else {
            finishRecording(success: true)
        }
    }
}

extension SpeechViewModel {
    public func requestTranscribePermissions() {
        SFSpeechRecognizer.requestAuthorization { authStatus in
            DispatchQueue.main.async {
                switch authStatus {
                case .authorized:
                    self.transcribeAutorizaded = true
                default:
                    self.transcribeAutorizaded = false
                }
            }
        }
    }

    public func transcribeAudio() {
        if let audioURL = self.audioFilename {

            let speechRecognizer = SFSpeechRecognizer(locale: Locale(identifier: "pt-BR"))
            let request = SFSpeechURLRecognitionRequest(url: audioURL)

            if let recognizer = speechRecognizer, recognizer.isAvailable {

                recognizer.recognitionTask(with: request) { result, error in
                    guard error == nil else { print("Error: \(error!)"); return }
                    guard let result = result else { print("No result!"); return }

                    if result.isFinal {
                        self.textRocgnized = result.bestTranscription.formattedString
                        print(result.bestTranscription.formattedString)
                    }
                }
            }
        }
    }
}

extension SpeechViewModel {
    public func talk(with string: String) {
        let voice = AVSpeechSynthesisVoice(language: "pt-BR")
        let utterance = setupUtterance(with: string)
        utterance.voice = voice

        synthesizer.speak(utterance)
    }

    private func setupUtterance(with string: String) -> AVSpeechUtterance {
        let utterance = AVSpeechUtterance(string: string)

        utterance.rate = 0.57
        utterance.pitchMultiplier = 0.8
        utterance.postUtteranceDelay = 0.2
        utterance.volume = 1.0

        return utterance
    }
}
