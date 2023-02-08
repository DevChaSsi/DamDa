//
//  UserSelectedImageCEll.swift
//  DamDa
//
//  Created by SeonHo Cha on 2022/12/01.
//
import UIKit
import RealmSwift


//protocol UserSelectedmageCellDelegate {
//    func didPressDeleteImageButton(at index: Int)
//}

// 사용자가 고른 이미지가 표시되는 Collection View Cell



protocol UserSelectedImageDelegate {
    func editModeCollectionViewImage(image: [UIImage])
}


class UserSelectedImageCell: UICollectionViewCell {
    
    @IBOutlet weak var userSelectedImage: UIImageView!
    


    var diary: DiaryModel?

    var userSelectedImages: [UIImage] = [UIImage]()
    var imageToData: [Data] = [Data]()
    
//    var delegate: UserSelectedmageCellDelegate!
    
    var indexPath: Int = 0
    
//    @IBAction func pressedCancelButton(_ sender: UIButton) {
//        delegate?.didPressDeleteImageButton(at: indexPath)
//    }
}


