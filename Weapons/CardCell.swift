//
//  CardCell.swift
//  Weapons
//
//  Created by wox on 2018/8/13.
//  Copyright © 2018年 wox. All rights reserved.
//

import UIKit

class CardCell: UITableViewCell {

    @IBOutlet weak var backImgView: UIImageView!
    @IBOutlet weak var favBtn: UIButton!
    @IBOutlet weak var typeLabel: UILabel!
    
    @IBOutlet weak var originLabel: UILabel!
    @IBOutlet weak var weaponLabel: UILabel!
    //属性监视器
    var favorite = false{
        //发生变化之前
        willSet{
            if newValue == true {
                favBtn.setImage(#imageLiteral(resourceName: "fav"), for: .normal)//.normal状态正常
            } else {
                favBtn.setImage(#imageLiteral(resourceName: "unfav"), for: .normal)
            }
            }
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
