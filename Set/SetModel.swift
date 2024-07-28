//
//  SetModel.swift
//  Set
//
//  Created by Karen Zhao on 2024-07-27.
//

import Foundation

struct SetModel {
    private(set) var cards: Array<Card>
    
    init() {
        cards = []
        createDeck()
        shuffle()
    }
    mutating private func createDeck() {
        for shape in ShapeType.allCases {
            for colour in CardColor.allCases {
                for shade in Shade.allCases {
                    for num in ShapeNumber.allCases {
                        cards.append(Card(shape: shape, color: colour, shade: shade, numOfShapes: num))
                    }
                }
            }
        }
    }
    
    
    mutating func shuffle() {
        cards.shuffle()
    }
    func choose(_card: Card) {
        
    }
    
    struct Card {
        var isSelected = false
        var isMatched = false
        var shape: ShapeType
        var color: CardColor
        var shade: Shade
        var numOfShapes: ShapeNumber
    }
}

enum ShapeType: CaseIterable {
    case type1, type2, type3
}
enum CardColor: CaseIterable {
    case color1, color2, color3
}
enum Shade: CaseIterable {
    case shade1, shade2, shade3
}
enum ShapeNumber: Int, CaseIterable {
    case one = 1, two, three
}
