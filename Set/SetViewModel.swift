//
//  SetViewModel.swift
//  Set
//
//  Created by Karen Zhao on 2024-07-27.
//

import SwiftUI

class SetViewModel: ObservableObject {
    @Published private var model: SetModel
    @Published var cardsInPlay: Array<SetModel.Card>
    var nextCardIndex: Int
    init() {
        let localModel = SetModel()
        let localCardsInPlay = Array(localModel.cards[0..<12])
        model = localModel
        cardsInPlay = localCardsInPlay
        nextCardIndex = 12
    }
    var cards: Array<SetModel.Card> {
        return cardsInPlay
    }
    func choose(_ card: SetModel.Card) {
        model.choose(card)
    }
    func dealThreeCards() {
        if nextCardIndex+2 < 81 {
            for _ in 0..<3 {
                cardsInPlay.append(model.cards[nextCardIndex])
                nextCardIndex += 1
            }
        }
    }
    func newGame() {
        model = SetModel()
        cardsInPlay = Array(model.cards[0..<12])
        nextCardIndex = 12
    }
}
