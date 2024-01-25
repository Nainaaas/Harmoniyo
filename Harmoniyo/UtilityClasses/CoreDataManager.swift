//
//  CoreDataManager.swift
//  Harmoniyo
//
//  Created by Shahina Kassim on 09/01/24.
//

import Foundation
import CoreData
class CoreDataManager{
    
    init(){
        
    }
    static var shared = CoreDataManager()
    
    func save(songData: SongModel){
       
        do{
           
                let fetchRequest : NSFetchRequest<Songs>  = Songs.fetchRequest()
                fetchRequest.predicate = NSPredicate(format: "title == %@ && artistName == %@",songData.title, songData.artistName)
                let numberofRecords =  try PersistentStorage.sharedStorage.context.count(for: fetchRequest)
                if numberofRecords == 0{
                    let song = Songs(context: PersistentStorage.sharedStorage.context)
                    
                    song.artistName = songData.artistName
                    song.title = songData.title
                    song.album = songData.album
                    song.imagePath = songData.imageUrl
                    song.favorite = songData.favorite
                    
                    try PersistentStorage.sharedStorage.context.save()
                    print("Core data save done")
                }else{
                    print("Already exist in the database")
                }
         
        }catch{
            print("song details save is not done")
        }
    }
    func fetchSongs() -> [SongModel]{
        var songs = fetch()
        var songModels = [SongModel]()
            if !songs.isEmpty{
                for song in songs{
                    songModels.append(SongModel(song: song))
                }
            }
        return songModels
      
    }
    func fetch() -> [Songs]{
        
        
        var songs = [Songs]()
        let fetchRequest : NSFetchRequest<Songs>  = Songs.fetchRequest()
        do{
            songs =  try PersistentStorage.sharedStorage.context.fetch(fetchRequest)
        }
        catch{
            print("Fetch request failed: \(error)")
        }
        return songs
        
        
       
    }
    func fetchFavSongs() -> [Songs]{
        
        var songs = [Songs]()
        let fetchRewuest : NSFetchRequest<Songs> = Songs.fetchRequest()
        fetchRewuest.predicate = NSPredicate(format: "favorite == true")
        do{
           songs =  try PersistentStorage.sharedStorage.context.fetch(fetchRewuest)
        }
        catch{
            print("Fetching Favorite songs failed")
        }
        return songs
    }
    func update(indexpath: Int, favorite: Bool, fromHome: Bool ,completion: (SongModel?) -> Void ){
        var songs = fromHome ? fetch() : fetchFavSongs()
        songs[indexpath].favorite = favorite
        do{
            try PersistentStorage.sharedStorage.context.save()
            completion(SongModel(song: songs[indexpath]))
        }
        catch{
            print("Updation faileds: \(error)")
            completion(nil)
        }
    }
    
}
