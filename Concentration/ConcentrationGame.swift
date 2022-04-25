//
//  ConcentrationGame.swift
//  Concentration
//
//  Created by Roman Ivanov on 24.04.2022.
//

import Foundation

struct ConcentrationGame {
    
    private(set) var cards = [Card]()
    private var indexOfOneAndOnlyFaceUpCard: Int? {
        get {
            var foundIndex: Int?
            for index in cards.indices {
                if cards[index].isFaceUp {
                    if foundIndex == nil {
                        foundIndex = index
                    } else {
                        return nil
                    }
                }
            }
            
            return foundIndex
        }
        
        set {
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    
    init(numberOfPairsOfCards: Int) {
        assert(numberOfPairsOfCards > 0, "Game must have at least one pair of cards. Current number: \(numberOfPairsOfCards)")
        
        for _ in 1...numberOfPairsOfCards {
            let card = Card()
            cards += [card, card]
            cards.shuffle()
        }
    }
    
    mutating func chooseCard(at index: Int) {
        if !cards[index].isMatched { 
            if let matchingIndex = indexOfOneAndOnlyFaceUpCard, matchingIndex != index {
                if cards[matchingIndex].identifier == cards[index].identifier {
                    cards[matchingIndex].isMatched = true
                    cards[index].isMatched = true
                }
                
                cards[index].isFaceUp = true
            } else {
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }
    
}
