//
//  SetViewModel.swift
//  Set
//
//  Created by Karen Zhao on 2024-07-27.
//

import SwiftUI

class SetViewModel: ObservableObject {
    @Published private var model: SetModel = SetModel()
    
    var cards: Array<SetModel.Card> {
        return model.cards
    }
    
}
