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

    public func carving(photo: UIImage, handle: @escaping () -> Void) {
        service.predicate(image: photo, completionHandler: { result in
            self.handleService(result: result, handle: handle)
        })
    }

    private func handleService(result: Result<Carving, ModelError>, handle: @escaping () -> Void) {
        switch result {
        case .success(let predicateCarving):
            self.carving = predicateCarving
            self.hasPhoto = true
            handle()
        case .failure(_):
            self.carving = Carving.padrao
        }
    }
}
