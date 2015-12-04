//
//  ParticipantViewController.swift
//  Tournament Manager
//
//  Created by Ishin Iwasaki on 10/6/15.
//  Copyright © 2015 ABIITJ. All rights reserved.
//

import UIKit
import CoreData

class ParticipantViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //Table views
    @IBOutlet weak var tableView1: UITableView!
    
    //Labels
    @IBOutlet weak var topLabel: UILabel!
    
    //TextFields
    @IBOutlet weak var nameField: UITextField!
    
    
    //selected participant index in this view
    var selectedParticipant: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(animated: Bool) {
        currentView = self
        super.viewWillAppear(animated)
        self.setNavigationBarItem()
        navigationItem.title = "Add Participants"
        let backButton = UIBarButtonItem(title: "Back", style: UIBarButtonItemStyle.Plain, target: self, action: "backButton")
        navigationItem.leftBarButtonItem = backButton
        topLabel.text = ""
        
    }
    
    func backButton(){
        var bracketViewController: UIViewController!
        
        bracketViewController = storyboard!.instantiateViewControllerWithIdentifier("BracketViewController") as! BracketViewController
        bracketViewController = UINavigationController(rootViewController: bracketViewController)
        self.slideMenuController()?.changeMainViewController(bracketViewController, close: true)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return competitors.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "Cell")
        let competitorName = competitors[indexPath.row].name
        let competitorSeed = competitors[indexPath.row].seed
        cell.textLabel?.text = "\(competitorSeed!): \(competitorName!)"
        return cell
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Participants in Bracket: \(competitors.count) Max: 64)"
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        selectedParticipant = indexPath.row
    }
    
    @IBAction func addNewButton(sender: AnyObject) {
        if(nameField.text == ""){
            topLabel.text = "Name cannot be blank"
        }
        else if (competitors.count >= 64){
            topLabel.text = "Max 64 participants"
        }
        else if (nameExists(nameField.text!)){
            topLabel.text = "Competitor name already exists."
        }
        else {
            let chosenName = nameField.text
            let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            let managedContext = appDelegate.managedObjectContext
            
            let entity = NSEntityDescription.entityForName("Participant", inManagedObjectContext: managedContext)
            let newParticipant = Participant(entity: entity!, insertIntoManagedObjectContext: managedContext)
            newParticipant.name = chosenName
            newParticipant.seed = competitors.count + 1
            newParticipant.wins = 0
            newParticipant.losses = 0
            newParticipant.parent_bracket = currentBracket
            placePlayerInMatch(Int(newParticipant.seed!), player: newParticipant)
            do {
                try managedContext.save()
                competitors.append(newParticipant)
                currentBracket?.numParts = competitors.count
                assignType()
                tableView1.reloadData()
                topLabel.text = ""
            } catch let error as NSError {
                print("Could not save \(error)")
            }
            nameField.text = ""
        }
    }
    
    
    @IBAction func deleteButton(sender: AnyObject) {
        if (selectedParticipant == nil){
            topLabel.text = "Select player to delete"
        }
        else {
            //player is selected, delete it
            let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            let managedContext = appDelegate.managedObjectContext
            managedContext.deleteObject(competitors[selectedParticipant!])
            for (var i=selectedParticipant!; i<competitors.count; ++i){
                //move down the other competitors' seeds
                competitors[i].seed = Int(competitors[i].seed!)-1
            }
            competitors.removeAtIndex(selectedParticipant!)
            resetMatches()
            for player in competitors{
                placePlayerInMatch(Int(player.seed!), player: player)
            }
            currentBracket?.numParts = competitors.count
            assignType()
            do {
                try managedContext.save()
                selectedParticipant = nil
                tableView1.reloadData()
                topLabel.text = ""
            } catch let error as NSError {
                print("Could not delete \(error)")
            }
        }
    }
    
    
    @IBAction func upSeedButton(sender: AnyObject) {
        if (selectedParticipant == nil){
            topLabel.text = "Select player to move."
        }
        else if (selectedParticipant == 0){
            //index is 0, meaning they are already top position
            topLabel.text = "Participant is already the 1 seed!"
        }
        else{
            let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            let managedContext = appDelegate.managedObjectContext
            
            //change seeds as appropriate & swap
            competitors[selectedParticipant!].seed = Int(competitors[selectedParticipant!].seed!)-1
            competitors[selectedParticipant!-1].seed = Int(competitors[selectedParticipant!-1].seed!)+1
            swap(&competitors[selectedParticipant!], &competitors[selectedParticipant!-1])
            
            resetMatches()
            //replace in matches
            placePlayerInMatch(Int(competitors[selectedParticipant!].seed!), player: competitors[selectedParticipant!])
            placePlayerInMatch(Int(competitors[selectedParticipant!-1].seed!), player: competitors[selectedParticipant!-1])
            do {
                try managedContext.save()
                tableView1.reloadData()
                topLabel.text = ""
                selectedParticipant = selectedParticipant!-1
            } catch let error as NSError {
                print("Could not delete \(error)")
            }
        }
        
    }
    
    
    @IBAction func downSeedButton(sender: AnyObject) {
        if (selectedParticipant == nil){
            topLabel.text = "Select player to move"
        }
        else if(selectedParticipant == competitors.count-1){
            //already the last seed
            topLabel.text = "Participant is already the last seed!"
        }
        else{
            let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            let managedContext = appDelegate.managedObjectContext
            
            //change seeds as appropriate & swap
            competitors[selectedParticipant!].seed = Int(competitors[selectedParticipant!].seed!)+1
            competitors[selectedParticipant!+1].seed = Int(competitors[selectedParticipant!+1].seed!)-1
            swap(&competitors[selectedParticipant!], &competitors[selectedParticipant!+1])
            
            resetMatches()
            //replace in matches
            placePlayerInMatch(Int(competitors[selectedParticipant!].seed!), player: competitors[selectedParticipant!])
            placePlayerInMatch(Int(competitors[selectedParticipant!+1].seed!), player: competitors[selectedParticipant!+1])
            
            do {
                try managedContext.save()
                tableView1.reloadData()
                topLabel.text = ""
                selectedParticipant = selectedParticipant!+1
            } catch let error as NSError {
                print("Could not delete \(error)")
            }
            
        }
        
    }
    
    //place the player in the appropriate match
    func placePlayerInMatch(seedNumber: Int, player: Participant){
        switch seedNumber {
        case 1:
            matches[0].player1 = player
            break
        case 2:
            matches[16].player1 = player
            break
        case 3:
            matches[24].player1 = player
            break
        case 4:
            matches[8].player1 = player
            break
        case 5:
            matches[15].player1 = player
            break
        case 6:
            matches[31].player1 = player
            break
        case 7:
            matches[23].player1 = player
            break
        case 8:
            matches[7].player1 = player
            break
        case 9:
            matches[4].player1 = player
            break
        case 10:
            matches[20].player1 = player
            break
        case 11:
            matches[28].player1 = player
            break
        case 12:
            matches[12].player1 = player
            break
        case 13:
            matches[11].player1 = player
            break
        case 14:
            matches[27].player1 = player
            break
        case 15:
            matches[19].player1 = player
            break
        case 16:
            matches[3].player1 = player
            break
        case 17:
            matches[2].player1 = player
            break
        case 18:
            matches[18].player1 = player
            break
        case 19:
            matches[26].player1 = player
            break
        case 20:
            matches[10].player1 = player
            break
        case 21:
            matches[13].player1 = player
            break
        case 22:
            matches[29].player1 = player
            break
        case 23:
            matches[21].player1 = player
            break
        case 24:
            matches[5].player1 = player
            break
        case 25:
            matches[6].player1 = player
            break
        case 26:
            matches[22].player1 = player
            break
        case 27:
            matches[30].player1 = player
            break
        case 28:
            matches[14].player1 = player
            break
        case 29:
            matches[9].player1 = player
            break
        case 30:
            matches[25].player1 = player
            break
        case 31:
            matches[17].player1 = player
            break
        case 32:
            matches[1].player1 = player
            break
        case 33:
            matches[1].player2 = player
            break
        case 34:
            matches[17].player2 = player
            break
        case 35:
            matches[25].player2 = player
            break
        case 36:
            matches[9].player2 = player
            break
        case 37:
            matches[14].player2 = player
            break
        case 38:
            matches[30].player2 = player
            break
        case 39:
            matches[22].player2 = player
            break
        case 40:
            matches[6].player2 = player
            break
        case 41:
            matches[5].player2 = player
            break
        case 42:
            matches[21].player2 = player
            break
        case 43:
            matches[29].player2 = player
            break
        case 44:
            matches[13].player2 = player
            break
        case 45:
            matches[10].player2 = player
            break
        case 46:
            matches[26].player2 = player
            break
        case 47:
            matches[18].player2 = player
            break
        case 48:
            matches[2].player2 = player
            break
        case 49:
            matches[3].player2 = player
            break
        case 50:
            matches[19].player2 = player
            break
        case 51:
            matches[27].player2 = player
            break
        case 52:
            matches[11].player2 = player
            break
        case 53:
            matches[12].player2 = player
            break
        case 54:
            matches[28].player2 = player
            break
        case 55:
            matches[20].player2 = player
            break
        case 56:
            matches[4].player2 = player
            break
        case 57:
            matches[7].player2 = player
            break
        case 58:
            matches[23].player2 = player
            break
        case 59:
            matches[31].player2 = player
            break
        case 60:
            matches[15].player2 = player
            break
        case 61:
            matches[8].player2 = player
            break
        case 62:
            matches[24].player2 = player
            break
        case 63:
            matches[16].player2 = player
            break
        case 64:
            matches[0].player2 = player
            break
        default:
            topLabel.text = "Error: Could not place player in match."
        }
    }
    
    //makes sure that seeds do not double up
    func nameExists(checkName: String) -> Bool {
        for player in competitors {
            if player.name == checkName {
                return true
            }
        }
        return false
    }
    
    func assignType(){
        if competitors.count < 3 {
            currentBracket?.bracketType = nil
        }
        else if competitors.count >= 3 && competitors.count <= 4{
            if currentBracket?.singleElim == true {
                currentBracket?.bracketType = 0
            }
            else {
                currentBracket?.bracketType = 1
            }
        }
        else if competitors.count > 4 && competitors.count <= 8 {
            if currentBracket?.singleElim == true {
                currentBracket?.bracketType = 2
            }
            else {
                currentBracket?.bracketType = 3
            }
        }
        else if competitors.count > 8 && competitors.count <= 16 {
            if currentBracket?.singleElim == true {
                currentBracket?.bracketType = 4
            }
            else{
                currentBracket?.bracketType = 5
            }
        }
        else if competitors.count > 16 && competitors.count <= 32 {
            if currentBracket?.singleElim == true {
                currentBracket?.bracketType = 6
            }
            else {
                currentBracket?.bracketType = 7
            }
        }
        else {
            if currentBracket?.singleElim == true {
                currentBracket?.bracketType = 8
            }
            else {
                currentBracket?.bracketType = 9
            }
        }
    }
    
    func resetMatches(){
        for eachMatch in matches{
            eachMatch.player1 = nil
            eachMatch.player2 = nil
        }
    }
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    @IBAction func helpButton(sender: AnyObject) {
    }
}
