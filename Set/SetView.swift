//
//  ContentView.swift
//  Set
//
//  Created by Karen Zhao on 2024-07-27.
//

import SwiftUI
// FIXME: cards not displaying correctly
struct SetView: View {
    typealias Card = SetModel.Card
    @ObservedObject var viewModel: SetViewModel
    
    var body: some View {
        VStack {
            Text("Make a set!").font(.largeTitle)
            
                if (viewModel.cards.count - viewModel.cardsRemoved) <= 18 {
                    withAnimation {
                        shrinkView.animation(.default, value: viewModel.cards)
                    }
                } else {
                    withAnimation {
                        scrollView.animation(.default, value: viewModel.cards)
                    }
                }
            
            HStack {
                deck
                Button("New Game") {
                    newGame()
                }
                matchedDeck
            }

        }
    }
    
    private var shrinkView: some View {
        AspectVGrid(viewModel.cards, itemCount: viewModel.cards.count - viewModel.cardsRemoved, aspectRatio: Constants.aspectRatio) { card in
            if isDealt(card) && !isMatched(card) {
                makeCard(card)
            }
        }.padding(10)
    }
    
    private var scrollView: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 65), spacing: 0)], spacing: 0) {
                ForEach(viewModel.cards) { card in
                    if isDealt(card) && !isMatched(card) {
                        makeCard(card).aspectRatio(Constants.aspectRatio, contentMode: .fit)
                    }
                }
            }
        }.padding(10)
    }
    
    private func makeCard(_ card: Card) -> some View {
        if let successNotifier = viewModel.successNotifier {
            view(for: card)
                .foregroundStyle(card.isSelected ? successNotifier ? Color.green : Color.red : Color.gray)
                .matchedGeometryEffect(id: card.id, in: isMatched(card) ? matchedNamespace : dealingNamespace)
                .transition(.asymmetric(insertion: .identity, removal: .identity))
        } else {
            view(for: card)
                .foregroundStyle(card.isSelected ? Color.black : Color.gray)
                .matchedGeometryEffect(id: card.id, in: isMatched(card) ? matchedNamespace : dealingNamespace)
                .transition(.asymmetric(insertion: .identity, removal: .identity))

        }
    }
    
    private func view(for card: Card) -> some View {
        CardView(card, viewModel)
            .padding(4)
            .onTapGesture {
                withAnimation {
                    viewModel.choose(card)
                }
            }
    }
    
    
    private func newGame() {
        dealt = Set<Card.ID>()
        viewModel.newGame()
    }
    
    
    // MARK: Dealing from the deck
    @Namespace private var dealingNamespace
    @Namespace private var matchedNamespace
    
    @State private var dealt = Set<Card.ID>()
    
    private func isDealt(_ card: Card) -> Bool {
        dealt.contains(card.id)
    }
    private var undealtCards: [Card] {
        viewModel.cards.filter { !isDealt($0) }
    }
    
    private var matchedCards: [Card] {
        viewModel.cards.filter { isMatched($0) }
    }
    
    private func isMatched(_ card: Card) -> Bool {
        viewModel.matchedCards.contains(card.id)
    }

    private var deck: some View {
        ZStack {
            ForEach(undealtCards) { card in
                view(for: card)
                    .matchedGeometryEffect(id: card.id, in: dealingNamespace)
                    .transition(.asymmetric(insertion: .identity, removal: .identity))
            }
            if (viewModel.nextCardIndex < 81) {
                RoundedRectangle(cornerRadius: 12)
                    .foregroundStyle(Color.gray)
            }
        }
        .onTapGesture {
            if dealt.count == 0 {
                deal(startIndex: 0)
            } else {
                viewModel.dealThreeCards()
                deal(startIndex: viewModel.nextCardIndex-3)
            }
        }
        .frame(width: Constants.deckWidth, height: Constants.deckWidth / Constants.aspectRatio)
    }
    
    private var matchedDeck: some View {
        ZStack {
            ForEach(matchedCards) { card in
                view(for: card)
                    .matchedGeometryEffect(id: card.id, in: matchedNamespace)
                    
            }
            if (matchedCards.count > 0) {
                RoundedRectangle(cornerRadius: 12)
                    .foregroundStyle(Color.gray)
            }
        }
        .frame(width: Constants.deckWidth, height: Constants.deckWidth / Constants.aspectRatio)
    }
    
    private func deal(startIndex: Int) {
        var delay: TimeInterval = 0
        for cardIndex in startIndex..<viewModel.cards.count {
            withAnimation(.easeInOut(duration: 1).delay(delay)) {
                _ = dealt.insert(viewModel.cards[cardIndex].id)
            }
            delay += 0.1
        }
    }
    
    private struct Constants {
        static let aspectRatio: CGFloat = 5/9
        static let deckWidth: CGFloat = 50
    }
}

#Preview {
    SetView(viewModel: SetViewModel())
}
