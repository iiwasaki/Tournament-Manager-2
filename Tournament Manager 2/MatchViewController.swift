//
//  MatchViewController.swift
//  Tournament Manager 2
//
//  Created by Ishin Iwasaki on 12/2/15.
//  Copyright © 2015 Ishin Iwasaki. All rights reserved.
//

import UIKit
import CoreData

class MatchViewController: UIViewController {
    
    //label for any messages about not being able to complete an action or not
    @IBOutlet weak var MessageLabel: UILabel!
    
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
    
    //Let it be noted that player score is part of the match data and which will ten help determine the winner and loser of a match
    @IBAction func DisplayScorePOneUpdate(sender: UISegmentedControl) {
        if(globalMatch?.inProgress == 2){
            //output label saying scores cannot be edited once they have been submitted
            MessageLabel.text = "Unable to change scores because match has been submitted"
        }
        
        else {
            if(globalMatch?.playerDQ == 0){
                if (PlayerOneScoreSelection.selectedSegmentIndex == 0){ //selected 0
                    P1Score.text = "Score: 0"
                    globalMatch?.score_player1 = 0
                }
                else if(PlayerOneScoreSelection.selectedSegmentIndex == 1){ //selected 1
                    P1Score.text = "Score: 1"
                    globalMatch?.score_player1 = 1
                }
                else if(PlayerOneScoreSelection.selectedSegmentIndex == 2) { //selected 2
                    P1Score.text = "Score: 2"
                    globalMatch?.score_player1 = 2
                }
                else if(PlayerOneScoreSelection.selectedSegmentIndex == 3) { //selected 3
                    P1Score.text = "Score: 3"
                    globalMatch?.score_player1 = 3
                }
            }
            else{
                if (PlayerOneScoreSelection.selectedSegmentIndex == 0){ //selected 0
                    
                    globalMatch?.score_player1 = 0
                }
                else if(PlayerOneScoreSelection.selectedSegmentIndex == 1){ //selected 1
                    
                    globalMatch?.score_player1 = 1
                }
                else if(PlayerOneScoreSelection.selectedSegmentIndex == 2) { //selected 2
                    
                    globalMatch?.score_player1 = 2
                }
                else if(PlayerOneScoreSelection.selectedSegmentIndex == 3) { //selected 3
                    
                    globalMatch?.score_player1 = 3
                }
            }
        }
    }
    @IBAction func DisplayScorePTwoUpdate(sender: UISegmentedControl) {
        if (globalMatch?.inProgress == 2){
            MessageLabel.text = "Unable to change scores because match has been submitted"
        }
        
        else {
            if(globalMatch?.playerDQ == 0){
                if(PlayerTwoScoreSelection.selectedSegmentIndex == 0){
                    P2Score.text = "Score: 0"
                    globalMatch?.score_player2 = 0
                }
                else if(PlayerTwoScoreSelection.selectedSegmentIndex == 1) {
                    P2Score.text = "Score: 1"
                    globalMatch?.score_player2 = 1
                }
                else if(PlayerTwoScoreSelection.selectedSegmentIndex == 2) {
                    P2Score.text = "Score: 2"
                    globalMatch?.score_player2 = 2
                }
                else if(PlayerTwoScoreSelection.selectedSegmentIndex == 3){
                    P2Score.text = "Score:3"
                    globalMatch?.score_player2 = 3
                }
            }
            else{
                if(PlayerTwoScoreSelection.selectedSegmentIndex == 0){
                    
                    globalMatch?.score_player2 = 0
                }
                else if(PlayerTwoScoreSelection.selectedSegmentIndex == 1) {
                    
                    globalMatch?.score_player2 = 1
                }
                else if(PlayerTwoScoreSelection.selectedSegmentIndex == 2) {
                    
                    globalMatch?.score_player2 = 2
                }
                else if(PlayerTwoScoreSelection.selectedSegmentIndex == 3){
                    
                    globalMatch?.score_player2 = 3
                }
                
            }
        }
    }
    
    //Button/Labels to Assign the Station
    
    @IBOutlet weak var AssignOutlet: UIButton!
    @IBOutlet weak var StationName: UILabel!
    @IBOutlet weak var StationTimer: UILabel!
    
    
    
