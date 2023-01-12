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
    
//    func updateDiary(diary: DiaryModel) { // tableview에서 선택한 index만 구해오면 돼 didselectRowat에서 index값 넘겨봐..
//        let diaaary = realm.objects(DiaryModel.self)
//            try! realm.write {
//                print(DetailViewController().diaryIndex)
//                diaaary[DetailViewController().diaryIndex ?? 1].todayTitle = diary.todayTitle
//
//            }
//        }

}
