//
//  CarvingService.swift
//  carvedingYou
//
//  Created by José João Silva Nunes Alves on 18/06/21.
//

import CoreML
import Vision
import UIKit

class CarvingService {

    private var model: VNCoreMLModel?

    init() {
        let result = createModel()

        switch result {
        case .success(let model):
            self.model = model
        case .failure(_):
            self.model = nil
        }
    }

    private func createModel() -> Result<VNCoreMLModel, ModelError> {
        do {
            let model = try SculptureClassifier(configuration: MLModelConfiguration()).model
            let vnModel = try VNCoreMLModel(for: model)
            return .success(vnModel)
        } catch {
            return .failure(.cantCreate)
        }
    }

    public func predicate(image: UIImage, completionHandler: @escaping (Result<Carving, ModelError>) -> Void) {
        do {

            guard let ciImage = CIImage(image: image) else {
                completionHandler(.failure(.cantPredicate))
                return
            }

            let request = VNCoreMLRequest(model: self.model!) {(request, _) in
                guard let results = request.results as? [VNClassificationObservation] else {
                    completionHandler(.failure(.cantPredicate))
                    return
                }
                if let result = results.first, let carving = Carving(rawValue: result.identifier) {
                    completionHandler(.success(carving))
                }
            }

            let handle = VNImageRequestHandler(ciImage: ciImage)
            try handle.perform([request])

        } catch { completionHandler(.failure(.cantPredicate)) }
    }

}
