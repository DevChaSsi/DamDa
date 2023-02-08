//
//  Model.swift
//  DamDa
//
//  Created by SeonHo Cha on 2022/11/18.
//

import Foundation
import RealmSwift
import UIKit


class DiaryModel: Object {
    
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var imageObject: List<Data> = List<Data>()
    var dataArray: [Data] {
        get {
            return imageObject.map{$0}
        }
        set {
            imageObject.removeAll()
            imageObject.append(objectsIn: newValue)
        }
    }
//    var image: List<ImageObject> = List<ImageObject>()
    @Persisted var todayDate: String?
    @Persisted var todayTitle: String?
    @Persisted var diaryTextView: String?

}


//class ImageObject: Object {
//    @Persisted var imageObject: List<Data> = List<Data>()
//}


