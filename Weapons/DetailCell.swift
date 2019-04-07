//
//  DetailCell.swift
//  Weapons
//
//  Created by wox on 2018/8/30.
//  Copyright © 2018年 wox. All rights reserved.
//

import UIKit

class DetailCell: UITableViewCell {

    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var fieldLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
