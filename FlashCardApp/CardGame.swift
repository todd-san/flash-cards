//
//  CardGame.swift
//  FlashCardApp
//
//  Created by Todd Miller on 4/13/17.
//  Copyright © 2017 Todd Miller. All rights reserved.
//

import Foundation

class CardGame {
    
    var cardDeck = Deck(cards: [])
    var unknown = Deck(cards: [])
    var known = Deck(cards: [])
    var seen = Deck(cards: [])
    var unseen = Deck(cards: [])
    var closeProximity = Deck(cards: [])
    var buffedProximity = Deck(cards: [])
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
