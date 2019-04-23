//
//  GameController.swift
//  MemoryCard
//
//  Created by iMac on 16.04.19.
//  Copyright © 2019 hata. All rights reserved.
//

import Foundation
import UIKit

class GameController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    let game = MemoryGame()
    var cards = [Card]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        game.delegate = self
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.isHidden = true
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        if game.isPlaying {
            resetGame()
        }
    }
    
    func resetGame() {
        game.restartGame()
        setupNewGame()
    }
    
    func setupNewGame() {
        cards = game.newGame(cardsArray: self.cards)
        collectionView.reloadData()
    }
    
    @IBAction func onStartGame(_ sender: UIButton) {
        collectionView.isHidden = false
    }
}

extension GameController : UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cards.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardCell", for: indexPath) as! CardCell
        
        cell.showCard(false, animated: false)
        
        guard let card = game.cardAtIndex(indexPath.item) else {return cell}
        cell.card = card

        
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! CardCell
        
        if cell.shown {return}
        game.didSelectCard(cell.card)
        
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}

extension GameController : MemoryGameProtocol {
    
    func memoryGameDidStart(_ game: MemoryGame) {
        collectionView.reloadData()
    }
    
    func memoryGameDidEnd(_ game: MemoryGame) {
        let alertController = UIAlertController(title: defaultAlertTitle,
                                                message: defaultAlertMessage,
                                                preferredStyle: .alert)
       
        let cancelAction = UIAlertAction(title: "Nah",
                                         style: .default) { [weak self] (action) in
                                            self?.collectionView.isHidden = true
        }
        
        let playAgainAction = UIAlertAction(title: "Dale!",
                                            style: .default) { [weak self] (action) in
                                                self?.collectionView.isHidden = true
                                                self?.resetGame()
        }
        
        alertController.addAction(cancelAction)
        alertController.addAction(playAgainAction)
        
        self.present(alertController, animated: true) {}
        
        resetGame()
    }
    
    func memoryGame(_ game: MemoryGame, showCards cards: [Card]) {
        for card in cards {
            guard let index = game.indexForCard(card)
                else { continue
            }
            
            let cell = collectionView.cellForItem(at: IndexPath(item: index, section: 0)) as! CardCell
            
            cell.showCard(true, animated: true)
        }
    }
    
    func memoryGame(_ game: MemoryGame, hideCards cards: [Card]) {
        for card in cards {
            guard let index = game.indexForCard(card)
                else { continue
            }
            
            let cell = collectionView.cellForItem(at: IndexPath(item: index, section: 0)) as! CardCell
            
            cell.showCard(false, animated: true)
        }
    }
}






















