//
//  CarvingViewModel.swift
//  carvedingYou
//
//  Created by José João Silva Nunes Alves on 18/06/21.
//

import SwiftUI

class CarvingViewModel: ObservableObject {
    let service: CarvingService = CarvingService()
    @Published var carving: Carving = .padrao
    @Published var hasPhoto = false

    public func carving(photo: UIImage) {
        service.predicate(image: photo, completionHandler: self.handleService)
    }

    private func handleService(result: Result<Carving, ModelError>) {
        switch result {
        case .success(let predicateCarving):
            self.carving = predicateCarving
            self.hasPhoto = true
        case .failure(_):
            self.carving = Carving.padrao
        }
    }

    func handle(image: UIImage) {
        self.carving(photo: image)
    }
}
