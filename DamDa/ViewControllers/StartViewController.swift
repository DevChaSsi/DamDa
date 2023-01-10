//
//  StartViewController.swift
//  DamDa
//
//  Created by SeonHo Cha on 2022/05/30.
//

import UIKit
import Lottie
import RealmSwift


class StartViewController: UIViewController {
    
    let realm = try! Realm()
    
    var loadItem: Results<DiaryModel>? // 안젤라 263 - 4분무렵
    
    let animationView: LottieAnimationView = {
        let animationView: LottieAnimationView = .init(name: "splash")
        animationView.contentMode = .scaleToFill
        animationView.animationSpeed = 10
           return animationView
       }()
    
    
    override func viewWillAppear(_ animated: Bool) {
      navigationController?.setNavigationBarHidden(true, animated: true) // 뷰 컨트롤러가 나타날 때 숨기기
        
    }
    

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
            super.viewDidLoad()
        
    
            let nibName = UINib(nibName: "DiaryListTableViewCell", bundle: nil)
        tableView.register(nibName, forCellReuseIdentifier: "DiaryListTableViewCell")

        setup()
        
        loadDiary()
        tableView.reloadData()
        
        }
    
    override func viewWillDisappear(_ animated: Bool) {
      navigationController?.setNavigationBarHidden(false, animated: true) // 뷰 컨트롤러가 사라질 때 나타내기
    }
    
        // MARK: - setup
        func setup() {
            addViews()
            setConstraints()
            animationView.play { (finish) in
                self.animationView.removeFromSuperview()
            }
        }
        
        // MARK: - addViews
        func addViews() {
            view.addSubview(animationView)
        }
        
        // MARK: - setConstraints
        func setConstraints() {
            animationViewConstraints()
        }
        
        func animationViewConstraints() {
            animationView.translatesAutoresizingMaskIntoConstraints =  false
            animationView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
            animationView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
            animationView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
            animationView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
//            animationView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//            animationView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
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
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "DiaryListTableViewCell", for: indexPath) as! DiaryListTableViewCell
        cell.previewImage.image = UIImage.add
        cell.todayTitle?.text = loadItem?[indexPath.row].todayDate ?? "No Date"
        cell.diaryTitle?.text = loadItem?[indexPath.row].todayTitle ?? "No Title"
        
        return cell
    }
    
    //MARK: - TableView To Detail
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let diaryWrittenViewController = self.storyboard?.instantiateViewController(identifier: "WrittenViewController") as? WrittenViewController else { return }
        let diary = self.loadItem?[indexPath.row]
        diaryWrittenViewController.diary = diary
        self.navigationController?.pushViewController(diaryWrittenViewController, animated: true)
    }
    
    
}



