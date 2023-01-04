//
//  loadService.swift
//  DamDa
//
//  Created by SeonHo Cha on 2022/12/12.
//

import Foundation
import UIKit
import RealmSwift

class LoadService {
    
    let realm = try! Realm()
    
//    var loadItem: Results<DiaryModel>? // 안젤라 263 - 4분무렵
   

    //MARK: - Data Save
    func saveDiary(diary: DiaryModel) {
        do {
            try realm.write {
                realm.add(diary)
            }
        } catch {
            print("Error saving DiaryModel \(error)")
        }
        
    }

}
