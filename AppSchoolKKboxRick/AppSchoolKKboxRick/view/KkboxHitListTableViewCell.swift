//
//  KkboxHitListTableViewCell.swift
//  AppSchoolKKboxRick
//
//  Created by RickSun on 2020/1/17.
//  Copyright © 2020 RickSun. All rights reserved.
//

import UIKit

class KkboxHitListTableViewCell: UITableViewCell {

    @IBOutlet weak var kkboxHitImageView: UIImageView!
    @IBOutlet weak var kkboxHitLabel: UILabel!
    @IBOutlet weak var likeBtn: UIButton!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
