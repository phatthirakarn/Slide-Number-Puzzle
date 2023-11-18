import Foundation

struct SlideNumberPuzzleModel<CardContent> where CardContent: Equatable {
    private(set) var cards: [Card]
    
    init(numbersOfCards: Int, cardContentFactory: (Int) -> CardContent) { 
        victoryMsg = " "
        cards = []
        for indexOfCard in 0..<numbersOfCards {
            if (indexOfCard == 15) {
                cards.append(Card(isVoid: true, content: cardContentFactory(indexOfCard), id: "\(indexOfCard)"))
            } else {
                cards.append(Card(content: cardContentFactory(indexOfCard), id: "\(indexOfCard)"))
            }
        }
        
    }
    // var indexOfTheOneAndOnlyFaceUpCard: Int? var prevNum = -1
    var currentIndex: Int?
    
    var prevNum = -1
    var tempCard: Card?
    var victoryMsg: String
    var moves = 0
    
    mutating func choose(_ card: Card) {
        var possibleWays : [Int]
        for i in 0..<cards.count {
            if (cards[i] == card) {
                currentIndex = i
                break
            }
        }
        possibleWays = calulatePossibleWay(idx: Int(currentIndex!))
        for chosenIdx in possibleWays {
            if (cards[chosenIdx].isVoid) {
                tempCard = cards[chosenIdx]
                cards[chosenIdx] = card
                cards[currentIndex!] = tempCard!
                moves += 1
            }
        }
    }
    
    func calulatePossibleWay(idx: Int) -> [Int]{
        var positions : [Int]
        positions = Array()
        let fourDirections = [-4, -1, 1, 4]
        
        var calculatedIdx : Int
        
        for direction in fourDirections {
            calculatedIdx = idx + direction
            if (calculatedIdx >= 0 && calculatedIdx <= 15) {
                positions.append(calculatedIdx)
            }
        }
        return positions
    }
    
    mutating func isWin() -> Bool {
        for num in cards {
            if (Int(num.id)! < prevNum) {
                prevNum = -1
                return false
            }
            prevNum = Int(num.id)!
        }
        prevNum = -1
        return true
    }
    
    mutating func newGame() {
        var voidCard : Card?
        var voidIdx: Int?
        for i in 0..<cards.count {
            if (cards[i].isVoid) {
                voidIdx = i
                voidCard = cards[i]
                break
            }
        }
        cards.remove(at: Int(voidIdx!))
        cards.shuffle()
        cards.append(voidCard!)
        
        moves = 0
        victoryMsg = " "
    }
    
    struct Card: Equatable, Identifiable {
        var isVoid = false
        let content: CardContent
        var id: String
    }
}
// example
//var model = SlideNumberPuzzleModel<String>(numberOfCards: 4) {(index) in "   "}
