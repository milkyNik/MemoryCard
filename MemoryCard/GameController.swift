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
        return UICollectionViewCell()
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        
    }
    
}