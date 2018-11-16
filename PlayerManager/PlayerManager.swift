//
//  PlayerManager.swift
//  PlayerManager
//
//  Created by MMI001 on 11/15/18.
//  Copyright © 2018 joker. All rights reserved.
//

import Foundation
import AVFoundation
import MediaPlayer
import MediaToolbox

final class PlayerManager {
    static let shared = PlayerManager()
    
    // Properties
    var songListLocal: [Song] = []
    
    // Constructions
    private init() {
        checkAuthorization()
    }
}


// MARK: - Private methods -
private extension PlayerManager {
    
    func checkAuthorization() {
        switch MPMediaLibrary.authorizationStatus() {
        case .authorized:
            loadSongListLocal()
            break
        default:
            // request authorization
            MPMediaLibrary.requestAuthorization { (status) in
                if status == .authorized {
                    self.loadSongListLocal()
                }
            }
            break
        }
    }
    
    /// Load song list from device local
    func loadSongListLocal() {
        songListLocal = []
        // Query
        guard let mediaCollection = MPMediaQuery.songs().items else { return }
        for mediaItem in mediaCollection {
            songListLocal.append(Song(mediaItem))
        }
    }
}
