//
//  IntervallViewController.swift
//  myPerfectWeather
//
//  Created by Max Friman on 2019-03-15.
//  Copyright © 2019 Max Friman. All rights reserved.
//

import UIKit
import MultiSlider

class IntervallViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

        @IBOutlet var multiSlider: MultiSlider!
        @IBOutlet var intervallStackView: UIStackView!
        @IBOutlet var descriptionTableView: UITableView!
    
        var parameter : Parameter = Parameter()
        var reversedRowsDescription : [Int:String] = [:] //display tableCells from bottom up
        
        override func viewDidLoad() {
            super.viewDidLoad()

            navigationItem.title = "\(type(of: parameter))"
            navigationController?.navigationBar.prefersLargeTitles = true
            
            parameter.configure(multiSlider: multiSlider, with: parameter)
            parameter.configure(intervallStackView: intervallStackView, parameter: parameter)
            reversedRowsDescription = reverse(parameterDescriptions: parameter.rowDescription)
            configure(tableView: descriptionTableView)
            
        }
        
        
//TableView Section and Rows-------------------------------------------------------
        func numberOfSections(in tableView: UITableView) -> Int {
            return 1
        }
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return parameter.tableViewRows
        }
        
        
        //Configure Cell----------------------------------------------------------------
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
            
            cell.backgroundColor = UIColor.clear
            cell.textLabel?.sizeToFit()
            cell.textLabel?.numberOfLines = 0
            cell.textLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
            
            for item in reversedRowsDescription {
                if item.key == indexPath.row {
                    cell.textLabel?.text = "\(item.value)"
                }
            }
            
            return cell
        }
        
        
        //Set CellHeight to fit TableViewSize -------------------------------------------------------
        let MinHeight: CGFloat = 10
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            let tHeight = tableView.bounds.height
            let temp = tHeight/CGFloat(parameter.tableViewRows)
            
            return temp > MinHeight ? temp : MinHeight
        }
        
        //Configure TableView -----------------------------------------------------
        func configure(tableView: UITableView) {
            descriptionTableView.dataSource = self
            descriptionTableView.delegate = self
            descriptionTableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
            descriptionTableView.isScrollEnabled = false
            descriptionTableView.separatorStyle = .none
        }
        
        
        //ReverseFunction -----------------------------------------------------
        func reverse(parameterDescriptions: [[Int:String]]) -> [Int:String] {
            var dictionary : [Int:String] = [:]
            
            for (key, _) in parameterDescriptions.enumerated() {
                
                let last = ((parameterDescriptions.count-1) - key)
                
                let firstValue = Array(parameterDescriptions[last].values)[0]
                let lastKey = Array(parameterDescriptions[last].keys)[0]
                
                dictionary[parameter.tableViewRows - lastKey] = firstValue
            }
            return dictionary
        }
        
        
        
        
        
}
