//
//  DetailViewModel.swift
//  DamDa
//
//  Created by SeonHo Cha on 2022/12/01.
//

import Foundation
import UIKit

class DetailViewModel {
    
    var model = Diary()
    
    
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
