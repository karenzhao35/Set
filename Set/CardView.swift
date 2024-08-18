//
//  CardView.swift
//  Set
//
//  Created by Karen Zhao on 2024-08-08.
//

import SwiftUI

struct CardView: View {
    var card: SetModel.Card
    @ObservedObject var viewModel: SetViewModel
    
    init(_ card: SetModel.Card, _ viewModel: SetViewModel) {
        self.card = card
        self.viewModel = viewModel
    }
    
    var body: some View {
        if !card.isMatched {
            ZStack {
                RoundedRectangle(cornerRadius: 12).strokeBorder(lineWidth: 2.5)
                VStack {
                    ForEach(0..<viewModel.getNumShapes(card), id: \.self) { _ in
                        viewModel.getShape(card)
                            .minimumScaleFactor(0.01)
                            .aspectRatio(5/3, contentMode: .fit)
                    }
                }.padding(10)
            }
        }
    }
}
