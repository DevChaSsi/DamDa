//
//  Intro.swift
//  DamDa
//
//  Created by SeonHo Cha on 2022/11/18.
//

import Foundation
import Lottie


class IntroViewController: UIViewController {
    
    @IBOutlet weak var animationView: LottieAnimationView!


    override func viewDidLoad() {

      super.viewDidLoad()
        LottieConfiguration.shared.renderingEngine = .automatic
      // 2. Start AnimationView with animation name (without extension)
      
      animationView = .init(name: "splash")
      
      // 3. Set animation content mode
      
      animationView!.frame = view.bounds
      
      // 4. Set animation loop mode
      
      animationView!.loopMode = .loop
      
      // 5. Adjust animation speed
      
      animationView!.animationSpeed = 0.5
      
      view.addSubview(animationView!)
      
      // 6. Play animation
      
      animationView!.play()
      
    }
}
