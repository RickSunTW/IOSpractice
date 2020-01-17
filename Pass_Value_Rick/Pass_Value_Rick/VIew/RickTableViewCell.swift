//
//  RickTableViewCell.swift
//  Pass_Value_Rick
//
//  Created by RickSun on 2020/1/16.
//  Copyright © 2020 RickSun. All rights reserved.
//

import UIKit

class RickTableViewCell: UITableViewCell {
    
    @IBOutlet weak var numberLabel: UILabel!
    
    @IBOutlet weak var deleteBtn: UIButton!

    var deleteHandler: ((Int) -> Void)?
    
    @IBAction func deleteCellBtnAction(_ sender: UIButton) {
        
        deleteHandler?(sender.tag)
        
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}


