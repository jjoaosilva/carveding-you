//
//  ContentView.swift
//  carvedingYou
//
//  Created by José João Silva Nunes Alves on 17/06/21.
//

import SwiftUI

struct ContentView: View {
    let viewModel: CarvingViewModel = CarvingViewModel()

    var body: some View {
        Text("Carveding you")
            .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
