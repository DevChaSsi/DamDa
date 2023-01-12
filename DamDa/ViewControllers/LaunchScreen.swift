//
//  LaunchScreen.swift
//  DamDa
//
//  Created by SeonHo Cha on 2023/01/12.
//

import UIKit
import Lottie

class LaunchScreen: UIViewController {
    
    let animationView: LottieAnimationView = {
        let animationView: LottieAnimationView = .init(name: "splash")
        animationView.contentMode = .scaleToFill
        animationView.animationSpeed = 10
           return animationView
       }()
    
    override func viewWillAppear(_ animated: Bool) {
        setup()
        navigationController?.setNavigationBarHidden(true, animated: true) // 뷰 컨트롤러가 나타날 때 숨기기
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        
    }
    

    
    
    
    // MARK: - setup
    func setup() {
        addViews()
        setConstraints()
        animationView.play { (finish) in
            self.animationView.removeFromSuperview()
            self.performSegue(withIdentifier: "GoStartViewController", sender: self)
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

    
}
