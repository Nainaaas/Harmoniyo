//
//  SongsTableViewCell.swift
//  Harmoniyo
//
//  Created by Shahina Kassim on 11/01/24.
//

import UIKit


protocol SongTableviewCellDelegate{
    func favSelected(row: Int)
}
class SongTableViewCell: UITableViewCell {
    @IBOutlet weak var imageIcon: UIImageView!
    
    @IBOutlet weak var backGroundView: UIView!
    @IBOutlet weak var moreButton: UIButton!
    @IBOutlet weak var favButton: UIButton!
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    var delegate: SongTableviewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//    }
    func initiateWithSong(song: SongModel, tag: Int){
        self.artistLabel.text = song.artistName 
        self.titleLabel.text = song.title
        self.imageIcon.layer.cornerRadius = 30
        self.imageIcon.image = Utility.GetImageFromDirectory(imageName: song.imageUrl)
        self.favButton.tag = tag
        if let config = favButton.configuration{
            var favButtonconfig : UIBackgroundConfiguration = config.background
            favButtonconfig.image = song.favorite ?  UIImage(named: "favSelected") : UIImage(named: "FavDefault")
            favButton.configuration?.background = favButtonconfig
        }
        
        
        backGroundView.layer.cornerRadius = 20
        backGroundView.layer.borderWidth = 1
        backGroundView.layer.borderColor = UIColor(red: 0.937, green:0.678 , blue:0.820 , alpha: 1).cgColor
        
        
        
    }
    @IBAction func favButtonPressed(_ sender: UIButton) {
        self.delegate?.favSelected(row: sender.tag)
    }
    @IBAction func moreButtonPressed(_ sender: Any) {
    }
}
