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
    
    private var viewModel: DetailViewModel = DetailViewModel()
    
    var diaryIndex: Int?
    var diaryEditorMode: DiaryEditorMode = .new
    
    var todayDatePickerString: String?
    var todayTitleString: String?
    var diaryTextViewString: String?
    
    let realm = try! Realm()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        definesPresentationContext = true
        
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
            let newToday = DiaryModel()
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            
            newToday.todayDate = dateFormatter.string(from: todayDatePicker.date)
            self.view.endEditing(true)
            newToday.todayTitle = todayTitle.text ?? ""
            newToday.diaryTextView = diaryTextView.text ?? ""
            
            LoadService().saveDiary(diary: newToday)
            
        case .edit:
            let updateToday = DiaryModel()
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            
            updateToday.todayDate = dateFormatter.string(from: todayDatePicker.date)
            self.view.endEditing(true)
            updateToday.todayTitle = todayTitle.text ?? ""
            updateToday.diaryTextView = diaryTextView.text ?? ""
            
            
            let diaaary = realm.objects(DiaryModel.self)
            try! realm.write {
                diaaary[diaryIndex!].todayDate = updateToday.todayDate
                diaaary[diaryIndex!].todayTitle = updateToday.todayTitle
                diaaary[diaryIndex!].diaryTextView = updateToday.diaryTextView
            }
//            LoadService().updateDiary(diary: updateToday)
        }
        self.navigationController?.popViewController(animated: true)
    }

}
    
    extension DetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
        
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            self.viewModel.userSelectedImages.count + 1     /// Add Button 이 항상 있어야하므로 + 1
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            
            /// 첫 번째 Cell 은 항상 Add Button
            if indexPath.item == 0 {
                
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "addButtonCell", for: indexPath) as? AddImageCollectionViewCell else {
                    fatalError("Failed to dequeue cell addButtonCell")
                }
                cell.delegate = self
                return cell
            }
            
            /// 그 외의 셀은 사용자가 고른 사진으로 구성된  Cell
            else {
                
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "userSelectedImageCell", for: indexPath) as? UserSelectedImageCell else {
                    fatalError("Failed to dequeue cell for userSelectedImageCell")
                }
                //            cell.delegate = self
                cell.indexPath = indexPath.item
                
                /// 사용자가 앨범에서 고른 사진이 있는 경우
                if viewModel.userSelectedImages.count > 0 {
                    cell.userSelectedImage.image = viewModel.userSelectedImages[indexPath.item - 1]
                }
                return cell
            }
        }
    }
    
    
    
    //MARK: - AddImageDelegate
    
    extension DetailViewController: AddImageDelegate {
        
        func didPickImagesToUpload(images: [UIImage]) {
            
            viewModel.userSelectedImages = images
            detailCollectionView.reloadData()
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

