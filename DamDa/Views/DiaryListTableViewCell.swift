//
//  DiaryListTableViewCell.swift
//  DamDa
//
//  Created by SeonHo Cha on 2022/11/22.
//

import UIKit

class DiaryListTableViewCell: UITableViewCell {

    @IBOutlet weak var todayTitle: UILabel!
    @IBOutlet weak var diaryTitle: UILabel!
    @IBOutlet weak var previewImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
 
    }
    
 
}
