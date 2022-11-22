//
//  ViewController.swift
//  Lottietutorial
//
//  Created by SeonHo Cha on 2022/11/18.
//

import UIKit
import Lottie

class ViewController: UIViewController {
    
    

    // 1. Create the AnimationView
    private var animationView: AnimationView?

    override func viewDidLoad() {

      super.viewDidLoad()
      
      // 2. Start AnimationView with animation name (without extension)
      
      animationView = .init(name: "splash")
      
      animationView!.frame = view.bounds
      
      // 3. Set animation content mode
      
      animationView!.contentMode = .scaleAspectFit
      
      // 4. Set animation loop mode
      
      animationView!.loopMode = .loop
      
      // 5. Adjust animation speed
      
      animationView!.animationSpeed = 0.5
      
      view.addSubview(animationView!)
      
      // 6. Play animation
      
      animationView!.play()
      
    }

}

