//
//  SongViewCell.swift
//  PlayerManager
//
//  Created by MMI001 on 11/16/18.
//  Copyright © 2018 joker. All rights reserved.
//

import UIKit

final class SongViewCell: UICollectionViewCell {
    
    // IBOutlets
    @IBOutlet weak var pictureImageView: UIImageView!
    @IBOutlet weak var nameLabel:        UILabel!
    
    func display(_ anyItem: Any?) {
        if let song = anyItem as? Song {
            pictureImageView.image = song.getImage(with: CGSize(width: 64, height: 64))
            nameLabel.text = song.name
        }
    }
}
