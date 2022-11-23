//
//  DiaryListTableViewCell.swift
//  DamDa
//
//  Created by SeonHo Cha on 2022/11/22.
//

import UIKit

class DiaryListTableViewCell: UITableViewCell {

    @IBOutlet weak var previewImage: UIImageView!
    @IBOutlet weak var weatherPreview: UIImageView!
    @IBOutlet weak var datePreview: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
