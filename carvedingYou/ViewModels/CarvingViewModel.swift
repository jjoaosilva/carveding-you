//
//  CarvingViewModel.swift
//  carvedingYou
//
//  Created by José João Silva Nunes Alves on 18/06/21.
//

import SwiftUI

class CarvingViewModel {
    let service: CarvingService = CarvingService()
    var carving: Carving = .padrao

//    init() {
//        carving(photo: UIImage(named: "eu")!)
//    }

    public func carving(photo: UIImage) {
        service.predicate(image: photo, completionHandler: self.handleService)
    }

    private func handleService(result: Result<Carving, ModelError>) {
        switch result {
        case .success(let predicateCarving):
            self.carving = predicateCarving
        case .failure(_):
            self.carving = Carving.padrao
        }
    }
}
