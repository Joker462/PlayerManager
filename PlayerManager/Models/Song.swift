//
//  Song.swift
//  PlayerManager
//
//  Created by MMI001 on 11/16/18.
//  Copyright © 2018 joker. All rights reserved.
//

import Foundation
import MediaPlayer

struct Song {
    // Properties
    let id: NSNumber
    let name: String
    let albumName: String
    let artistName: String
    private var artWork: MPMediaItemArtwork?
    
    // Constructions
    init(_ mediaItem: MPMediaItem) {
        id = mediaItem.persistentID as NSNumber
        name = mediaItem.title ?? "Unknown"
        albumName = mediaItem.albumTitle ?? ""
        artistName = mediaItem.artist ?? ""
        artWork = mediaItem.artwork
    }
    
    // Methods
    func getImage(with size: CGSize) -> UIImage? {
        return artWork?.image(at: size)
    }
}
