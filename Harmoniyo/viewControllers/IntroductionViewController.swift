import UIKit



class IntroductionViewController: UIViewController {

   
    override func viewDidLoad() {
        super.viewDidLoad()
        if !isFirstLaunch() {
        DispatchQueue.main.async {
            if let tabBarController = UIStoryboard(name: "Main", bundle: nil)
                .instantiateViewController(withIdentifier: "MainTabBarController") as? MainTabBarController {
               //tabBarController.view.backgroundColor = UIColor.black
                self.present(tabBarController, animated: false)
            }
        }

        }
        else{
            setFirstLaunchFlag()
        }
    }
    private func isFirstLaunch() -> Bool {
            return !UserDefaults.standard.bool(forKey: "hasLaunchedBefore")
        }

        // Function to set the flag indicating the app has been launched before
        private func setFirstLaunchFlag() {
            UserDefaults.standard.set(true, forKey: "hasLaunchedBefore")
        }
//    @IBAction func finishIntroductionButtonTapped(_ sender: UIButton) {
//        // Called when the "Finish" button is tapped
//        if let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate {
//                    sceneDelegate.didFinishIntroduction()
//                }
//    }
}
