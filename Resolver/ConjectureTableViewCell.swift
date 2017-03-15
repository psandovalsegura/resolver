//
//  ConjectureTableViewCell.swift
//  Resolver
//
//  Created by Pedro Sandoval on 3/14/17.
//  Copyright © 2017 Sandoval Software. All rights reserved.
//

import UIKit

class ConjectureTableViewCell: UITableViewCell {
    
    @IBOutlet weak var completeImageView: UIImageView!
    @IBOutlet weak var conjectureLabel: UILabel!
    @IBOutlet weak var conjectureLogicLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
