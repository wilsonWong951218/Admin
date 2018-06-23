//
//  orderListTableViewCell.swift
//  Admin
//
//  Created by Macintosh on 2018/6/23.
//  Copyright © 2018年 Mac mini. All rights reserved.
//

import UIKit

class OrderListTableViewCell: UITableViewCell {

    @IBOutlet var lbFood: UILabel!
    
    @IBOutlet var lbPrice: UILabel!
    
    @IBOutlet var backView: UIView!
    @IBOutlet var lbOrdered: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        backView.layer.borderWidth = 2
        backView.layer.cornerRadius = 10
        backView.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
