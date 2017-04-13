//
//  CardGame.swift
//  FlashCardApp
//
//  Created by Todd Miller on 4/13/17.
//  Copyright © 2017 Todd Miller. All rights reserved.
//

import Foundation

class CardGame {
    
    var cardDeck = Deck(cards: Array<Card>())
    var unknown = Deck(cards: Array<Card>())
    var known = Deck(cards: Array<Card>())
    var seen = Deck(cards: Array<Card>())
    var unseen = Deck(cards: Array<Card>())
    var closeProximity = Deck(cards: Array<Card>())
    var buffedProximity = Deck(cards: Array<Card>())
    var name = String()
    var buffer = 15
    
    init(cardDeck: Deck, name: String, buffer: Int) {
        
        self.cardDeck = cardDeck
        self.unseen = cardDeck
        self.seen.cards = []
        self.known.cards = []
        self.unknown.cards = []
        self.closeProximity.cards = []
        self.buffedProximity.cards = []
        self.unknown.cards = []
        self.name = name
        
        }
    
}
