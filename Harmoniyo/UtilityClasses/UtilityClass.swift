//
//  UtilityClass.swift
//  Harmoniyo
//
//  Created by Shahina Kassim on 11/01/24.
//

import Foundation
import UIKit

class Utility{
    
    static func GetImageFromDirectory(imageName: String) -> UIImage{
        
        let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let url = documentDirectory.appendingPathComponent(imageName).appendingPathExtension(".png")
        if let image = UIImage(contentsOfFile: url.path){
            return image
        }
        else{
            return UIImage(named: "harmonyo")!
        }
    }
    static func showAlertToggle(message: String, duration: TimeInterval, viewcontroller: UIViewController) {
            let alertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
      
       // alertController.view.tintColor = UIColor.white
           viewcontroller.present(alertController, animated: true, completion: nil)

            // Dismiss the alert after a delay
            DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
                alertController.dismiss(animated: true, completion: nil)
            }
        }
}
