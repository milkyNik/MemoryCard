//
//  Card.swift
//  MemoryCard
//
//  Created by iMac on 16.04.19.
//  Copyright © 2019 hata. All rights reserved.
//

import Foundation
import UIKit

extension Array {
    mutating func shuffle() {
        for _ in 0...self.count {
            sort { (_,_) in arc4random() < arc4random()}
        }
    }
}

class Card {
    var id: String = ""
    var shown: Bool = false
    var artworkURL: UIImage!
    
    init(card: Card) {
        self.id = card.id
        self.shown = card.shown
        self.artworkURL = card.artworkURL
    }
    
    init(image: UIImage) {
        self.id = NSUUID().uuidString
        self.shown = false
        self.artworkURL = image
    }
    
    func equals(_ card: Card) -> Bool {
        return (card.id == id)
    }
    
    func copy() -> Card {
        return Card(card: self)
    }
}





