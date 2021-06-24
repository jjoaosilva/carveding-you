//
//  CarvingEnum.swift
//  carvedingYou
//
//  Created by José João Silva Nunes Alves on 18/06/21.
//

import SwiftUI

enum Carving: String {
    case bustoNefertiti
    case david
    case gaulesMorrendo
    case mascaraAgamenon
    case pensador
    case venusMilo
    case padrao

    var name: String {
        switch self {
        case .bustoNefertiti:
            return "Busto de Nefertiti"
        case .david:
            return "David"
        case .gaulesMorrendo:
            return "O gaulês moribundo"
        case .mascaraAgamenon:
            return "Máscara Agamenon"
        case .pensador:
            return "O pensador"
        case .venusMilo:
            return "Vênus de Milo"
        case .padrao:
            return ""
        }
    }

    var image: UIImage {
        switch self {
        case .bustoNefertiti:
            return UIImage(named: "BustoDeNertiti")!
        case .david:
            return UIImage(named: "david")!
        case .gaulesMorrendo:
            return UIImage(named: "gaules")!
        case .mascaraAgamenon:
            return UIImage(named: "mascara")!
        case .pensador:
            return UIImage(named: "pensador")!
        case .venusMilo:
            return UIImage(named: "venus")!
        case .padrao:
            return UIImage()
        }
    }
}
