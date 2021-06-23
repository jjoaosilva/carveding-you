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
                .blur(radius: 2)
            CustomButtonView {
                self.isImagePickerDisplay.toggle()
            }
        }
        .ignoresSafeArea()
        .sheet(isPresented: self.$isImagePickerDisplay) {
            ImagePickerView(selectedImage: self.$selectedImage, completion: self.handle, sourceType: .camera)
        }
        .sheet(isPresented: self.$hasPhoto, content: {
            TransformationView(photo: $selectedImage)
        })
    }

    func handle() {
        self.hasPhoto = true
    }
}

struct StarUIView_Previews: PreviewProvider {
    static var previews: some View {
        StarUIView()
    }
}
