//
//  MusicUtilityController.swift
//  Harmoniyo
//
//  Created by Shahina Kassim on 22/01/24.
//

import Foundation
import MediaPlayer
class MusicUtilityController{
  static var musicPlayer = MPMusicPlayerController.applicationMusicPlayer
    
   static func playSong(song: SongModel) {
        
        let mediaQuery = MPMediaQuery()
        mediaQuery.addFilterPredicate(MPMediaPropertyPredicate(value: song.title, forProperty: MPMediaItemPropertyTitle))
        mediaQuery.addFilterPredicate(MPMediaPropertyPredicate(value: song.artistName, forProperty: MPMediaItemPropertyArtist))
        mediaQuery.addFilterPredicate(MPMediaPropertyPredicate(value: song.album, forProperty: MPMediaItemPropertyAlbumTitle))

        
        let mediaItems = mediaQuery.items

        
        guard let firstItem = mediaItems?.first else {
            print("Song not found in the user's library.")
            return
        }

       
        let mediaCollection = MPMediaItemCollection(items: [firstItem])
        musicPlayer.setQueue(with: mediaCollection)

        musicPlayer.play()
    }

}
