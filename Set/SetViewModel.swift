//
//  SetViewModel.swift
//  Set
//
//  Created by Karen Zhao on 2024-07-27.
//

import SwiftUI

class SetViewModel: ObservableObject {
    @Published private var model: SetModel
    @Published var disableDealButton: Bool
    
    private var numberOfStartingCards: Int
    init() {
        model = SetModel()
        disableDealButton = false
        numberOfStartingCards = 12
    }
    
    var cards: Array<SetModel.Card> {
        return Array(model.cards[0..<model.nextCardIndex])
    }
    
    var successNotifier: Bool? {
        return model.successNotifier
    }
    
    var cardsRemoved: Int {
        print(model.cardsRemoved)
        return model.cardsRemoved
    }
    
    @ViewBuilder
    func getShape(_ card: SetModel.Card) -> some View {
        switch(card.shape) {
        case .type1:
            returnCorrectShade(AnyShape(Rectangle()), card)
        case .type2:
            returnCorrectShade(AnyShape(RoundedRectangle(cornerSize: CGSize(width: 30, height: 20))), card)
        case .type3:
            returnCorrectShade(AnyShape(Circle()), card)
        }
    }
    
    @ViewBuilder
    func returnCorrectShade(_ shape: AnyShape, _ card: SetModel.Card) -> some View {
        switch(card.shade) {
        case .shade1:
            shape.foregroundStyle(getCardColor(card))
        case .shade2:
            shape.stroke(getCardColor(card), lineWidth: 3)
        case .shade3:
            shape.foregroundStyle(getCardColor(card).opacity(0.5))
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
        model.choose(card)
    }
    
    // MARK: - Intents
    func dealThreeCards() {
        if model.nextCardIndex+2 < model.cards.count {
            model.nextCardIndex += 3
        } else {
            disableDealButton = true
        }
    }
    
    func newGame() {
        model = SetModel()
        model.nextCardIndex = numberOfStartingCards
        disableDealButton = false
    }
}
