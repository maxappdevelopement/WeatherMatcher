//
//  UserWeatherTableViewController.swift
//  myPerfectWeather
//
//  Created by Max Friman on 2019-03-01.
//  Copyright © 2019 Max Friman. All rights reserved.
//

import UIKit

class MainTableViewController: UITableViewController, WeatherControllerDelegate {
  
    
    func didRecieveMatchedDates(dates: [Date]) {
        print("did recieve dates")
        trueDates = dates
        self.tableView.reloadData()
    }
    
     var parameters : [Parameter] = []
     var weather : WeatherController!
     var trueDates : [Date]?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        weather = WeatherController()
        weather.delegate = self
        weather.getWeatherData(latitude: 16.158, longitude: 58.5812)
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }

   
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "userWeatherCell", for: indexPath) as! MainTableViewCell
        
        if trueDates != nil {
            cell.configureCell(dates: trueDates!)
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableView.automaticDimension
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

  
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addWeatherPosition" {
            let mapView : MapViewController = segue.destination as! MapViewController
        }
        
        
        
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    

    @IBAction func addWeather(_ sender: UIBarButtonItem) {
        //NSObject.perform(performSegue(withIdentifier: "addWeatherPosition", sender: self))
    }
    
    @IBAction func refreshButton(_ sender: UIBarButtonItem) {
        print("button is clicked")
        weather?.compareWeatherParameters()
    }
    
}
