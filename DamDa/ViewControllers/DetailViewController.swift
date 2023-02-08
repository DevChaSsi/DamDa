//
//  ViewController.swift
//  DamDa
//
//  Created by SeonHo Cha on 2022/05/16.
//

import UIKit
import RealmSwift
import BSImagePicker
import Photos

//protocol AddImageDelegate {
//    func didPickImagesToUpload(images: [UIImage])
//    func dataToSave(data1: [Data])
//}



class DetailViewController: UIViewController, UITextViewDelegate {
    
    
    @IBOutlet weak var todayDatePicker: UIDatePicker!
    @IBOutlet weak var todayTitle: UITextField!
    @IBOutlet weak var diaryTextView: UITextView!
    @IBOutlet weak var detailCollectionView: UICollectionView!

    var newToday = DiaryModel()
    
    private var viewModel: DetailViewModel?
    var imageViewModel: DetailImageViewModel = DetailImageViewModel() ///???왜 ㅅㅂ 뷰모델이 두개냐

    
    var diaryIndex: Int?
    var diaryEditorMode: DiaryEditorMode = .new
    
    var todayDatePickerString: String?
    var todayTitleString: String?
    var diaryTextViewString: String?
    var diaryDataToImage: [UIImage]?
    
    var selectedAssets: [PHAsset] = [PHAsset]()
    var userSelectedImage: [UIImage] = [UIImage]()
    var imageToData: [Data] = [Data]()
    
    
    
    let realm = try! Realm()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        detailCollectionView.delegate = self
        detailCollectionView.dataSource = self
        definesPresentationContext = true
        
        self.hideKeyboardWhenTapped()
                
        if let msg1 = todayTitleString {
                    self.todayTitle.text = msg1
                }
//        self.refresh()
        
        //MARK: - textView PlaceHolder
        diaryTextView.delegate = self
        if diaryEditorMode == .new {
            diaryTextView.text = "How was your day?"
            diaryTextView.textColor = UIColor.lightGray
        } else {
            diaryTextView.text = diaryTextViewString
        }
    }

    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.diaryTextView.resignFirstResponder()
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if diaryTextView.text.isEmpty {
            diaryTextView.text =  "How was your day?"
            diaryTextView.textColor = UIColor.lightGray
        }
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if diaryTextView.textColor == UIColor.lightGray {
            diaryTextView.text = nil
            diaryTextView.textColor = UIColor.black
        }
    }
    

   //MARK: - ImagePicker
    @IBAction func addImageToDiary(_ sender: UIButton){
        let imagePicker = ImagePickerController()
        
        //+버튼을 눌렀을 때 기존 사진 모두 초기화
        selectedAssets.removeAll()
        userSelectedImage.removeAll()
        imageToData.removeAll()
        newToday.imageObject.removeAll()
        
        imagePicker.settings.selection.max = 5
        imagePicker.settings.fetch.assets.supportedMediaTypes = [.image]
                
        presentImagePicker(imagePicker, select: { (asset) in
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
            
            self.imageViewModel.userSelectedImages = self.userSelectedImage
            self.newToday.imageObject.append(objectsIn: self.imageToData)
            self.detailCollectionView.reloadData()
//            RefreshValue.SharedInstance().refreshValue = true
            WrittenViewController().WrittenCollectionView?.reloadData()

//            self.delegate?.didPickImagesToUpload(images: self.userSelectedImage)
//            self.delegate?.dataToSave(data1: self.imageToData)
//
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
                
                let data = thumbnail.jpegData(compressionQuality: 0.9)
                let newImage = UIImage(data: data!)
                self.userSelectedImage.append(newImage! as UIImage)
                self.imageToData.append(data! as Data)
                
            }
        }
    }
    
    
    //MARK: - SaveButtonPressed
    
    @IBAction func SaveButtonPressed(_ sender: UIBarButtonItem) {
        switch self.diaryEditorMode {
        case .new:

            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            
            newToday.todayDate = dateFormatter.string(from: todayDatePicker.date)
            self.view.endEditing(true)
            newToday.todayTitle = todayTitle.text ?? ""
            newToday.diaryTextView = diaryTextView.text ?? ""

            LoadService().saveDiary(diary: newToday)
            
        case .edit:
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            
            newToday.todayDate = dateFormatter.string(from: todayDatePicker.date)
            self.view.endEditing(true)
            newToday.todayTitle = todayTitle.text ?? ""
            newToday.diaryTextView = diaryTextView.text ?? ""
            
            
            let diaaary = realm.objects(DiaryModel.self)
            try! realm.write {
                diaaary[diaryIndex!].todayDate = newToday.todayDate
                diaaary[diaryIndex!].todayTitle = newToday.todayTitle
                diaaary[diaryIndex!].diaryTextView = newToday.diaryTextView
                diaaary[diaryIndex!].imageObject = newToday.imageObject

            }
            WrittenViewController().WrittenCollectionView?.reloadData()

        }
        self.navigationController?.popViewController(animated: true)
        
    }

}
    
//MARK: - CollectionView
extension DetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.imageViewModel.userSelectedImages.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "userSelectedImageCell", for: indexPath) as? UserSelectedImageCell else {
            fatalError("Failed to dequeue cell for userSelectedImageCell")
        }
        cell.userSelectedImage.image = imageViewModel.userSelectedImages[indexPath.item]
        return cell
    }
    
    
}


 
    //MARK: - AddImageDelegate
    //
    //extension DetailViewController: AddImageDelegate {
    //
    //    func didPickImagesToUpload(images: [UIImage]) {
    //
    //            imageViewModel.userSelectedImages = images
    //            detailCollectionView.reloadData()
    //
    //
    //    }
    //
    //    func dataToSave(data1: [Data]) {
    //        newToday.imageObject.append(objectsIn: data1)
    //
    //    }
    //}
    //
    
    
//MARK: - keyboard resign

extension DetailViewController {
    func hideKeyboardWhenTapped() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
