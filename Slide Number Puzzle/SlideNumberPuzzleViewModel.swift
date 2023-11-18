import SwiftUI

class SlideNumberPuzzleViewModel: ObservableObject {
    init() {
        model.newGame()
    }
    
    static let theNumber = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", " "]
    
    @Published private var model = SlideNumberPuzzleModel<String>(numbersOfCards: 16) { (index) in theNumber[index]}
    
    var cards: [SlideNumberPuzzleModel<String>.Card] {model.cards}
    
    func choose(_ card: SlideNumberPuzzleModel<String>.Card) {
        model.choose(card)
    }
    func newGame() {
        model.newGame()
    }
    func isWin() {
        if (model.isWin()) {
            model.victoryMsg = "You Win!"
        }
    }
    
    var moves: String {String(model.moves)}
    
    var victoryMsg: String {String(model.victoryMsg)}
}
