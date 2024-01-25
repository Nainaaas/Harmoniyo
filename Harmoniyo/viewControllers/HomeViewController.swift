//
//  ViewController.swift
//  Harmoniyo
//
//  Created by Shahina Kassim on 05/01/24.
//

import UIKit
import MediaPlayer

class HomeViewController: UIViewController ,UIGestureRecognizerDelegate{
    var songs = [SongModel]()
  
    @IBOutlet weak var tableview: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        self.listAllAudio()
        let nib = UINib(nibName: "SongTableViewCell", bundle: nil)
        tableview.register(nib, forCellReuseIdentifier: "SongTableViewCell")
//        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
//                tapGesture.delegate = self
//                view.addGestureRecognizer(tapGesture)
      
    }
    @objc func handleTap() {
           view.endEditing(true)
       }

       // UIGestureRecognizerDelegate method to allow tap gesture alongside other gestures
       func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
           return true
       }
    func fetchDataAndReload(){
        songs = CoreDataManager.shared.fetchSongs()
        DispatchQueue.main.async {
            self.tableview.reloadData()
        }
    }
    override func viewWillAppear(_ animated: Bool) {
       fetchDataAndReload()
        
    }
    override func viewDidAppear(_ animated: Bool) {
       fetchDataAndReload()
    }
    func setupView(){
        let hamburgerMenu = UIBarButtonItem(
            image: UIImage(named: "hamburger"),
            style: .plain,
            target: self,
            action: #selector(hamburgerClicked))
        
       navigationItem.leftBarButtonItem = hamburgerMenu
        
    }
    @objc func hamburgerClicked(){
        
    }

    func listAllAudio() {
        switch MPMediaLibrary.authorizationStatus() {
        case .authorized:
            // Access granted, proceed with the query
            queryMediaItems()
        case .denied, .restricted:
            print("Access to the media library is denied or restricted.")
        case .notDetermined:
            // Request authorization
            MPMediaLibrary.requestAuthorization { (status) in
                if status == .authorized {
                    // Access granted, proceed with the query
                    self.queryMediaItems()
                } else {
                    print("Permission denied to access the media library.")
                }
            }
        @unknown default:
            break
        }
    }
    
    func queryMediaItems() {
        let mediaQuery = MPMediaQuery()
        let mediaItems = mediaQuery.items
        
        if mediaItems?.isEmpty ?? true {
                    print("No media items found.")
                } else {
            for item in mediaItems! {
                // Access information about the audio file
                let title = item.title ?? "Unknown Title"
                let artist = item.artist ?? "Unknown Artist"
                let album = item.albumTitle ?? "Unknown Album"
                let artwork = item.assetURL
                
                let imageName = UUID().uuidString
                if let image = item.artwork?.image(at: CGSize(width: 50, height: 50)){
                    saveImageToDocumentDirectory(albumImage: image, imageName: imageName)
                }
                CoreDataManager.shared.save(songData: SongModel(title: title, artistName: artist, album: album, imageUrl: imageName , favorite: false))
                print("Title: \(title), Artist: \(artist), Album: \(album)")
            }
        }
    }
   

    func saveImageToDocumentDirectory(albumImage: UIImage, imageName: String){
        let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let url = documentDirectory.appendingPathComponent(imageName).appendingPathExtension(".png")
        if let imageData = albumImage.pngData(){
            if !FileManager.default.fileExists(atPath: url.path){
                do{
                    try FileManager.default.createDirectory(at: url.deletingLastPathComponent(), withIntermediateDirectories: true)
                   try imageData.write(to: url)
                }
                catch{
                    print("image save to document directory is failed")
                }
            }
            else{
                print("File is already exist")
            }
            
        }
        
    }
    
}
extension HomeViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.songs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell  = tableView.dequeueReusableCell(withIdentifier: "SongTableViewCell", for: indexPath) as! SongTableViewCell
        
        cell.initiateWithSong(song: self.songs[indexPath.row], tag: indexPath.row)
        cell.delegate = self
        return cell
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let playerViewController = storyboard?.instantiateViewController(identifier: "PlayerViewController") as? PlayerViewController else{
            return
        }
        self.navigationController?.pushViewController(playerViewController, animated: false)
        
      //  MusicUtilityController.playSong(song: self.songs[indexPath.row])
    }
    
}

extension HomeViewController: SongTableviewCellDelegate{
    func favSelected(row: Int) {
       // var song : SongModel = songs[row]
        CoreDataManager.shared.update(indexpath: row, favorite:!songs[row].favorite, fromHome: true) { changedModel in
            if let songModel = changedModel{
                if songModel.favorite{
                    Utility.showAlertToggle(message: "Added to favorites", duration: 0.5, viewcontroller: self)
                }
                else{
                    Utility.showAlertToggle(message: "Removed from favorites", duration: 0.5, viewcontroller: self)
                }
                print("updation success")
                self.songs[row] = songModel
                DispatchQueue.main.async {
                    self.tableview.reloadData()
                }
                
            }else{
                print("updation failed")
            }
        }
    }
    
}
