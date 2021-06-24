//
//  TransformSpeechView.swift
//  carvedingYou
//
//  Created by José João Silva Nunes Alves on 24/06/21.
//

import SwiftUI

struct TransformSpeechView: View {

    @State var text: String
    var carving: Carving
    let viewModel: SpeechViewModel = SpeechViewModel()

    var body: some View {
        ZStack {
            Color("backgroundTopColor")
            VStack {
                Text(carving.name)

                Image(uiImage: carving.image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .clipShape(Circle())
                    .frame(width: 300, height: 300)
                    .animation(.default)

                Text(self.text)
            }
        }
        .ignoresSafeArea()
        .onAppear(perform: {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.viewModel.talk(with: self.text)
            }
        })
    }
}
