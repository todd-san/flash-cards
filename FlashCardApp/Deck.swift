//
//  Deck.swift
//  FlashCardApp
//
//  Created by Todd Miller on 4/13/17.
//  Copyright © 2017 Todd Miller. All rights reserved.
//

import Foundation

class Deck {
    
    var cards = Array<Card>()
    
    init(cards: Array<Card>)        {
        self.cards = cards
    }
}
