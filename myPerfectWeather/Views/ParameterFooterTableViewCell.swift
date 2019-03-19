//
//  ParameterFooterTableViewCell.swift
//  myPerfectWeather
//
//  Created by Max Friman on 2019-03-15.
//  Copyright © 2019 Max Friman. All rights reserved.
//

import UIKit

class ParameterFooterTableViewCell: UITableViewCell {

    @IBOutlet var footerButton: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        footerButton.layer.cornerRadius = 16
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
