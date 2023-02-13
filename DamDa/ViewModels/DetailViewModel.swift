//
//  DetailViewModel.swift
//  DamDa
//
//  Created by SeonHo Cha on 2022/12/01.
//

import Foundation
import UIKit
import RealmSwift

class DetailListViewModel {
    
    let detailListVM: [DiaryModel]
    
    init() {
        self.detailListVM = [DiaryModel]()
    }
}

extension DetailListViewModel {
    var numberOfsection: Int {
        return 1
    }
    func numberOfRowsInSection(_ section: Int) -> Int {
        return self.detailListVM.count
    }
    
    func detailListIndex(_ index: Int) -> DetailViewModel {
        let diaryList = self.detailListVM[index]
        return DetailViewModel(diaryList)
    }
}



struct DetailViewModel {
    let diaryModel: DiaryModel
    
}

extension DetailViewModel {
    init(_ diary: DiaryModel) {
        self.diaryModel = diary
    }
    
}
extension DetailViewModel {
    var todayDate: String? {
        return self.diaryModel.todayDate
    }
    var todayTitle: String? {
        return self.diaryModel.todayTitle
    }
    
    var diaryTextView: String? {
        return self.diaryModel.diaryTextView
    }
    
    var imageobject: List<Data> {
        return self.diaryModel.imageObject
    }
}


struct DetailImageViewModel {
    var isTest = false
        
    var userSelectedImages: [UIImage] {
        willSet {
//            userSelectedImages.removeAll()
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
    var numberOfSection: Int {
        return 1
    }
//    func numberOfRowsInsection(_ section: Int) -> Int {
//        return self.diaryModel
//    }
}
