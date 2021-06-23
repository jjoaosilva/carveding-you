//
//  CustomButtonSwiftUIView.swift
//  carvedingYou
//
//  Created by José João Silva Nunes Alves on 21/06/21.
//

import SwiftUI

struct CustomButtonView: View {

    @State private var wasTapped: Bool = false
    @State private var animationMountRock: CGFloat = 1
    @State private var animationMountBusto: CGFloat = 0

    private var scale: CGFloat {
        return wasTapped ? 0.95 : 1.0
    }

    var action: (() -> Void)?

    var body: some View {
        ZStack {
            Color(.white)
                .opacity(0.45)
                .cornerRadius(22)
                .frame(width: 150, height: 150, alignment: .center)

            VStack {
                ZStack {
                    Image("pedra")
                        .aspectRatio(contentMode: .fit)
                        .scaleEffect(animationMountRock)
                        .animation(.easeInOut(duration: 0.5))
                    Image("busto")
                        .aspectRatio(contentMode: .fit)
                        .scaleEffect(animationMountBusto)
                        .animation(.easeInOut(duration: 0.5))
                }
                Text("Carve!")
                    .font(.system(size: 17, weight: .medium, design: .rounded))
                    .foregroundColor(.gray)
            }
        }
        .scaleEffect(self.scale)
        .onTapGesture {
            self.wasTapped.toggle()
            self.animationMountRock = 0
            self.animationMountBusto = 1

            DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                self.animationMountRock = 1
                self.animationMountBusto = 0
                self.wasTapped.toggle()
                self.action?()
            }
        }
    }
}

struct CustomButtonSwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        CustomButtonView()
    }
}
