//
//  FavoriteViewController.swift
//  Harmoniyo
//
//  Created by Shahina Kassim on 08/01/24.
//

import UIKit

class FavoriteViewController: UIViewController {
    @IBOutlet weak var tableview: UITableView!
    var favSongs = [SongModel]()
    override func viewDidLoad() {
        super.viewDidLoad()
       
        navigationItem.title = StringConstants.favorites
        let nib = UINib(nibName: "SongTableViewCell", bundle: nil)
        tableview.register(nib, forCellReuseIdentifier: "SongTableViewCell")
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        let songs = CoreDataManager.shared.fetchFavSongs()
        favSongs.removeAll()
        for song in songs{
            favSongs.append(SongModel(song: song))
        }
        DispatchQueue.main.async {
            self.tableview.reloadData()
        }
    }

}

extension FavoriteViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        favSongs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:  "SongTableViewCell", for: indexPath) as! SongTableViewCell
        cell.initiateWithSong(song: favSongs[indexPath.row], tag: indexPath.row)
        cell.delegate = self
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    
}
extension FavoriteViewController: SongTableviewCellDelegate{
    func favSelected(row: Int) {
        CoreDataManager.shared.update(indexpath: row, favorite:false, fromHome: false) { changedModel in
            if let songModel = changedModel{
                print("updation success")
                self.favSongs.remove(at: row)
                DispatchQueue.main.async {
                    self.tableview.reloadData()
                }
                
            }else{
                print("updation failed")
            }
        }
    }
    
    
}
