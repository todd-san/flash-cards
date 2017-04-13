//
//  ViewController.swift
//  FlashCardApp
//
//  Created by Todd Miller on 4/10/17.
//  Copyright © 2017 Todd Miller. All rights reserved.
//

import UIKit

//import CSVImporter

class ViewController: UIViewController {
    
    // Class @IBOutlets
    @IBOutlet var cardLabel: UILabel!
    @IBOutlet var cardDefinitionLabel: UILabel!
    @IBOutlet var knownCardCount: UILabel!
    @IBOutlet var unknownCardCount: UILabel!
    @IBOutlet var deckSizeLabel: UILabel!
    @IBOutlet var currentCardLabel: UILabel!
    
    // Class Constants & Variables
    var currentCard = 0
    var cards: Array<Card> = []
    var deck = Deck(cards: [])
    
    var Game = CardGame(cardDeck: Deck(cards: []), name: "First Game", buffer: 15)
    
    
    // Class Override Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.Game.cardDeck = self.loadExplicitCardDeck()
        
        
//        self.deckSizeLabel.text = String(self.cards.count)
//        self.cards = self.cards.shuffled()
//        self.cardLabel.text = self.cards[0].front
//        self.cardDefinitionLabel.text = " "
//        self.knownCardCount.text = "0"
//        self.unknownCardCount.text = "0"
//        self.currentCardLabel.text = String(self.currentCard)
        
        func handleSwipeGestureBehavior() {
            let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(self.defineSwipeGestureActions))
            let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(self.defineSwipeGestureActions))
            let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(self.defineSwipeGestureActions))
            let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(self.defineSwipeGestureActions))
            
            swipeRight.direction = UISwipeGestureRecognizerDirection.right
            swipeLeft.direction = UISwipeGestureRecognizerDirection.left
            swipeUp.direction = UISwipeGestureRecognizerDirection.up
            swipeDown.direction = UISwipeGestureRecognizerDirection.down
            
            self.view.addGestureRecognizer(swipeRight)
            self.view.addGestureRecognizer(swipeLeft)
            self.view.addGestureRecognizer(swipeUp)
            self.view.addGestureRecognizer(swipeDown)
        }
        
        func handleTapBehavior(){
            // Single Tap
            let singleTap: UITapGestureRecognizer =
            UITapGestureRecognizer(target: self,
                                   action: #selector(ViewController.defineSingleTapAction))
            singleTap.numberOfTapsRequired = 1
            self.view.addGestureRecognizer(singleTap)
            
            // Double Tap
            let doubleTap: UITapGestureRecognizer =
                UITapGestureRecognizer(target: self,
                                       action: #selector(ViewController.defineDoubleTapAction))
            doubleTap.numberOfTapsRequired = 2
            self.view.addGestureRecognizer(doubleTap)
            
            // Making sure that every Double Tap doesn't also trigger Single Tap
            singleTap.require(toFail: doubleTap)
            singleTap.delaysTouchesBegan = true
            doubleTap.delaysTouchesBegan = true
        }
        
        handleSwipeGestureBehavior()
        
        handleTapBehavior()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   
    func loadExplicitCardDeck() -> Deck{
        
        let deck = Deck(cards: [] )
        
        if let path = Bundle.main.path(forResource: "gre_list_kapplan", ofType: "txt") {
            
            do {
                let data = try String(contentsOfFile: path, encoding: .utf8)
                let myStrings = data.components(separatedBy: .newlines)
                
                for (i, item) in myStrings.enumerated() {
                    if i < myStrings.count - 1 {
                     let splitString = item.components(separatedBy: "=")
                    let cardFront = splitString[0].trimmingCharacters(in: CharacterSet.whitespaces)
                    let cardBack = splitString[1].trimmingCharacters(in: CharacterSet.whitespaces)
                    deck.cards.append(Card(front:cardFront, back: cardBack))
                    }
                }
                
            } catch {
                print(error)
            }
        }
        return deck
    }
    
    // Gesture Functions as Pointers
    func defineSwipeGestureActions(gesture: UIGestureRecognizer) {
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            switch swipeGesture.direction {
            case UISwipeGestureRecognizerDirection.right:
//                print("Swiped right")
                triggerPreviousCard(sender: Any.self)
            case UISwipeGestureRecognizerDirection.down:
//                print("Swiped down")
                appendKnownCardArray(sender: Any.self)
            case UISwipeGestureRecognizerDirection.left:
//                print("Swiped left")
                triggerNextCard(sender: Any.self)
            case UISwipeGestureRecognizerDirection.up:
//                print("Swiped up")
                appendUnknownCardArray(sender: Any.self)
            default:
                break
            }
        }
    }
    
    func defineSingleTapAction(_ sender: Any){
        print("Single Tap")
        
        self.triggerCardFlip()
    }
    
    func defineDoubleTapAction(_ sender: Any){
        print("Double Tap")
        
        self.currentCard = 0
        self.cardLabel.text = self.cards[self.currentCard].front
        
//        triggerCardFlip()
    }
    
    
    // Action Functions
    func triggerNextCard(_ sender: Any) {
        self.currentCard += 1
        if self.currentCard >= self.cards.count{
            self.currentCard = 0
        }
        self.cardLabel.text = self.cards[self.currentCard].front
        self.cardDefinitionLabel.text = " "
        self.currentCardLabel.text = String(self.currentCard)
    }

    func triggerPreviousCard(_ sender: Any) {
        
        if self.currentCard == 0 {
            self.currentCard = self.cards.count - 1
            self.cardLabel.text = self.cards[self.currentCard].front
            self.cardDefinitionLabel.text = " "
            self.currentCardLabel.text = String(self.currentCard)
        }else {
            self.currentCard += -1
            self.cardLabel.text = self.cards[self.currentCard].front
            self.cardDefinitionLabel.text = " "
            self.currentCardLabel.text = String(self.currentCard)
        }
    }
    
    func triggerCardFlip() {

        if self.cardDefinitionLabel.text != " " {
            self.cardLabel.text = self.cards[self.currentCard].front
            self.cardDefinitionLabel.text = " "
        } else if self.cardDefinitionLabel.text == " " {
            self.cardLabel.text = self.cards[self.currentCard].front
            self.cardDefinitionLabel.text = self.cards[self.currentCard].back
        }
    }
    
    func appendKnownCardArray(sender:Any){
        // Add the card to the 'knownCards' array
        self.knownCards.append(Card(front:self.cards[self.currentCard].front,
                                    back: self.cards[self.currentCard].back))
        
        // Check to see if the added card is a duplicate
            // If duplicate --> remove
            // If not --> do nothing
        if self.knownCards.filter( {return $0.front ==
            self.cards[self.currentCard].front && $0.back ==
            self.cards[self.currentCard].back}).count > 1  {
            self.knownCards.remove(at: self.knownCards.count - 1)
        }
        
        // Check to see if the added card is in the 'unknownCards' array
            // If it is, remove it
            // If it is not, do nothing
        if self.unknownCards.filter( {return $0.front ==
            self.cards[self.currentCard].front &&
            $0.back == self.cards[self.currentCard].back}).count >= 1 {
            
            let currentCardIndexInUnknownCardList = self.unknownCards.index(where:
                {$0.front == self.cards[self.currentCard].front})
            self.unknownCards.remove(at: currentCardIndexInUnknownCardList!)
            self.unknownCardCount.text = String(unknownCards.count)
        }
        
        // Update the knownCardCount
        self.knownCardCount.text = String(knownCards.count)
        
        // Animate the counter to make it look pretty!
        // self.knownCardCount.animateToFont(UIFont.systemFont(ofSize: 100), withDuration: 1)
        // self.knownCardCount.animateToFont(UIFont.systemFont(ofSize: 16), withDuration: 1)
        
//        self.degradeCardArray()
        
    }
    
    func appendUnknownCardArray(sender: Any){
        self.unknownCards.append(Card(front:self.cards[self.currentCard].front,
                                      back: self.cards[self.currentCard].back))
        
        // Check to see if the added card is a duplicate
        // If duplicate --> remove
        // If not --> do nothing
        if self.unknownCards.filter( {return $0.front ==
            self.cards[self.currentCard].front &&
            $0.back == self.cards[self.currentCard].back}).count > 1  {
            self.unknownCards.remove(at: self.unknownCards.count - 1)
        }
        
        if self.knownCards.filter( {return $0.front ==
            self.cards[self.currentCard].front && $0.back ==
            self.cards[self.currentCard].back}).count >= 1 {
            
            let currentCardIndexInKnownCardList = self.knownCards.index(where:
                {$0.front == self.cards[self.currentCard].front})
            self.knownCards.remove(at: currentCardIndexInKnownCardList!)
            self.knownCardCount.text = String(knownCards.count)
        }
        self.unknownCardCount.text = String(unknownCards.count)
        
//        self.overpackCardDeck(padding: self.arrayPadding)
    }
    
    
    
    
}


