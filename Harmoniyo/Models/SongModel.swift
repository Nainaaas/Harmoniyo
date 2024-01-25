//
//  SongModel.swift
//  Harmoniyo
//
//  Created by Shahina Kassim on 09/01/24.
//

import Foundation
struct SongModel{
    let title: String
    let artistName: String
    let album: String
    let imageUrl: String
    var favorite: Bool
    
    
    init(song: Songs) {
        self.title = song.title ?? StringConstants.unKnownTitle
        self.artistName = song.artistName ?? StringConstants.unknownArtist
        self.album = song.album ?? StringConstants.unKnownTitle
        self.imageUrl = song.imagePath ?? StringConstants.unKnownImagePath
        self.favorite = song.favorite 
    }
    init(title: String, artistName: String, album: String, imageUrl: String , favorite: Bool){
        self.title = title
        self.artistName = artistName
        self.album = album
        self.imageUrl = imageUrl
        self.favorite = favorite
    }
    
}
