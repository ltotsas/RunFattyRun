//
//  ResturantTableViewCell.swift
//  RunFattyRun
//
//  Created by Lennart Olsen on 03/10/2017.
//  Copyright © 2017 Burger Inc. All rights reserved.
//

import UIKit

class ResturantTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
