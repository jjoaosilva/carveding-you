//
//  StarUIView.swift
//  carvedingYou
//
//  Created by José João Silva Nunes Alves on 21/06/21.
//

import SwiftUI

struct StarUIView: View {
    @ObservedObject var viewModel: CarvingViewModel = CarvingViewModel()

    @State private var selectedImage: UIImage?
    @State private var isImagePickerDisplay = false
    @State private var hasPhoto = false

    var body: some View {
        ZStack {
            VStack {
                Color("backgroundTopColor")
                Color("backgroundBottomColor")
            }
            Image("background")
                .aspectRatio(contentMode: .fill)

            Button("Camera") {
                self.isImagePickerDisplay.toggle()
            }.padding()

        }
        .ignoresSafeArea()
        .sheet(isPresented: self.$isImagePickerDisplay) {
            ImagePickerView(selectedImage: self.$selectedImage, completion: self.handle, sourceType: .camera)
        }
        .sheet(isPresented: self.$hasPhoto, content: {
            Text(self.viewModel.carving.rawValue)
        })
    }

    func handle(image: UIImage) {
        self.hasPhoto = true
        self.viewModel.handle(image: image)
    }
}

struct StarUIView_Previews: PreviewProvider {
    static var previews: some View {
        StarUIView()
    }
}
