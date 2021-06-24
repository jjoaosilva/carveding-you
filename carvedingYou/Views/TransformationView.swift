//
//  TransformationView.swift
//  carvedingYou
//
//  Created by José João Silva Nunes Alves on 22/06/21.
//

import SwiftUI

struct TransformationView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel: CarvingViewModel = CarvingViewModel()
    @Binding var photo: UIImage?
    @State var hasPhoto: Bool = false

    var body: some View {
        ZStack {
            Color("backgroundTopColor")
            VStack {
                Text(self.viewModel.carving != .padrao ? self.viewModel.carving.name : "Você está pronto?")

                ZStack {
                    Image(uiImage: self.viewModel.hasPhoto ? self.viewModel.carving.image : self.photo!)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .clipShape(Circle())
                        .frame(width: 300, height: 300)
                        .animation(.default)
                }

                Button("Transformar!") {
                    self.viewModel.carving(photo: self.photo!, handle: self.handle)
                }
            }
        }
        .ignoresSafeArea()
        .sheet(isPresented: self.$hasPhoto, onDismiss: {presentationMode.wrappedValue.dismiss()}, content: {
            SpeechView(carving: self.viewModel.carving)
        })
    }

    func handle() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.hasPhoto = true
        }
    }
}