    //Buttons for DQ (Disqualification)
    @IBAction func DQPlayerOne(sender: UIButton) {
        if(globalMatch?.inProgress == 2){
            MessageLabel.text = "Unable to change DQ status because match has been submitted"
        }
        
        else {
            P1Score.text = "Score: DQ"
            P2Score.text = "Score: W"
            globalMatch?.playerDQ = 1
        }
    }

    @IBAction func DQPlayer2(sender: UIButton) {
        if(globalMatch?.inProgress == 2){
            MessageLabel.text = "Unable to change scores because match has been submitted"
        }
        else{
            P1Score.text = "Score: W"
            P2Score.text = "Score: DQ"
            globalMatch?.playerDQ = 2
        }
    }
    
    //Clear a DQ, this is needed because a DQ superceeds the scores in a submission result. This means that if an organizer decides to undo a DQ before submitting the results
    @IBAction func ClearDQ(sender: UIButton) {
        if(globalMatch?.inProgress == 2){
            MessageLabel.text = "Unable to clear DQ because match has been submitted"
        }
        
        else{
            //set playerDQ to 0 meaning no player is DQ's then set the labels for scores
            globalMatch?.playerDQ = 0
            
            //if no scores
            if(globalMatch?.score_player1 == nil && globalMatch?.score_player2 == nil){
                P1Score.text = "Score: "
                P2Score.text = "Score: "
                
            }
                
                //if no score for player 1
            else if(globalMatch?.score_player1 == nil){
                P1Score.text = "Score: "
                P2Score.text = "Score: \(globalMatch?.score_player2)"
            }
                
                //if no score for player 2
            else if(globalMatch?.score_player2 == nil){
                P1Score.text = "Score: \(globalMatch?.score_player1)"
                P2Score.text = "Score: "
            }
                
                //if scores have been set for both players
            else{
                P1Score.text = "Score: \(globalMatch?.score_player1)"
                P2Score.text = "Score: \(globalMatch?.score_player2)"
            }
        }
        
    }
    
    
    //Submit Results
    @IBAction func SubmitResults(sender: UIButton) {
        if(globalMatch?.inProgress == 2){
            MessageLabel.text = "Unable to Submit Result because it has already been submitted"
            
        }
        
        else{ //determine players of next matches. winners/losers
            if(globalMatch?.playerDQ == 1){
                
                
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.setNavigationBarItem()
        navigationItem.title = "\(globalMatch?.player1?.name) vs \(globalMatch?.player2?.name)"
        let backButton = UIBarButtonItem(title: "Back", style: UIBarButtonItemStyle.Plain, target: self, action: "backButton")
        navigationItem.leftBarButtonItem = backButton
        
        AssignButtonCheck()
        LoadScores()
        
        
    }
    
    func backButton(){
        var bracketViewController: UIViewController!
        
        bracketViewController = storyboard!.instantiateViewControllerWithIdentifier("BracketViewController") as! BracketViewController
        bracketViewController = UINavigationController(rootViewController: bracketViewController)
        self.slideMenuController()?.changeMainViewController(bracketViewController, close: true)
    }
    
    //changes assign station button slightly if a station is assgined
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
    
    
    
    //loads the correct scores when the view is loaded
    func LoadScores() {
        if(globalMatch?.playerDQ == 0){ //no DQ
            if(globalMatch?.score_player1 == nil && globalMatch?.score_player2 == nil) {
                P1Score.text = "Score: "
                P2Score.text = "Score: "
            } //if no scores have been assigned
                
            else if(globalMatch?.score_player1 == nil){
                P1Score.text = "Score: "
                P2Score.text = "Score: \(globalMatch?.score_player2)"
            }//this check is done to see if only p1 score is nil while p2 would have an actual score
                
            else if(globalMatch?.score_player2 == nil){
                P1Score.text = "Score: \(globalMatch?.score_player1)"
                P2Score.text = "Score: "
            }
                
            else {
                P1Score.text = "Score: \(globalMatch?.score_player1)"
                P2Score.text = "Score: \(globalMatch?.score_player2)"
            }
        }
        
        else if(globalMatch?.playerDQ == 1){ //P1 DQ
            P1Score.text = "Score: DQ"
            P2Score.text = "Score: W"
        }
        
        else if(globalMatch?.playerDQ == 2){ //P2 DQ
            P1Score.text = "Score: W"
            P2Score.text = "Score: DQ"
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
