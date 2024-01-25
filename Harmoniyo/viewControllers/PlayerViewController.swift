//
//  PlayerViewController.swift
//  Harmoniyo
//
//  Created by Shahina Kassim on 23/01/24.
//

import UIKit

class PlayerViewController: UIViewController {
    @IBOutlet weak var repeatButton: UIButton!
    
    @IBOutlet weak var currentTime: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var MusicImage: UIImageView!
    @IBOutlet weak var previousButton: UIButton!
    @IBOutlet weak var favButton: UIButton!
    @IBOutlet weak var slider: UISlider!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpView()
      
    }
    func setUpView(){
        self.playButton.layer.cornerRadius = 38
        self.MusicImage.layer.cornerRadius = 10
        self.MusicImage.layer.borderWidth = 5
        self.MusicImage.layer.borderColor = UIColor(named:"AccentColor")?.cgColor
    }
    
    @IBAction func repeatButtonClicked(_ sender: Any) {
    }
    @IBAction func favButtonCLicked(_ sender: Any) {
    }
    @IBAction func sliderValueChanged(_ sender: Any) {
    }
    @IBAction func PreviousButtonCLicked(_ sender: Any) {
    }
    @IBAction func nextButtonClicked(_ sender: Any) {
    }
    

     @IBAction func playORPausebuttonAction(_ sender: Any) {
     }
    /* // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
