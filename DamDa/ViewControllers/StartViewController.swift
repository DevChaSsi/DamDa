//
//  StartViewController.swift
//  DamDa
//
//  Created by SeonHo Cha on 2022/05/30.
//

import UIKit
import RealmSwift


class StartViewController: UIViewController {
    

    let realm = try! Realm()
    
    var loadItem: Results<DiaryModel>!
    
override func viewWillAppear(_ animated: Bool) {
      navigationController?.setNavigationBarHidden(true, animated: true) // 뷰 컨트롤러가 나타날 때 숨기기
        tableView.reloadData()
    }
    

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
            super.viewDidLoad()
        

        let nibName = UINib(nibName: "DiaryListTableViewCell", bundle: nil)
        tableView.register(nibName, forCellReuseIdentifier: "DiaryListTableViewCell")
        
        loadDiary()
        tableView.reloadData()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
      navigationController?.setNavigationBarHidden(false, animated: true) // 뷰 컨트롤러가 사라질 때 나타내기
    }
    
    @IBAction func goToWrite(_ sender: UIButton) {
            performSegue(withIdentifier: "segue", sender: self)

    }
}



//MARK: - Data Load

extension StartViewController: UITableViewDelegate, UITableViewDataSource {
    
    func loadDiary() {
        loadItem = realm.objects(DiaryModel.self)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return loadItem?.count ?? 1
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "DiaryListTableViewCell", for: indexPath) as? DiaryListTableViewCell else {
            return UITableViewCell()
        }
        
        let task = loadItem[indexPath.row]

        if task.dataArray.count == 0 {
            cell.previewImage.image = UIImage(systemName: "photo")
            cell.previewImage.contentMode = .scaleAspectFit
            
        } else {
            let newImage = UIImage(data: task.dataArray[0])
            cell.previewImage.image = newImage
            cell.previewImage.contentMode = .scaleAspectFit

        }
        cell.todayTitle?.text = task.todayDate ?? "No Date"
        cell.diaryTitle?.text = task.todayTitle ?? "No Title"
        
        return cell
    }
    
    //MARK: - TableView To Detail
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let diaryWrittenViewController = self.storyboard?.instantiateViewController(identifier: "WrittenViewController") as? WrittenViewController else { return }
        let diary = self.loadItem?[indexPath.row]
        diaryWrittenViewController.diary = diary
        let diaryIndex = indexPath.row
        diaryWrittenViewController.diaryIndex = diaryIndex

        self.navigationController?.pushViewController(diaryWrittenViewController, animated: true)
     
    }
    
    
}



