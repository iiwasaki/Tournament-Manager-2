//
//  MatchViewController.swift
//  Tournament Manager 2
//
//  Created by Ishin Iwasaki on 12/2/15.
//  Copyright © 2015 Ishin Iwasaki. All rights reserved.
//

import UIKit

class MatchViewController: UIViewController {

    //Labels for Player/Score Display
    @IBOutlet weak var P1Label1: UILabel!
    @IBOutlet weak var P2Label1: UILabel!
    
    @IBOutlet weak var P1Score: UILabel!
    @IBOutlet weak var P2Score: UILabel!
    
    
    
    //Labels for Score selection
    @IBOutlet weak var P1Label2: UILabel!
    @IBOutlet weak var P2Label2: UILabel!
    
    //Segmented Score selection for Match
    @IBOutlet weak var PlayerOneScoreSelection: UISegmentedControl!
    @IBOutlet weak var PlayerTwoScoreSelection: UISegmentedControl!
    
    @IBAction func DisplayScorePOneUpdate(sender: UISegmentedControl) {
    }
    @IBAction func DisplayScorePTwoUpdate(sender: UISegmentedControl) {
    }
    
    //Button/Labels to Assign the Station
    
    @IBOutlet weak var AssignOutlet: UIButton!
    @IBOutlet weak var StationName: UILabel!
    @IBOutlet weak var StationTimer: UILabel!
    
    
    
    //Buttons for DQ (Disqualification)
    @IBAction func DQPlayerOne(sender: UIButton) {
    }

    @IBAction func DQPlayer2(sender: UIButton) {
    }
    
    //Submit Results
    @IBAction func SubmitResults(sender: UIButton) {
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        AssignButtonCheck()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        <#code#>
    }
    
    func AssignButtonCheck() {
        if (globalMatch?.current_station == nil){
            AssignOutlet.setTitle("Assign Station", forState: .Normal)
            StationName.text = ""
            StationTimer.text = ""
            
        }
        
        else if (globalMatch?.current_station != nil){
            AssignOutlet.setTitle("Assigned Station", forState: .Normal)
            StationName.text = "\(globalMatch?.current_station?.name)"
            
            //insert code for timer display
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
