//
//  UswerWeatherTableViewCell.swift
//  myPerfectWeather
//
//  Created by Max Friman on 2019-03-01.
//  Copyright © 2019 Max Friman. All rights reserved.
//

import UIKit

class MainTableViewCell: UITableViewCell {

    
    //man vill kunna vika ner. Sortera per dag, sen fälla ner lista i listan :D
    
    @IBOutlet var titleLabel: UILabel!
    
    func configureCell(dates : [Date]) {
        let formatter = DateFormatter()
        var printText : String = ""
        for element in dates {
            let displayDate = formatter.displayDate(date: element)
                printText += "\(displayDate)\n"

        }
        self.titleLabel.text = "Your weather will arrive at\n\(printText)"
    }
    
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }

    }



