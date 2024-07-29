//
//  SetViewModel.swift
//  Set
//
//  Created by Karen Zhao on 2024-07-27.
//

import SwiftUI

class SetViewModel: ObservableObject {
    @Published private var model: SetModel
    @Published var nextCardIndex: Int
    init() {
        model = SetModel()
        nextCardIndex = 12
    }
    var cards: Array<SetModel.Card> {
        return Array(model.cards[0..<nextCardIndex])
    }
    
    func getCardColor(_ card: SetModel.Card) -> Color {
        switch (card.color) {
        case CardColor.color1:
            return Color.indigo
        case CardColor.color2:
            return Color.purple
        case CardColor.color3:
            return Color.green
        }
    }
    
    func choose(_ card: SetModel.Card) {
        model.choose(card)
    }
    func dealThreeCards() {
        if nextCardIndex+2 < 81 {
            nextCardIndex += 3
        }
    }
    func newGame() {
        model = SetModel()
        nextCardIndex = 12
    }
}
