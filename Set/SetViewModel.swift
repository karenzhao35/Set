//
//  SetViewModel.swift
//  Set
//
//  Created by Karen Zhao on 2024-07-27.
//

import SwiftUI

class SetViewModel: ObservableObject {
    typealias Card = SetModel.Card
    @Published private var game: SetModel
    @Published private var disableDealButton: Bool
    @Published private var matched: Set<Card.ID>
    
    private var numberOfStartingCards: Int
    init() {
        game = SetModel()
        disableDealButton = false
        numberOfStartingCards = 12
        matched = Set<Card.ID>()
    }
    
    var cards: Array<SetModel.Card> {
        return Array(game.cards[0..<game.nextCardIndex])
    }
    
    var successNotifier: Bool? {
        return game.successNotifier
    }
    
    var cardsRemoved: Int {
        return game.cardsRemoved
    }
    
    var nextCardIndex: Int {
        return game.nextCardIndex
    }
    
    var dealButtonState: Bool {
        return disableDealButton
    }
    
    var matchedCards: Set<Card.ID> {
        return matched
    }
    
    @ViewBuilder
    func getShape(_ card: SetModel.Card) -> some View {
        switch(card.shape) {
        case .type1:
            returnCorrectShade(AnyShape(Rectangle()), card)
        case .type2:
            returnCorrectShade(AnyShape(RoundedRectangle(cornerSize: CGSize(width: 30, height: 20))), card)
        case .type3:
            returnCorrectShade(Diamond(), card)
        }
    }
    
    @ViewBuilder
    func returnCorrectShade<S: Shape>(_ shape: S, _ card: SetModel.Card) -> some View {
        switch(card.shade) {
        case .shade1:
            shape.fill(getCardColor(card))
        case .shade2:
            shape.stroke(getCardColor(card), lineWidth: 3)
        case .shade3:
            shape.fill(getCardColor(card).opacity(0.5))
        }
    }

    
    func getNumShapes(_ card: SetModel.Card) -> Int {
        return card.numOfShapes
    }
    
    func getCardColor(_ card: SetModel.Card) -> Color {
        switch (card.color) {
        case .color1:
            return .yellow
        case .color2:
            return .purple
        case .color3:
            return .teal
        }
    }

    func choose(_ card: SetModel.Card) {
        game.choose(card)
        matched = Set(game.cards.filter { $0.isMatched }.map { $0.id })
        print(matched)
    }
    
    // MARK: - Intents
    func dealThreeCards() {
        if !game.dealThreeCards() {
            disableDealButton = true
        }
    }
    
    func newGame() {
        game = SetModel()
        disableDealButton = false
        numberOfStartingCards = 12
    }
}
