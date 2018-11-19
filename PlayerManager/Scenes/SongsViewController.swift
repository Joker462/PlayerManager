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
        collectionView.delegate = self
        
        // 3D touch
        if traitCollection.forceTouchCapability == .available {
            registerForPreviewing(with: self, sourceView: view)
        }
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

// MARK: - UICollectionViewDelegateFlowLayout -
extension SongsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: screenFrame.width/2 - 10, height: (screenFrame.width/2 - 10)*1.35)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

// MARK: - UICollectionViewDelegate -
extension SongsViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        defer { collectionView.deselectItem(at: indexPath, animated: true) }
    }
}

// MARK: - UIViewControllerPreviewingDelegate -
extension SongsViewController: UIViewControllerPreviewingDelegate {
    // Pop
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, commit viewControllerToCommit: UIViewController) {
        navigationController?.show(viewControllerToCommit, sender: self)
    }
    // Peek
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController? {
        return nil
    }
}
