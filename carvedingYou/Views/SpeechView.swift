//
//  SpeechView.swift
//  carvedingYou
//
//  Created by José João Silva Nunes Alves on 23/06/21.
//

import SwiftUI
import Speech
import AVFoundation

struct SpeechView: View {

    @State private var isRecording = false
    @State var titleButton = "Tap to start"
    @State var finalView: Bool = false
    var carving: Carving

    private var colorObjects: Color {
        return self.viewModel.endRecord ? Color.green : Color.red
    }

    @ObservedObject private var viewModel: SpeechViewModel = {
        let viewModel = SpeechViewModel()
        viewModel.recordPermissions()
        viewModel.requestTranscribePermissions()
        return viewModel
    }()

    var body: some View {
        if self.viewModel.textRocgnized == "" {
            ZStack {
                Color("backgroundTopColor")
                    .ignoresSafeArea()
                VStack {
                    Text("Agora, diga uma frase de efeito!")
                        .padding(30)
                    ZStack {
                        Circle()
                            .strokeBorder(lineWidth: 12, antialiased: true)
                            .foregroundColor(self.colorObjects)
                            .padding(10)
                        VStack {
                            Image(systemName: "mic")
                                .font(.system(size: 50, weight: .medium, design: .default))
                                .foregroundColor(self.colorObjects)
                            Text(self.viewModel.titleButton)
                                .font(.system(size: 22, weight: .medium, design: .default))
                                .foregroundColor(self.colorObjects)
                        }
                        .onTapGesture {
                            self.viewModel.recordTapped()
                        }
                    }
                }
            }
        } else {
            TransformSpeechView(text: self.viewModel.textRocgnized, carving: self.carving)
        }
    }
}
