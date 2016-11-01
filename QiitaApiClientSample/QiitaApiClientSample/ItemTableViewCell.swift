//
//  ItemTableViewCell.swift
//  QiitaApiClientSample
//
//  Created by 鈴木大貴 on 2016/08/21.
//  Copyright © 2016年 szk-atmosphere. All rights reserved.
//

import UIKit

class ItemTableViewCell: UITableViewCell {
    static let reuseIdentifier = "ItemTableViewCell"
    
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
