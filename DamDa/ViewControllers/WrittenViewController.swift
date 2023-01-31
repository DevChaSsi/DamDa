//
//  WrittenViewController.swift
//  DamDa
//
//  Created by SeonHo Cha on 2023/01/09.
//

import UIKit
import RealmSwift

class WrittenViewController: UIViewController {

    let realm = try! Realm()
    
    var tasks: Results<DiaryModel>!

    
    @IBOutlet weak var todayDate: UILabel!
    @IBOutlet weak var todayTitle: UILabel!
    @IBOutlet weak var diaryText: UITextView!
    
    
    var diary: DiaryModel?
    var viewModel: DetailViewModel?
    
    var diaryIndex: Int?
    
    var userSelectedImages: [UIImage] = [UIImage]()
    var imageToData: [Data] = [Data]()
    
    
    override func viewWillAppear(_ animated: Bool) {
        todayDate.text = diary?.todayDate
        todayTitle.text = diary?.todayTitle
        diaryText.text = diary?.diaryTextView
        
        tasks = realm.objects(DiaryModel.self)
        
        

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        todayDate.text = diary?.todayDate
        todayTitle.text = diary?.todayTitle
        diaryText.text = diary?.diaryTextView
        
        dataToImage()
        popupMenu()
        
        
    }
    //MARK: - Data to Image
    func dataToImage() {

        tasks = realm.objects(DiaryModel.self)
        imageToData = diary?.dataArray ?? []
        
        for i in 0..<imageToData.count {
            let newImage = UIImage(data: imageToData[i])
            self.userSelectedImages.append(newImage! as UIImage)
    
        }
    }
    
    //MARK: - popupMenu(Modify, Delete)
    
    var menuItems: [UIAction] {
        return [
            UIAction(title: "수정하기", image: UIImage(systemName: "eraser"), handler: { (_) in
                guard let goDetailViewController = self.storyboard?.instantiateViewController(withIdentifier: "WriteDiaryViewController") as? DetailViewController else { return }
                
                self.navigationController?.pushViewController(goDetailViewController, animated: true)
                
                goDetailViewController.diaryEditorMode = .edit
                goDetailViewController.todayTitleString = self.diary?.todayTitle
                goDetailViewController.diaryTextViewString = self.diary?.diaryTextView
                goDetailViewController.diaryIndex = self.diaryIndex
                


                
            }),
            UIAction(title: "삭제하기", image: UIImage(systemName: "trash"), attributes: .destructive, handler: { (_) in
                let alert = UIAlertController(title:"일기를 삭제 하시겠습니까?",
                    message: "신중하게 기록된 일기가 나를 성장시킵니다.",
                    preferredStyle: UIAlertController.Style.alert)
                let cancle = UIAlertAction(title: "취소", style: .default, handler: nil)
                let ok = UIAlertAction(title: "확인", style: .destructive, handler: { action in
                    try! self.realm.write {
                        self.realm.delete(self.diary!)
//                        self.realm.delete(self.viewModel.newPhoto)
                        guard let gostartViewController = self.storyboard?.instantiateViewController(withIdentifier: "StartViewController") as? StartViewController else { return }
                        self.navigationController?.pushViewController(gostartViewController, animated: true)
                    }
                })
                alert.addAction(cancle)
                alert.addAction(ok)
                self.present(alert,animated: true,completion: nil)
                

            })
        ]
    }
    
    func popupMenu() {
        if #available(iOS 14.0, *) {
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "",
                                                                     image: UIImage(systemName: "ellipsis"),
                                                                     primaryAction: nil,
                                                                     menu: menu)
        } else {
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "ellipsis"),
                                                                     style: .plain,
                                                                     target: self,
                                                                     action: #selector(moreActionTapped))
        }
    }
    
    //MARK: - iOS 14.0 이상 팝업 메뉴
    var menu: UIMenu {
        return UIMenu(title: "Select Option", image: nil, identifier: nil, options: [], children: menuItems)
    }
    
    //MARK: - iOS 14.0 미만 alert메뉴
    @objc func moreActionTapped(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: nil, message: "Select Option", preferredStyle: .actionSheet)

        let modifyAction = UIAlertAction(title: "수정하기", style: .default, handler: { _ in
            
                guard let goDetailViewController = self.storyboard?.instantiateViewController(withIdentifier: "WriteDiaryViewController") as? DetailViewController else { return }
                
                self.navigationController?.pushViewController(goDetailViewController, animated: true)
                
                goDetailViewController.diaryEditorMode = .edit
                goDetailViewController.todayTitleString = self.diary?.todayTitle
                goDetailViewController.diaryTextViewString = self.diary?.diaryTextView
                goDetailViewController.diaryIndex = self.diaryIndex
            
        })
        let deleteAction = UIAlertAction(title: "삭제하기", style: .destructive, handler: { _ in
            
            guard let gostartViewController = self.storyboard?.instantiateViewController(withIdentifier: "StartViewController") as? StartViewController else { return }
            self.navigationController?.pushViewController(gostartViewController, animated: true)

            
            try! self.realm.write {
                self.realm.delete(self.diary!)
            }
        })

        alert.addAction(deleteAction)
        alert.addAction(modifyAction)
        self.present(alert, animated: true, completion: nil)
    }

    
}

//MARK: - EdiotorModelCollectionView
extension WrittenViewController: UICollectionViewDelegate, UICollectionViewDataSource  {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.diary?.imageObject.count ?? 1
        
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        /// 첫 번째 Cell 은 default image

            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MoreDetailImageCell", for: indexPath) as? MoreDetailImageCell else {
                fatalError("Failed to dequeue cell for EditorModeImageCell")
            }
        
        if diary?.dataArray.count == 0 {
            
            cell.userSelectedImageFromData.image = UIImage(systemName: "photo")
            cell.userSelectedImageFromData.tintColor = .black
            cell.userSelectedImageFromData.contentMode = .scaleAspectFit
        
            return cell
            
        } else {
            cell.indexPath = indexPath.item
//            if (diary?.dataArray.count)! > 0 {
              
                cell.userSelectedImageFromData.image = userSelectedImages[indexPath.item]
                cell.userSelectedImageFromData.contentMode = .scaleToFill
//            }
                return cell
        }
    }
       
            
//        /// 첫 번째 Cell 은 default image
//        if self.diary?.dataArray.count == 0 {
//            print(self.diary?.dataArray.count)
//            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MoreDetailImageCell", for: indexPath) as? MoreDetailImageCell else {
//                fatalError("Failed to dequeue cell for EditorModeImageCell")
//            }
//
//            cell.userSelectedImageFromData.image = UIImage(systemName: "photo")
//            cell.userSelectedImageFromData.tintColor = .black
//            cell.userSelectedImageFromData.contentMode = .scaleAspectFit
//
//
//            return cell
//        }
//
//        /// 그 외의 셀은 사용자가 고른 사진으로 구성된  Cell
//        else {
//
//            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MoreDetailImageCell", for: indexPath) as? MoreDetailImageCell else {
//                fatalError("Failed to dequeue cell for EditorModeImageCell")
//            }
//            cell.indexPath = indexPath.item
//
//            /// 사용자가 앨범에서 고른 사진이 있는 경우
//            if (diary?.dataArray.count)! > 0 {
//
//                cell.userSelectedImageFromData.image = userSelectedImages[indexPath.item]
//                cell.userSelectedImageFromData.contentMode = .scaleToFill
//            }
//                return cell
//        }
//    }
}