// Extension Shuffle Function
extension MutableCollection where Indices.Iterator.Element == Index {
    /// Shuffles the contents of this collection.
    mutating func shuffle() {
        let c = count
        guard c > 1 else { return }
        
        for (firstUnshuffled , unshuffledCount) in
            zip(indices, stride(from: c, to: 1, by: -1)) {
            let d: IndexDistance =
                numericCast(arc4random_uniform(numericCast(unshuffledCount)))
            guard d != 0 else { continue }
            let i = index(firstUnshuffled, offsetBy: d)
            swap(&self[firstUnshuffled], &self[i])
        }
    }
}

extension Sequence {
    /// Returns an array with the contents of this sequence, shuffled.
    func shuffled() -> [Iterator.Element] {
        var result = Array(self)
        result.shuffle()
        return result
    }
}

extension UILabel {
    func animateToFont(_ font: UIFont, withDuration duration: TimeInterval) {
        let oldFont = self.font
        self.font = font
        // let oldOrigin = frame.origin
        let labelScale = oldFont!.pointSize / font.pointSize
        let oldTransform = transform
        transform = transform.scaledBy(x: labelScale, y: labelScale)
        // let newOrigin = frame.origin
        // frame.origin = oldOrigin
        setNeedsUpdateConstraints()
        UIView.animate(withDuration: duration) {
            //    self.frame.origin = newOrigin
            self.transform = oldTransform
            self.layoutIfNeeded()
        }
    }
}

