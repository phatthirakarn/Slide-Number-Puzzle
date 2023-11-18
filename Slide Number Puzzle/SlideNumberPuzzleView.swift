//
//  ContentView.swift
//  Memorize
//
//  Created by Class Demo on 5/10/2566 BE.
//

import SwiftUI

struct SlideNumberPuzzleView: View {
    @ObservedObject var viewModel: SlideNumberPuzzleViewModel
    
    let moved = "Moves: "
    
    var body: some View {
        VStack {
            Button("New Game") {
                viewModel.newGame()
            }.font(.largeTitle).bold()
            Spacer()
            Spacer()
            ScrollView {
                cards
                    .animation(.default, value: viewModel.cards)
            }
            Spacer()
            Text("\(viewModel.victoryMsg)").font(.largeTitle)
                .foregroundColor(.red).bold()
            Text("\(moved)\(viewModel.moves)").font(.largeTitle).foregroundColor(.indigo).bold()
        }
        .padding()
    }
    
    var cards: some View {
        LazyVGrid(columns: Array(repeating: GridItem(.adaptive(minimum: 55)), count: 4)) {
            ForEach(viewModel.cards) { card in
                CardView(card: card)
                    .aspectRatio(1.0, contentMode: .fit)
                    .onTapGesture {
                        viewModel.choose(card)
                        viewModel.isWin()
                    }
                    .foregroundColor(.mint)
            }
        }
    }
}

struct CardView: View {
    var card: SlideNumberPuzzleModel<String>.Card
    
    var body: some View {
        ZStack(alignment: .center) {
            let base = RoundedRectangle(cornerRadius: 10)
            Group {
                base.foregroundColor(.clear)
                base.strokeBorder(lineWidth: 2)
                Text(card.content).font(.largeTitle).bold()
            }
            .opacity(card.isVoid ? 0.01 : 1)
           // .opacity(card.isFaceUp ? 1 : 0)
           // base.opacity(card.isFaceUp ? 0 : 1)
        }
       // .opacity(card.isFaceUp || !card.isMatched ? 1 : 0)
    }
}

#Preview {
    SlideNumberPuzzleView(viewModel: SlideNumberPuzzleViewModel())
}
