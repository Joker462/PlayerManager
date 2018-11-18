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

final class PlayerManager: NSObject {
    static let shared = PlayerManager()
    fileprivate var player: AVPlayer?

    // Properties
    var songListLocal: [Song] = []
    
    var playError: ((_ error: String?)->())?
    fileprivate var playerItemContext = 0

    // Constructions
    private override init() {
        super.init()
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


// MARK: - Play -
extension PlayerManager {
    func playMedia(at index: Int) {
        let song = songListLocal[index]
        guard let url = song.url else { return }
        let asset = AVAsset(url: url)
        let playerItem = AVPlayerItem(asset: asset, automaticallyLoadedAssetKeys: ["playable",
                                                                                   "hasProtectedContent"])
        player = AVPlayer(playerItem: playerItem)
        switch song.status {
            case .readyToPlay:
                player?.play()
                break
            case .error:
                playError?("Media file failed")
                break
            case .unknown:
                playerItem.addObserver(self, forKeyPath: #keyPath(AVPlayerItem.status), options: [.new, .old], context: &playerItemContext)
                break
        }
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        guard let keyPath = keyPath,
            keyPath == #keyPath(AVPlayerItem.status) else { return }
        let status: AVPlayerItemStatus
        
        // Get the status change from the change dictionary
        if let statusNumber = change?[.newKey] as? NSNumber {
            status = AVPlayerItemStatus(rawValue: statusNumber.intValue)!
        } else {
            status = .unknown
        }
        
        switch status {
        case .failed:
            break
        case .readyToPlay:
            break
        case .unknown:
            break
        }
    }
}
