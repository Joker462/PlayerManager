//
//  Song.swift
//  PlayerManager
//
//  Created by MMI001 on 11/16/18.
//  Copyright © 2018 joker. All rights reserved.
//

import Foundation
import MediaPlayer

final class Song {
    
    enum StatusState {
        case unknown, readyToPlay, error
    }
    
    // Properties
    let id: NSNumber
    let name: String
    let albumName: String
    let artistName: String
    var url: URL?
    var status: StatusState = .unknown
    private var artWork: MPMediaItemArtwork?
    
    // Constructions
    init(_ mediaItem: MPMediaItem) {
        id = mediaItem.persistentID as NSNumber
        name = mediaItem.title ?? "Unknown"
        albumName = mediaItem.albumTitle ?? ""
        artistName = mediaItem.artist ?? ""
        artWork = mediaItem.artwork
        url = mediaItem.assetURL
    }
    
    // Methods
    func getImage(with size: CGSize) -> UIImage? {
        return artWork?.image(at: size)
    }
}
