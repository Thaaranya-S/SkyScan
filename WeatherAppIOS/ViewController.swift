//
//  ViewController.swift
//  WeatherAppIOS
//
//  Created by Bilge Çakar on 18.04.2022.
//

import UIKit
import Lottie

class ViewController: UIViewController {
    
    @IBOutlet weak var launchAnimated: AnimationView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        launchAnimate()
    }
    
    func launchAnimate() {
        launchAnimated.play{ (finished) in
            let vc = HomeRouter.getMainView()
            self.present(vc, animated: true)
            //self.performSegue(withIdentifier: "toHomepage", sender: nil)
        }
    }
}

