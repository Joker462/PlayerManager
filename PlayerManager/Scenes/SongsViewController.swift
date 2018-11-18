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
    
    // Properties
    fileprivate let screenFrame = UIScreen.main.bounds
    fileprivate lazy var statusMediaInProgress: [IndexPath: Operation] = [:]
    fileprivate lazy var statusMediaQueue: OperationQueue = {
       let queue = OperationQueue()
        queue.maxConcurrentOperationCount = 1
        queue.name = "Status media queue"
        return queue
    }()
    
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

extension SongsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: screenFrame.width/2 - 10, height: (screenFrame.width/2 - 10)*1.5)
    }
}
