//
//  WrittenViewController.swift
//  DamDa
//
//  Created by SeonHo Cha on 2023/01/09.
//

import UIKit

class WrittenViewController: UIViewController {

    
    
    @IBOutlet weak var todayDate: UILabel!
    @IBOutlet weak var todayTitle: UILabel!
    @IBOutlet weak var diaryText: UITextView!
//    @IBOutlet weak var ellipsisButtton: UINavigationItem!
    
    
    var diary: DiaryModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        todayDate.text = diary?.todayDate
        todayTitle.text = diary?.todayTitle
        diaryText.text = diary?.diaryTextView
        popupMenu()
        
        
    }
    
    //MARK: - popupMenu(Modify, Delete)
    
    var menuItems: [UIAction] {
        return [
            UIAction(title: "수정하기", image: UIImage(systemName: "eraser"), handler: { (_) in
            }),
            UIAction(title: "삭제하기", image: UIImage(systemName: "trash"), attributes: .destructive, handler: { (_) in
            })
        ]
    }
    
    var menu: UIMenu {
        return UIMenu(title: "Select Option", image: nil, identifier: nil, options: [], children: menuItems)
    }
    
    
    @objc func moreActionTapped(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: nil, message: "Select Option", preferredStyle: .actionSheet)

        let modifyAction = UIAlertAction(title: "Modify", style: .default, handler: { _ in })
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive, handler: { _ in })


        alert.addAction(deleteAction)
        alert.addAction(modifyAction)

        self.present(alert, animated: true, completion: nil)
    }


    func popupMenu() {
        if #available(iOS 14.0, *) {
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "",
                                                                     image: UIImage(systemName: "ellipsis"),
                                                                     primaryAction: nil,
                                                                     menu: menu)
        } else {
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "ellipsis"),
                                                                     style: .plain,
                                                                     target: self,
                                                                     action: #selector(moreActionTapped))
        }
    }
    
}
