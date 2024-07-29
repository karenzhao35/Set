//
//  SetModel.swift
//  Set
//
//  Created by Karen Zhao on 2024-07-27.
//

import Foundation

struct SetModel {
    private(set) var cards: Array<Card>
    private(set) var successNotifier: Bool?
    
    private var selected: Array<(card: Card, index: Int)>
    
    
    init() {
        cards = []
        selected = []
        createDeck()
        shuffle()
    }
    
    mutating private func createDeck() {
        var id = 0
        for shape in ShapeType.allCases {
            for colour in CardColor.allCases {
                for shade in Shade.allCases {
                    for num in 1...3 {
                        cards.append(Card(shape: shape, color: colour, shade: shade, numOfShapes: num, id: id))
                        id += 1
                    }
                }
            }
        }
    }
    
    
    mutating func shuffle() {
        cards.shuffle()
    }
    
    mutating func choose(_ card: Card) {
        
        if let chosenIndex = cards.firstIndex(where: { $0.id == card.id }) {
            if cards[chosenIndex].isSelected {
                cards[chosenIndex].isSelected = false
                if let toRemove = selected.firstIndex(where: {$0.card.id == card.id}) {
                    selected.remove(at: toRemove)
                }
            } else {
                handleCardSelection(chosenIndex)
                
            }
        }
    }
    
    mutating private func handleCardSelection(_ chosenIndex: Int) {
        if selected.count < 3 {
            successNotifier = nil
            cards[chosenIndex].isSelected = true
            selected.append((card: cards[chosenIndex], index: chosenIndex))
        } else {
            handleSetSelection(chosenIndex)
        }
    }
    
    mutating private func handleSetSelection(_ chosenIndex: Int) {
        if checkSet(selected) {
            successNotifier = true
            print("success!")
            for card in selected {
                cards[card.index].isMatched = true
            }
        } else {
            successNotifier = false
        }
        for card in selected {
            cards[card.index].isSelected = false
        }
        selected = []
    }
    
    private func checkSet(_ selectedCards: Array<(card: Card, index: Int)>) -> Bool {
        if selectedCards.count == 3 {
            let color: Set = [selectedCards[0].card.color, selectedCards[1].card.color, selectedCards[2].card.color]
            let shape: Set = [selectedCards[0].card.shape, selectedCards[1].card.shape, selectedCards[2].card.shape]
            let shade: Set = [selectedCards[0].card.shade, selectedCards[1].card.shade, selectedCards[2].card.shade]
            let numOfShapes: Set = [selectedCards[0].card.numOfShapes, selectedCards[1].card.numOfShapes, selectedCards[2].card.numOfShapes]
            
            return (color.count == 1 || color.count == 3) && (shape.count == 1 || shape.count == 3) && (shade.count == 1 || shade.count == 3) && (numOfShapes.count == 1 || numOfShapes.count == 3)

        } else {
            print("There is an error in the selection of the cards")
            return false
        }
    }
    
    
    struct Card: Equatable, Identifiable, CustomDebugStringConvertible {
        
        var isSelected = false
        var isMatched = false
        var shape: ShapeType
        var color: CardColor
        var shade: Shade
        var numOfShapes: Int
        
        var id: Int
        var debugDescription: String {
            "\(id)"
        }
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
