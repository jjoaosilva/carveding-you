//
//  TransformationView.swift
//  carvedingYou
//
//  Created by José João Silva Nunes Alves on 22/06/21.
//

import SwiftUI

struct TransformationView: View {
    @ObservedObject var viewModel: CarvingViewModel = CarvingViewModel() 

    @Binding var photo: UIImage?

    var body: some View {
        ZStack {
            Color("backgroundTopColor")
            VStack {
                Text(self.viewModel.carving != .padrao ? self.viewModel.carving.rawValue : "Are you ready?")

                ZStack {
                    Image(uiImage: self.viewModel.hasPhoto ? self.viewModel.carving.image : self.photo!)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .clipShape(Circle())
                        .frame(width: 300, height: 300)
                        .animation(.default)
                }

                Button("Start!") {
                    self.viewModel.carving(photo: self.photo!)
                }
            }
        }
        .ignoresSafeArea()
    }
}
