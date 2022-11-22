//
//  StartViewController.swift
//  DamDa
//
//  Created by SeonHo Cha on 2022/05/30.
//

import UIKit

class StartViewController: UIViewController {

    override func viewDidLoad() {
        
        
        super.viewDidLoad()

        
    }
    @IBAction func goToWrite(_ sender: UIButton) {
        performSegue(withIdentifier: "goToWrite", sender: nil)
    
   
    }
    

}
