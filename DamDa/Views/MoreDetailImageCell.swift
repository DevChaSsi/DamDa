//
//  EditorModeImageCell.swift
//  DamDa
//
//  Created by SeonHo Cha on 2023/01/25.
//

import UIKit
import RealmSwift


class MoreDetailImageCell: UICollectionViewCell {
    
    @IBOutlet weak var userSelectedImageFromData: UIImageView!
    
    
    let realm = try! Realm()
    
    var tasks: Results<DiaryModel>!

    var indexPath: Int = 0
    var diary: DiaryModel?

    var userSelectedImages: [UIImage] = [UIImage]()
    var imageToData: [Data] = [Data]()


    
    
//    func dataToImage() {
//
//        tasks = realm.objects(DiaryModel.self)
//        print(diary?.dataArray)
////        for i in 0..<dataToImage!.count {
////
////            uiImage = UIImage(data: dataToImage[i])
////        }
////        print(uiImage)
////        print(uiImage)
//    }
    
}

