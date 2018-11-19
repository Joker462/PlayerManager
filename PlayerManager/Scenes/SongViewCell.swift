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
    @IBOutlet weak var artistNameLabel:  UILabel!
    
    // View cycles
    override func awakeFromNib() {
        super.awakeFromNib()
        pictureImageView.layer.cornerRadius = 5
        pictureImageView.clipsToBounds = true
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        pictureImageView.image = nil
        nameLabel.text = ""
        artistNameLabel.text = ""
    }
    
    func display(_ anyItem: Any?) {
        if let song = anyItem as? Song {
            pictureImageView.image = song.getImage(with: CGSize(width: bounds.width, height: bounds.width))
            nameLabel.text = song.name
            artistNameLabel.text = song.artistName
        }
    }
}

// MARK: - Override touches -
extension SongViewCell {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        pictureImageView.alpha = 0.7
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        pictureImageView.alpha = 1
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        pictureImageView.alpha = 1
    }
}
