//
//  ContentView.swift
//  Set
//
//  Created by Karen Zhao on 2024-07-27.
//

import SwiftUI
// FIXME: cards not displaying correctly
struct SetView: View {
    @ObservedObject var viewModel: SetViewModel
    
    var body: some View {
        VStack {
            Text("Make a set!").font(.largeTitle)

            if (viewModel.cards.count - viewModel.cardsRemoved) <= 18 {
                shrinkView.animation(.default, value: viewModel.cards)
            } else {
                scrollView.animation(.default, value: viewModel.cards)
            }
            Button("Deal 3 more cards") {
                viewModel.dealThreeCards()
            }.disabled(viewModel.disableDealButton)
            Button("New Game") {
                viewModel.newGame()
            }
//            Diamond()
//                .stroke(lineWidth: 1)
        }
    }
    
    private var shrinkView: some View {
        AspectVGrid(viewModel.cards, itemCount: viewModel.cards.count - viewModel.cardsRemoved, aspectRatio: 5/9) { card in
            makeCard(card)
        }.padding(10)
    }
    
    private var scrollView: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 65), spacing: 0)], spacing: 0) {
                ForEach(viewModel.cards) { card in
                    makeCard(card).aspectRatio(5/9, contentMode: .fit)
                }
            }
        }.padding(10)
    }
    
    
    private func makeCard(_ card: SetModel.Card) -> some View {
        if let successNotifier = viewModel.successNotifier {
            CardView(card, viewModel)
                .padding(4)
                .onTapGesture {
                    viewModel.choose(card)
                }
                .foregroundStyle(card.isSelected ? successNotifier ? Color.green : Color.red : Color.gray)
        } else {
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


#Preview {
    SetView(viewModel: SetViewModel())
}
