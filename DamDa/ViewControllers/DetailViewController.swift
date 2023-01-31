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


class DetailViewController: UIViewController, UITextViewDelegate {
    
//    let addImageViewCell = AddImageCollectionViewCell.selectedAsset
    
    @IBOutlet weak var todayDatePicker: UIDatePicker!
    @IBOutlet weak var todayTitle: UITextField!
    @IBOutlet weak var diaryTextView: UITextView!
    @IBOutlet weak var detailCollectionView: UICollectionView!
    
    let newToday = DiaryModel()
    
    private var viewModel: DetailViewModel?
    private var imageViewModel: DetailImageViewModel = DetailImageViewModel() ///???왜 ㅅㅂ 뷰모델이 두개냐

    
    var diaryIndex: Int?
    var diaryEditorMode: DiaryEditorMode = .new
    
    var todayDatePickerString: String?
    var todayTitleString: String?
    var diaryTextViewString: String?
    var diaryDataToImage: [UIImage]?
    
    
    let realm = try! Realm()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        definesPresentationContext = true
        detailCollectionView.reloadData()
        
        if let msg1 = todayTitleString {
                    self.todayTitle.text = msg1
                }

        
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
            
        }
        self.navigationController?.popViewController(animated: true)
        
    }

}
    
//MARK: - CollectionView
    extension DetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
        
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            self.imageViewModel.userSelectedImages.count + 1    
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            
            /// 첫 번째 Cell 은 항상 Add Button
            if indexPath.item == 0 {
                
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "addButtonCell", for: indexPath) as? AddImageViewCell else {
                    fatalError("Failed to dequeue cell addButtonCell")
                }
                cell.delegate = self
                return cell
                
            } else {
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "userSelectedImageCell", for: indexPath) as? UserSelectedImageCell else {
                    fatalError("Failed to dequeue cell for userSelectedImageCell")
                }
                //cell.delegate = self
                cell.indexPath = indexPath.item
                if imageViewModel.userSelectedImages.count > 0 {
                    cell.userSelectedImage.image = imageViewModel.userSelectedImages[indexPath.item - 1]

                }
                return cell
            }
        }
        
    }
    
    
    
    
//MARK: - AddImageDelegate
    
extension DetailViewController: AddImageDelegate {
    
    func didPickImagesToUpload(images: [UIImage]) {

        imageViewModel.userSelectedImages = images
        
        detailCollectionView.reloadData()
        
    }
    
    func dataToSave(data1: [Data]) {
        newToday.imageObject.append(objectsIn: data1)
        

    }
}


    
    //MARK: - UserPickedFoodImageCellDelegate
    
//    extension DetailViewController: UserSelectedmageCellDelegate {
//    
//        func didPressDeleteImageButton(at index: Int) {
//    
//            viewModel.userSelectedImages.remove(at: index - 1)
//            detailCollectionView.reloadData()
//        }
//    }
//    extension DetailViewController: UIPickerViewDelegate, UIPickerViewDataSource {
//    
//        func numberOfComponents(in pickerView: UIPickerView) -> Int {
//            return 1
//        }
//    
//        func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
//            return viewModel.foodCategoryArray.count
//        }
//    
//        func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
//            return viewModel.foodCategoryArray[row]
//        }
//    
//        func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//    
//            let selectedFoodCategory = viewModel.foodCategoryArray[row]
//            viewModel.foodCategory = selectedFoodCategory
//    
//            foodCategoryTextField.text = selectedFoodCategory
//        }
//    }

