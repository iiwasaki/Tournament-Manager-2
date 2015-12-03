//
//  AssignStationViewController.swift
//  Tournament Manager 2
//
//  Created by Ishin Iwasaki on 12/2/15.
//  Copyright © 2015 Ishin Iwasaki. All rights reserved.
//

import UIKit

class AssignStationViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {

    //Eextra var/let needed
    
    var AssignSelectedStation: Int?
    
    //Table of Station to pick from
    @IBOutlet weak var AssignStationTable: UITableView!
    
    //Assign Status label
    @IBOutlet weak var AssignStationLabel: UILabel!
    
    //buttons to clear the station and assign the station
    
    @IBAction func ClearStation(sender: UIButton) {
        
        if (stations[AssignSelectedStation!].current_match == nil){
            AssignStationLabel.text = "No match currently assigned to this station"
        }
        
        else if(stations[AssignSelectedStation!].current_match != nil){
            stations[AssignSelectedStation!].current_match = nil
            globalMatch?.current_station = nil //need to set a function in match
            
            //clear out timer
            AssignStationLabel.text = "Selected station has been cleared"
        }
        
        //insert code for timer and background timer to clear them
    }
    
    @IBAction func AssignStation(sender: UIButton) {
        stations[AssignSelectedStation!].current_match = globalMatch
        globalMatch?.inProgress = 1
        globalMatch?.current_station = stations[AssignSelectedStation!]
        stations[AssignSelectedStation!].filled = 1
        
        //insert code for timer
        
    }
    
    //buttons to sort the table by name or status of station
    
    @IBAction func NameSort(sender: UIButton) {
    }
    
    @IBAction func StatusSort(sender: UIButton) {
    }
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.setNavigationBarItem()
        navigationItem.title = "Assign Match to a Station"
        let backButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.Plain, target: self, action: "backButton")
        navigationItem.leftBarButtonItem = backButton
        AssignStationLabel.text = "Select Station to Assign"
    }
    
    func backButton(){
        var matchViewController: UIViewController!
        
        matchViewController = storyboard!.instantiateViewControllerWithIdentifier("MatchViewController") as! MatchViewController
        matchViewController = UINavigationController(rootViewController: matchViewController)
        self.slideMenuController()?.changeMainViewController(matchViewController, close: true)
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    } //one section
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stations.count
    }//enough rows for everything in te stations array
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "Cell")
        
        let stationNameRow = stations[indexPath.row].name
        let stationCMatch = stations[indexPath.row].current_match
        
        
        if (stations[indexPath.row].filled == false){
            cell.textLabel?.text = "\(stationNameRow!) - Station is Open."
            return cell
        }
            
        else{
            cell.textLabel?.text = "\(stationNameRow!) - In Progress - \(stationCMatch?.player1?.name!) vs \(stationCMatch?.player2?.name!) "
            return cell
        }
        
    } //what goes in each cell
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        AssignSelectedStation = indexPath.row
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
