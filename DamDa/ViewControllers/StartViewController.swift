//
//  StartViewController.swift
//  DamDa
//
//  Created by SeonHo Cha on 2022/05/30.
//

import UIKit
import Lottie


class StartViewController: UIViewController {
    let animationView: LottieAnimationView = {
        let animationView: LottieAnimationView = .init(name: "splash")
        animationView.contentMode = .scaleToFill
        animationView.animationSpeed = 10
           return animationView
       }()
    

    override func viewDidLoad() {
            super.viewDidLoad()
        

            setup()
        }
        
        // MARK: - setup
        func setup() {
            addViews()
            setConstraints()
            animationView.play { (finish) in
                self.animationView.removeFromSuperview()
            }
        }
        
        // MARK: - addViews
        func addViews() {
            view.addSubview(animationView)
        }
        
        // MARK: - setConstraints
        func setConstraints() {
            animationViewConstraints()
        }
        
        func animationViewConstraints() {
            animationView.translatesAutoresizingMaskIntoConstraints =  false
            animationView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
            animationView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
            animationView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
            animationView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
//            animationView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//            animationView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        }

    
    @IBAction func goToWrite(_ sender: UIButton) {
            performSegue(withIdentifier: "segue", sender: self)
    
    }
    

}
