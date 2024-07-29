//
//  ContentView.swift
//  Set
//
//  Created by Karen Zhao on 2024-07-27.
//

import SwiftUI

struct SetView: View {
    @ObservedObject var viewModel: SetViewModel
    var body: some View {
        VStack {
            cards
            Button("Deal 3 more cards") {
                viewModel.dealThreeCards()
            }
            Button("New Game") {
                viewModel.newGame()
            }
        }
    }
    
    private var cards: some View {
        AspectVGrid(viewModel.cards, aspectRatio: 5/9) { card in
            CardView(card, viewModel)
                .padding(4)
                .onTapGesture {
                    viewModel.choose(card)
                }
                .foregroundStyle(card.isSelected ? Color.black : Color.gray)

        }
    }
    
    
}

struct CardView: View {
    var card: SetModel.Card
    @ObservedObject var viewModel: SetViewModel
    
    init(_ card: SetModel.Card, _ viewModel: SetViewModel) {
        self.card = card
        self.viewModel = viewModel
    }
    
    var body: some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: 12)
            Group {
                base.strokeBorder(lineWidth: 2.5)
                VStack {
                    ForEach(0..<viewModel.getNumShapes(card), id: \.self) { index in
                        viewModel.getShape(card)
                            .minimumScaleFactor(0.01)
                            .aspectRatio(2, contentMode: .fit)
                            .padding(10)
                           
                    }
                    
                                   
                }
            }
        }
        .opacity(!card.isMatched ? 1 : 0)
    }
}


#Preview {
    SetView(viewModel: SetViewModel())
}
