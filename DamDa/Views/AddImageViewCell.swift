//
//  AddImageViewCell.swift
//  DamDa
//
//  Created by SeonHo Cha on 2022/11/24.
//

import UIKit
import BSImagePicker
import Photos

protocol AddImageDelegate {
    func didPickImagesToUpload(images: [UIImage])
}


class AddImageCollectionViewCell: UICollectionViewCell {
    
    var delegate: AddImageDelegate!

    var selectedAssets: [PHAsset] = [PHAsset]()
    var userSelectedImages: [UIImage] = [UIImage]()

    @IBAction func addImages(_ sender: UIButton){
            
            let imagePicker = ImagePickerController()
            
            //+버튼을 눌렀을 때 기존 사진 모두 초기화
            selectedAssets.removeAll()
            userSelectedImages.removeAll()
            
            imagePicker.settings.selection.max = 5
            imagePicker.settings.fetch.assets.supportedMediaTypes = [.image]
            
            //*********************************
            
            let vc = self.window?.rootViewController
            vc?.presentImagePicker(imagePicker, select: { (asset) in
                // User selected an asset. Do something with it. Perhaps begin processing/upload?
                
            }, deselect: { (asset) in
                // User deselected an asset. Cancel whatever you did when asset was selected.
                
            }, cancel: { (assets) in
                // User canceled selection.
                
            }, finish: { (assets) in
                // User finished selection assets.
                for i in 0..<assets.count {
                    self.selectedAssets.append(assets[i])
                }
                self.convertAssetToImages()
                self.delegate?.didPickImagesToUpload(images: self.userSelectedImages)
                print(assets)
            })
        }
    
   
    func convertAssetToImages() {
        
        if selectedAssets.count != 0 {
            
            for i in 0..<selectedAssets.count {
                
                let imageManager = PHImageManager.default()
                let option = PHImageRequestOptions()
                option.isSynchronous = true
                var thumbnail = UIImage()
                
                imageManager.requestImage(for: selectedAssets[i],
                                          targetSize: CGSize(width: 200, height: 200),
                                          contentMode: .aspectFit,
                                          options: option) { (result, info) in
                    thumbnail = result!
                }
                
                let data = thumbnail.jpegData(compressionQuality: 0.7)
                let newImage = UIImage(data: data!)
                self.userSelectedImages.append(newImage! as UIImage)
            }
        }
    }
}
