//
//  SongsViewController.swift
//  PlayerManager
//
//  Created by MMI001 on 11/15/18.
//  Copyright © 2018 joker. All rights reserved.
//

import UIKit

final class SongsViewController: UIViewController {

    // IBOutlets
    @IBOutlet fileprivate weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
    }
}

// MARK: - UICollectionViewDataSource -
extension SongsViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return PlayerManager.shared.songListLocal.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SongViewCell", for: indexPath)
        (cell as? SongViewCell)?.display(PlayerManager.shared.songListLocal[indexPath.row])
        return cell
    }
}
