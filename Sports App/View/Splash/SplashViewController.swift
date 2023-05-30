//
//  SplashViewController.swift
//  Sports App
//
//  Created by Nada on 31/05/2023.
//

import UIKit
import Lottie

class SplashViewController: UIViewController {
    
    let animationView = AnimationView(name:"balls")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        startAnimation()
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3) {
            self.performSegue(withIdentifier: "homePage", sender: nil)
        }
        
    }
    
    func startAnimation(){
        animationView.frame = view.bounds
        animationView.backgroundColor = .white
        animationView.loopMode = .loop
        animationView.play()
        view.addSubview(animationView)
    }
    
    
    
}
