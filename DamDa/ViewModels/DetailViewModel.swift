//
//  DetailViewModel.swift
//  DamDa
//
//  Created by SeonHo Cha on 2022/12/01.
//

import Foundation
import UIKit

class DetailListViewModel {
    
    var detailListVM: [DetailViewModel]
    
    init() {
        self.detailListVM = [DetailViewModel]()
    }
}

struct DetailViewModel {
        let diaryModel = DiaryModel()
    var userSelectedImages: [UIImage] {
        willSet {
            userSelectedImages.removeAll()
        }
        didSet {
            /// 받은 UIImage 를 JPEGData 로 저장하고,
            /// userSelectedImagesInJPEG 에 저장 후
            /// NewReview 모델에 저장
        }
    }
    public init() {
        userSelectedImages = [UIImage]()
    }
}
extension DetailViewModel {
    var todayDate: String? {
        return self.diaryModel.todayDate
    }
    var todayTitle: String? {
        return self.diaryModel.todayTitle
    }
    var img: String? {
        return self.diaryModel.img
    }
    var diaryTextView: String? {
        return self.diaryModel.diaryTextView
    }
}



extension DetailViewModel {
    var numberOfSection: Int {
        return 1
    }
//    func numberOfRowsInsection(_ section: Int) -> Int {
//        return self.diaryModel
//    }
}
