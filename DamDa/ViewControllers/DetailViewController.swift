//
//  ViewController.swift
//  DamDa
//
//  Created by SeonHo Cha on 2022/05/16.
//

import UIKit
import BSImagePicker



class DetailViewController: UIViewController {
    
    @IBAction func addImages(_ sender: UIButton) {
        let imagePicker = ImagePickerController()
        
        imagePicker.settings.selection.max = 5
        imagePicker.settings.fetch.assets.supportedMediaTypes = [.image]
        
        presentImagePicker(imagePicker, select: { (asset) in
            // User selected an asset. Do something with it. Perhaps begin processing/upload?
            
        }, deselect: { (asset) in
            // User deselected an asset. Cancel whatever you did when asset was selected.
            
        }, cancel: { (assets) in
            // User canceled selection.
            
        }, finish: { (assets) in
            // User finished selection assets.
            
            
        })
    }
                               
    override func viewDidLoad() {
        
        super.viewDidLoad()

    }

    @IBAction func pressAddButton(_ sender: UIButton) {
      
        
}
}

extension DetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath)
        as! DiaryListTableViewCell // superclass as! Subclass
        cell.datePreview.text = "hi"
        return cell
    }
}
