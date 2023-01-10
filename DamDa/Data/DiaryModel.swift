//
//  Model.swift
//  DamDa
//
//  Created by SeonHo Cha on 2022/11/18.
//

import Foundation
import RealmSwift


class DiaryModel: Object {
    


    @Persisted var todayDate: String?
    @Persisted var img: String?
    @Persisted var todayTitle: String?
    @Persisted var diaryTextView: String?
    
//    @Persisted var calender: String?
//    @Persisted var dotw: String?
//    @Persisted var month: String?
//    @Persisted var weather: String?
}
//
//func getWeatherIcon() {
//    
//}
//
//func getDotwColor(){
//    
//}
//
//func getImageThumbnail() {
//    
//}
