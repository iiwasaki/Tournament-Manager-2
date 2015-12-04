//
//  BracketViewController.swift
//  Tournament Manager
//
//  Created by Ishin Iwasaki on 10/6/15.
//  Copyright © 2015 ABIITJ. All rights reserved.
//

import UIKit

class BracketViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //the matches that are not BYEs
    //Arrays to hold each round's matches
    var w1stRound = [Match]()
    var w2ndRound = [Match]()
    var w3rdRound = [Match]()
    var wQuarterRound = [Match]()
    var wSemiRound = [Match]()
    var wFinalRound = [Match]()
    var l1stRound = [Match]()
    var l2ndRound = [Match]()
    var l3rdRound = [Match]()
    var l4thRound = [Match]()
    var l5thRound = [Match]()
    var l6thRound = [Match]()
    var l7thRound = [Match]()
    var lQuarterRound = [Match]()
    var lSemiRound = [Match]()
    var lFinalRound = [Match]()
    var grandFinalsRound = [Match]()



    @IBOutlet weak var errorLabel: UILabel!
    
    @IBOutlet weak var startBut: UIButton!
    
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        print (matches.count)
        assignInitialByes()
        createRounds()
        print ("matches")
        for index in 0...62{
            print("match \(index): \(matches[index].hasBye!)")
        }
        for index in 63...94{
            print("match \(index): \(matches[index].hasBye!)")

        }
        /*
        print ("match 59: \(matches[59].hasBye!)")
        print ("match 61: \(matches[61].hasBye!)")
        for index in 111...123{
            print("match \(index): \(matches[index].hasBye!)")
        }
        */
        /*
        print ("match 115: \(matches[115].hasBye!)")

        print ("match 115: \(matches[115].hasBye!)")
        print ("match 116: \(matches[116].hasBye!)")
        print ("match 117: \(matches[117].hasBye!)")
        print ("match 118: \(matches[118].hasBye!)")
        print ("match 119: \(matches[119].hasBye!)")
        print ("match 120: \(matches[120].hasBye!)")
        print ("match 121: \(matches[121].hasBye!)")
        print ("match 122: \(matches[122].hasBye!)")
        print ("match 123: \(matches[123].hasBye!)")
*/
       // print(matches[124].hasBye!)
       // print(matches[125].hasBye!)
       // print(matches[126].hasBye!)
        //print(matches[115].hasBye!)
        //print(matches[119].hasBye!)


        tableView.reloadData()
        errorLabel.text = ""
        self.setNavigationBarItem()
        navigationItem.title = "Your Brackets"
        if (currentBracket == nil){
            navigationItem.title = "No Bracket Selected"
        }
        else
        {
            if currentBracket?.singleElim == true {
                navigationItem.title = "\(currentBracket!.name!)-(S)"
            }
            else{
                navigationItem.title = "\(currentBracket!.name!)-(D)"
            }
            if currentBracket?.started == true{
                //Don't add the "Add players" button
                startBut.setTitle("Stations List", forState: .Normal)
            }
            else {
                let addParticipantButton = UIBarButtonItem(title: "Add Players", style: UIBarButtonItemStyle.Plain, target: self, action: "addParticipantButton")
                navigationItem.rightBarButtonItem = addParticipantButton
                startBut.setTitle("Start Bracket", forState: .Normal)
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func addParticipantButton(){
        
        if currentBracket?.started == true{
            //Do nothing if the current Bracket is already started - user cannot change
            errorLabel.text = "Bracket already started"
        }
        else {
            var participantViewController: UIViewController!
            participantViewController = storyboard!.instantiateViewControllerWithIdentifier("ParticipantViewController") as! ParticipantViewController
            participantViewController = UINavigationController(rootViewController: participantViewController)
            self.slideMenuController()?.changeMainViewController(participantViewController, close: true)
        }
        
        
    }
    
    @IBAction func startBracket(sender: AnyObject) {
        if currentBracket!.started == true {
            //Show the station view
        }
        else if (currentBracket?.numParts != nil && Int((currentBracket?.numParts)!) > 1){
            //Start bracket
            //Code filled in later
            
            currentBracket?.started = true
            
            let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            let managedContext = appDelegate.managedObjectContext
            
            do {
                try managedContext.save()
                startBut.setTitle("Stations List", forState: .Normal)
            } catch let error as NSError {
                print("Could not save \(error)")
            }
        }
        else{
            //Number of participants not set
            errorLabel.text = "More than one participant must be active!"
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (competitors.count < 3){
            return 1
        }
        if currentBracket?.bracketType == 0{
            //4 Player SE 
            if section == 0{
                return wSemiRound.count
            }
            if section == 1{
                return wFinalRound.count
            }
        }
        else if currentBracket?.bracketType == 1{
            //4 Player DE
            if section == 0{
                return wSemiRound.count
            }
            if section == 1{
                return wFinalRound.count
            }
            if section == 2{
                return lSemiRound.count
            }
            if section == 3 {
                return lFinalRound.count
            }
            if section == 4{
                return grandFinalsRound.count
            }
        }
        else if currentBracket?.bracketType == 2{
            //8 player SE
            if section == 0 {
                return wQuarterRound.count
            }
            if section == 1{
                return wSemiRound.count
            }
            if section == 2{
                return wFinalRound.count
            }
        }
        else if currentBracket?.bracketType == 3{
            //8 Player DE
            if section == 0 {
                return wQuarterRound.count
            }
            if section == 1 {
                return l7thRound.count
            }
            if section == 2 {
                return lQuarterRound.count
            }
            if section == 3{
                return wSemiRound.count
            }
            if section == 4{
                return wFinalRound.count
            }
            if section == 5{
                return lSemiRound.count
            }
            if section == 6 {
                return lFinalRound.count
            }
            if section == 7{
                return grandFinalsRound.count
            }
        }
        else if currentBracket?.bracketType == 4{
            //16 player SE
            if section == 0{
                return w3rdRound.count
            }
            if section == 1 {
                return wQuarterRound.count
            }
            if section == 2{
                return wSemiRound.count
            }
            if section == 3{
                return wFinalRound.count
            }

        }
        else if currentBracket?.bracketType == 5{
            //16 Player DE
            if section == 0{
                return w3rdRound.count
            }
            if section == 1 {
                return wQuarterRound.count
            }
            if section == 2{
                return l5thRound.count
            }
            if section == 3{
                return l6thRound.count
            }
            if section == 4{
                return wSemiRound.count
            }
            if section == 5{
                return l7thRound.count
            }
            if section == 6 {
                return lQuarterRound.count
            }
            if section == 7{
                return wFinalRound.count
            }
            if section == 8{
                return lSemiRound.count
            }
            if section == 9 {
                return lFinalRound.count
            }
            if section == 10{
                return grandFinalsRound.count
            }
        }
        else if currentBracket?.bracketType == 6{
            //32 player SE
            if section == 0 {
                return w2ndRound.count
            }
            if section == 1{
                return w3rdRound.count
            }
            if section == 2 {
                return wQuarterRound.count
            }
            if section == 3{
                return wSemiRound.count
            }
            if section == 4{
                return wFinalRound.count
            }
            
        }
        else if currentBracket?.bracketType == 7{
            //32 Player DE
            if section == 0{
                return w2ndRound.count
            }
            if section == 1{
                return w3rdRound.count
            }
            if section == 2{
                return l3rdRound.count
            }
            if section == 3{
                return l4thRound.count
            }
            if section == 4{
                return wQuarterRound.count
            }
            if section == 5{
                return l5thRound.count
            }
            if section == 6{
                return l6thRound.count
            }
            if section == 7{
                return wSemiRound.count
            }
            if section == 8{
                return l7thRound.count
            }
            if section == 9{
                return lQuarterRound.count
            }
            if section == 10{
                return wFinalRound.count
            }
            if section == 11{
                return lSemiRound.count
            }
            if section == 12{
                return lFinalRound.count
            }
            if section == 13{
                return grandFinalsRound.count
            }
        }
        else if currentBracket?.bracketType == 8{
            //64 player SE
            if section == 0 {
                return w1stRound.count
            }
            if section == 1 {
                return w2ndRound.count
            }
            if section == 2{
                return w3rdRound.count
            }
            if section == 3 {
                return wQuarterRound.count
            }
            if section == 4{
                return wSemiRound.count
            }
            if section == 5{
                return wFinalRound.count
            }
        }
        else if currentBracket?.bracketType == 9{
            //64 player DE 
            if section == 0 {
                return w1stRound.count
            }
            if section == 1 {
                return w2ndRound.count
            }
            if section == 2 {
                return l1stRound.count
            }
            if section == 3 {
                return l2ndRound.count
            }
            if section == 4 {
                return w3rdRound.count
            }
            if section == 5 {
                return l3rdRound.count
            }
            if section == 6 {
                return l4thRound.count
            }
            if section == 7 {
                return wQuarterRound.count
            }
            if section == 8 {
                return l5thRound.count
            }
            if section == 9 {
                return l6thRound.count
            }
            if section == 10 {
                return wSemiRound.count
            }
            if section == 11 {
                return l7thRound.count
            }
            if section == 12 {
                return lQuarterRound.count
            }
            if section == 13 {
                return wFinalRound.count
            }
            if section == 14 {
                return lSemiRound.count
            }
            if section == 15 {
                return lFinalRound.count
            }
            if section == 16 {
                return grandFinalsRound.count
            }
            
        }

        else{
            return 3
        }
        return 1 
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        if currentBracket?.bracketType == nil {
            return 1 //no bracket type yet
        }
        else if currentBracket?.bracketType == 0 {
            return 2 //4-person, SE
        }
        else if currentBracket?.bracketType == 1{
            return 5 //4-person, DE
        }
        else if currentBracket?.bracketType == 2{
            return 3 //8-person, SE
        }
        else if currentBracket?.bracketType == 3{
            return 8 //8-person, DE
        }
        else if currentBracket?.bracketType == 4{
            return 4 //16-person, SE
        }
        else if currentBracket?.bracketType == 5{
            return 11 //16-person, DE
        }
        else if currentBracket?.bracketType == 6{
            return 5 //32-person, SE
        }
        else if currentBracket?.bracketType == 7{
            return 14 //32-person, DE
        }
        else if currentBracket?.bracketType == 8{
            return 6 //64-person, SE
        }
        else {
            return 17 //64-person, DE
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "Cell")
        if(competitors.count < 3){
            cell.textLabel!.text = "Please add at least 3 players."
            return cell
        }
        if currentBracket?.bracketType == 0{
            //4-person SE 
            if indexPath.section == 0{
                let thisMatch = wSemiRound[indexPath.row]
                cell.textLabel!.text = getCellText(thisMatch)
            }
            else if indexPath.section == 1 {
                let thisMatch = wFinalRound[indexPath.row]
                cell.textLabel!.text = getCellText(thisMatch)
            }
        }
        else if currentBracket?.bracketType == 1 {
            //4 person DE
            if indexPath.section == 0 {
                let thisMatch = wSemiRound[indexPath.row]
                cell.textLabel!.text = getCellText(thisMatch)
            }
            else if indexPath.section == 1{
                let thisMatch = wFinalRound[indexPath.row]
                cell.textLabel!.text = getCellText(thisMatch)
            }
            else if indexPath.section == 2{
                let thisMatch = lSemiRound[indexPath.row]
                cell.textLabel!.text = getCellText(thisMatch)
            }
            else if indexPath.section == 3{
                let thisMatch = lFinalRound[indexPath.row]
                cell.textLabel!.text = getCellText(thisMatch)
            }
            else if indexPath.section == 4{
                let thisMatch = grandFinalsRound[indexPath.row]
                cell.textLabel!.text = getCellText(thisMatch)
            }
        }
        else if currentBracket?.bracketType == 2{
            if indexPath.section == 0 {
                let thisMatch = wQuarterRound[indexPath.row]
                cell.textLabel!.text = getCellText(thisMatch)
            }
            else if indexPath.section == 1 {
                let thisMatch = wSemiRound[indexPath.row]
                cell.textLabel!.text = getCellText(thisMatch)
            }
            else if indexPath.section == 2{
                let thisMatch = wFinalRound[indexPath.row]
                cell.textLabel!.text = getCellText(thisMatch)
            }
        }
        else if currentBracket?.bracketType == 3 {
            //8 person DE
            if indexPath.section == 0{
                let thisMatch = wQuarterRound[indexPath.row]
                cell.textLabel!.text = getCellText(thisMatch)
            }
            else if indexPath.section == 1{
                let thisMatch = l7thRound[indexPath.row]
                cell.textLabel!.text = getCellText(thisMatch)
            }
            else if indexPath.section == 2{
                let thisMatch = lQuarterRound[indexPath.row]
                cell.textLabel!.text = getCellText(thisMatch)
            }
            else if indexPath.section == 3 {
                let thisMatch = wSemiRound[indexPath.row]
                cell.textLabel!.text = getCellText(thisMatch)
            }
            else if indexPath.section == 4{
                let thisMatch = wFinalRound[indexPath.row]
                cell.textLabel!.text = getCellText(thisMatch)
            }
            else if indexPath.section == 5{
                let thisMatch = lSemiRound[indexPath.row]
                cell.textLabel!.text = getCellText(thisMatch)
            }
            else if indexPath.section == 6{
                let thisMatch = lFinalRound[indexPath.row]
                cell.textLabel!.text = getCellText(thisMatch)
            }
            else if indexPath.section == 7{
                let thisMatch = grandFinalsRound[indexPath.row]
                cell.textLabel!.text = getCellText(thisMatch)
            }
        }
        else if currentBracket?.bracketType == 4{
            //16 person SE
            if indexPath.section == 0 {
                let thisMatch = w3rdRound[indexPath.row]
                cell.textLabel!.text = getCellText(thisMatch)
            }
            if indexPath.section == 1 {
                let thisMatch = wQuarterRound[indexPath.row]
                cell.textLabel!.text = getCellText(thisMatch)
            }
            else if indexPath.section == 2 {
                let thisMatch = wSemiRound[indexPath.row]
                cell.textLabel!.text = getCellText(thisMatch)
            }
            else if indexPath.section == 3{
                let thisMatch = wFinalRound[indexPath.row]
                cell.textLabel!.text = getCellText(thisMatch)
            }
        }
        else if currentBracket?.bracketType == 5{
            //16 person DE
            if indexPath.section == 0{
                let thisMatch = w3rdRound[indexPath.row]
                cell.textLabel!.text = getCellText(thisMatch)
            }
            if indexPath.section == 1{
                let thisMatch = wQuarterRound[indexPath.row]
                cell.textLabel!.text = getCellText(thisMatch)
            }
            if indexPath.section == 2{
                let thisMatch = l5thRound[indexPath.row]
                cell.textLabel!.text = getCellText(thisMatch)
            }
            if indexPath.section == 3{
                let thisMatch = l6thRound[indexPath.row]
                cell.textLabel!.text = getCellText(thisMatch)
            }
            if indexPath.section == 4{
                let thisMatch = wSemiRound[indexPath.row]
                cell.textLabel!.text = getCellText(thisMatch)
            }
            if indexPath.section == 5{
                let thisMatch = l7thRound[indexPath.row]
                cell.textLabel!.text = getCellText(thisMatch)
            }
            if indexPath.section == 6{
                let thisMatch = lQuarterRound[indexPath.row]
                cell.textLabel!.text = getCellText(thisMatch)
            }
            if indexPath.section == 7{
                let thisMatch = wFinalRound[indexPath.row]
                cell.textLabel!.text = getCellText(thisMatch)
            }
            if indexPath.section == 8{
                let thisMatch = lSemiRound[indexPath.row]
                cell.textLabel!.text = getCellText(thisMatch)
            }
            if indexPath.section == 9{
                let thisMatch = lFinalRound[indexPath.row]
                cell.textLabel!.text = getCellText(thisMatch)
            }
            if indexPath.section == 10{
                let thisMatch = grandFinalsRound[indexPath.row]
                cell.textLabel!.text = getCellText(thisMatch)
            }

        }
        else if currentBracket?.bracketType == 6{
            //32 person SE
            if indexPath.section == 0{
                let thisMatch = w2ndRound[indexPath.row]
                cell.textLabel!.text = getCellText(thisMatch)
            }
            if indexPath.section == 1 {
                let thisMatch = w3rdRound[indexPath.row]
                cell.textLabel!.text = getCellText(thisMatch)
            }
            if indexPath.section == 2 {
                let thisMatch = wQuarterRound[indexPath.row]
                cell.textLabel!.text = getCellText(thisMatch)
            }
            else if indexPath.section == 3 {
                let thisMatch = wSemiRound[indexPath.row]
                cell.textLabel!.text = getCellText(thisMatch)
            }
            else if indexPath.section == 4{
                let thisMatch = wFinalRound[indexPath.row]
                cell.textLabel!.text = getCellText(thisMatch)
            }
        }
        else if currentBracket?.bracketType == 7{
            if indexPath.section == 0{
                let thisMatch = w2ndRound[indexPath.row]
                cell.textLabel!.text = getCellText(thisMatch)
            }
            if indexPath.section == 1{
                let thisMatch = w3rdRound[indexPath.row]
                cell.textLabel!.text = getCellText(thisMatch)
            }
            if indexPath.section == 2{
                let thisMatch = l3rdRound[indexPath.row]
                cell.textLabel!.text = getCellText(thisMatch)
            }
            if indexPath.section == 3{
                let thisMatch = l4thRound[indexPath.row]
                cell.textLabel!.text = getCellText(thisMatch)
            }
            if indexPath.section == 4{
                let thisMatch = wQuarterRound[indexPath.row]
                cell.textLabel!.text = getCellText(thisMatch)
            }
            if indexPath.section == 5{
                let thisMatch = l5thRound[indexPath.row]
                cell.textLabel!.text = getCellText(thisMatch)
            }
            if indexPath.section == 6{
                let thisMatch = l6thRound[indexPath.row]
                cell.textLabel!.text = getCellText(thisMatch)
            }
            if indexPath.section == 7{
                let thisMatch = wSemiRound[indexPath.row]
                cell.textLabel!.text = getCellText(thisMatch)
            }
            if indexPath.section == 8{
                let thisMatch = l7thRound[indexPath.row]
                cell.textLabel!.text = getCellText(thisMatch)
            }
            if indexPath.section == 9{
                let thisMatch = lQuarterRound[indexPath.row]
                cell.textLabel!.text = getCellText(thisMatch)
            }
            if indexPath.section == 10{
                let thisMatch = wFinalRound[indexPath.row]
                cell.textLabel!.text = getCellText(thisMatch)
            }
            if indexPath.section == 11{
                let thisMatch = lSemiRound[indexPath.row]
                cell.textLabel!.text = getCellText(thisMatch)
            }
            if indexPath.section == 12{
                let thisMatch = lFinalRound[indexPath.row]
                cell.textLabel!.text = getCellText(thisMatch)
            }
            if indexPath.section == 13{
                let thisMatch = grandFinalsRound[indexPath.row]
                cell.textLabel!.text = getCellText(thisMatch)
            }
        }
        else if currentBracket?.bracketType == 8{
            //64 person SE
            if indexPath.section == 0{
                let thisMatch = w1stRound[indexPath.row]
                cell.textLabel!.text = getCellText(thisMatch)
            }
            if indexPath.section == 1{
                let thisMatch = w2ndRound[indexPath.row]
                cell.textLabel!.text = getCellText(thisMatch)
            }
            if indexPath.section == 2 {
                let thisMatch = w3rdRound[indexPath.row]
                cell.textLabel!.text = getCellText(thisMatch)
            }
            if indexPath.section == 3 {
                let thisMatch = wQuarterRound[indexPath.row]
                cell.textLabel!.text = getCellText(thisMatch)
            }
            else if indexPath.section == 4 {
                let thisMatch = wSemiRound[indexPath.row]
                cell.textLabel!.text = getCellText(thisMatch)
            }
            else if indexPath.section == 5{
                let thisMatch = wFinalRound[indexPath.row]
                cell.textLabel!.text = getCellText(thisMatch)
            }
        }
        else if currentBracket?.bracketType == 9{
            if indexPath.section == 0{
                let thisMatch = w1stRound[indexPath.row]
                cell.textLabel!.text = getCellText(thisMatch)
            }
            if indexPath.section == 1{
                let thisMatch = w2ndRound[indexPath.row]
                cell.textLabel!.text = getCellText(thisMatch)
            }
            if indexPath.section == 2{
                let thisMatch = l1stRound[indexPath.row]
                cell.textLabel!.text = getCellText(thisMatch)
            }
            if indexPath.section == 3{
                let thisMatch = l2ndRound[indexPath.row]
                cell.textLabel!.text = getCellText(thisMatch)
            }
            if indexPath.section == 4{
                let thisMatch = w3rdRound[indexPath.row]
                cell.textLabel!.text = getCellText(thisMatch)
            }
            if indexPath.section == 5{
                let thisMatch = l3rdRound[indexPath.row]
                cell.textLabel!.text = getCellText(thisMatch)
            }
            if indexPath.section == 6{
                let thisMatch = l4thRound[indexPath.row]
                cell.textLabel!.text = getCellText(thisMatch)
            }
            if indexPath.section == 7{
                let thisMatch = wQuarterRound[indexPath.row]
                cell.textLabel!.text = getCellText(thisMatch)
            }
            if indexPath.section == 8{
                let thisMatch = l5thRound[indexPath.row]
                cell.textLabel!.text = getCellText(thisMatch)
            }
            if indexPath.section == 9{
                let thisMatch = l6thRound[indexPath.row]
                cell.textLabel!.text = getCellText(thisMatch)
            }
            if indexPath.section == 10{
                let thisMatch = wSemiRound[indexPath.row]
                cell.textLabel!.text = getCellText(thisMatch)
            }
            if indexPath.section == 11{
                let thisMatch = l7thRound[indexPath.row]
                cell.textLabel!.text = getCellText(thisMatch)
            }
            if indexPath.section == 12{
                let thisMatch = lQuarterRound[indexPath.row]
                cell.textLabel!.text = getCellText(thisMatch)
            }
            if indexPath.section == 13{
                let thisMatch = wFinalRound[indexPath.row]
                cell.textLabel!.text = getCellText(thisMatch)
            }
            if indexPath.section == 14{
                let thisMatch = lSemiRound[indexPath.row]
                cell.textLabel!.text = getCellText(thisMatch)
            }
            if indexPath.section == 15{
                let thisMatch = lFinalRound[indexPath.row]
                cell.textLabel!.text = getCellText(thisMatch)
            }
            if indexPath.section == 16{
                let thisMatch = grandFinalsRound[indexPath.row]
                cell.textLabel!.text = getCellText(thisMatch)
            }
        }
            
        else {
                cell.textLabel!.text = "Test"
        }
        return cell

    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if(currentBracket?.bracketType == nil){
            return ""
        }
        else if (currentBracket?.bracketType == 0){
            switch section {
            case 0:
                return "Winner's Semi-Finals"
            case 1:
                return "Winner's Finals"
            default:
                return "Error"
            }
        }
        else if (currentBracket?.bracketType == 1){
            switch section {
            case 0:
                return "Winner's Semi-Finals"
            case 1:
                return "Winner's Finals"
            case 2:
                return "Loser's Semis"
            case 3:
                return "Loser's Finals"
            case 4:
                return "Grand Finals"
            default:
                return "Error"
            }
        }
        else if (currentBracket?.bracketType == 2){
            switch section {
            case 0:
                return "Winner's Quarter-Finals"
            case 1:
                return "Winner's Semi-Finals"
            case 2:
                return "Winner's Finals"
            default:
                return "Error"
            }
        }
        else if (currentBracket?.bracketType == 3){
            switch section{
            case 0:
                return "Winner's Quarter-Finals"
            case 1:
                return "Loser's First Round"
            case 2:
                return "Loser's Quarter-Finals"
            case 3:
                return "Winner's Semi-Finals"
            case 4:
                return "Winner's Finals"
            case 5:
                return "Loser's Semis"
            case 6:
                return "Loser's Finals"
            case 7:
                return "Grand Finals"
            default:
                return "Error"
            }
        }
        else if(currentBracket?.bracketType == 4){
            switch section{
            case 0:
                return "Winner's First Round"
            case 1:
                return "Winner's Quarter-Finals"
            case 2:
                return "Winner's Semi-Finals"
            case 3:
                return "Winner's Finals"
            default:
                return "Error"
            }
        }
        else if(currentBracket?.bracketType == 5){
            switch section{
            case 0:
                return "Winner's First Round"
            case 1:
                return "Winner's Quarter-Finals"
            case 2:
                return "Loser's First Round"
            case 3:
                return "Loser's Second Round"
            case 4:
                return "Winner's Semi-Finals"
            case 5:
                return "Loser's Third Round"
            case 6:
                return "Loser's Quarter-Finals"
            case 7:
                return "Winner's Finals"
            case 8:
                return "Loser's Semis"
            case 9:
                return "Loser's Finals"
            case 10:
                return "Grand Finals"
            default:
                return "Error"
            }
        }
        else if(currentBracket?.bracketType == 6){
            //32 per SE
            switch section {
            case 0:
                return "Winner's First Round"
            case 1:
                return "Winner's Second Round"
            case 2:
                return "Winner's Quarter-Finals"
            case 3:
                return "Winner's Semi-Finals"
            case 4:
                return "Winner's Finals"
            default:
                return "Error"
            }
        }
        else if(currentBracket?.bracketType == 7){
            switch section{
            case 0:
                return "Winner's First Round"
            case 1:
                return "Winner's Second Round"
            case 2:
                return "Loser's First Round"
            case 3:
                return "Loser's Second Round"
            case 4:
                return "Winner's Quarter-Finals"
            case 5:
                return "Loser's Third Round"
            case 6:
                return "Loser's Fourth Round"
            case 7:
                return "Winner's Semi-Finals"
            case 8:
                return "Loser's Fifth Round"
            case 9:
                return "Loser's Quarter-Finals"
            case 10:
                return "Winner's Finals"
            case 11:
                return "Loser's Semi-Finals"
            case 12:
                return "Loser's Finals"
            case 13:
                return "Grand Finals"
            default:
                return "Error"
            }
        }
        else if(currentBracket?.bracketType == 8){
            switch section {
            case 0:
                return "Winner's First Round"
            case 1:
                return "Winner's Second Round"
            case 2:
                return "Winner's Third Round"
            case 3:
                return "Winner's Quarter-Finals"
            case 4:
                return "Winner's Semi-Finals"
            case 5:
                return "Winner's Finals"
            default:
                return "Error"
            }
        }
        else {
            switch section{
            case 0:
                return "Winner's First Round"
            case 1:
                return "Winner's Second Round"
            case 2:
                return "Loser's First Round"
            case 3:
                return "Loser's Second Round"
            case 4:
                return "Winner's Third Round"
            case 5:
                return "Loser's Third Round"
            case 6:
                return "Loser's Fourth Round"
            case 7:
                return "Winner's Quarter-Finals"
            case 8:
                return "Loser's Fifth Round"
            case 9:
                return "Loser's Sixth Round"
            case 10:
                return "Winner's Semi-Finals"
            case 11:
                return "Loser's Seventh Round"
            case 12:
                return "Loser's Quarter-Finals"
            case 13:
                return "Winner's Finals"
            case 14:
                return "Loser's Semi-Finals"
            case 15:
                return "Loser's Finals"
            case 16:
                return "Grand Finals"
            default:
                return "Error"
            }
    
        }
    }
    //set up the Byes for the first round of 64
    func assignInitialByes(){
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        for eachMatch in matches{
            eachMatch.hasBye = 0
        }
        if currentBracket?.singleElim == true {
            for range in 32...62 {
                matches[range].player1 = nil
                matches[range].player2 = nil
            }
        }
        else{
            for range in 32...126{
                matches[range].player1 = nil
                matches[range].player2 = nil
            }
        }
        if currentBracket?.singleElim == true  {
            for index in 0...31{
                if matches[index].player1 == nil && matches[index].player2 == nil{
                    //both are BYES
                    matches[index].hasBye = 3
                }
                else if matches[index].player1 == nil && matches[index].player2 != nil {
                    //Player 1 is a BYE
                    matches[index].hasBye = 1
                }
                else if matches[index].player2 == nil && matches[index].player1 != nil{
                    //Player 2 is a BYE
                    matches[index].hasBye = 2
                }
                else {
                    //No byes
                    matches[index].hasBye = 0
                }
            }
            for index in 0...61 {
                matches[index].advanceWinnersInitial()
            }
        }
        else {
            if currentBracket?.bracketType == 1{
                //4-player DE
                for index in 0...31{
                    if matches[index].player1 == nil && matches[index].player2 == nil{
                        //both are BYES
                        matches[index].hasBye = 3
                    }
                    else if matches[index].player1 == nil && matches[index].player2 != nil {
                        //Player 1 is a BYE
                        matches[index].hasBye = 1
                    }
                    else if matches[index].player2 == nil && matches[index].player1 != nil{
                        //Player 2 is a BYE
                        matches[index].hasBye = 2
                    }
                    else {
                        //No byes
                        matches[index].hasBye = 0
                    }
                }
                for index in 121...122{
                    matches[index].hasBye = 2
                }
                matches[123].hasBye = 3
                for index in 0...61 {
                    matches[index].advanceWinnersInitial()
                }
                for index in 121...122{
                    matches[index].advanceWinnersInitial()
                }
                
            }
            else if currentBracket?.bracketType == 3{
                //8-player DE
                for index in 0...31{
                    if matches[index].player1 == nil && matches[index].player2 == nil{
                        //both are BYES
                        matches[index].hasBye = 3
                    }
                    else if matches[index].player1 == nil && matches[index].player2 != nil {
                        //Player 1 is a BYE
                        matches[index].hasBye = 1
                    }
                    else if matches[index].player2 == nil && matches[index].player1 != nil{
                        //Player 2 is a BYE
                        matches[index].hasBye = 2
                    }
                    else {
                        //No byes
                        matches[index].hasBye = 0
                    }
                }
                for index in 115...118{
                    matches[index].hasBye = 2
                }
                for index in 119...122{
                    matches[index].hasBye = 3
                }
                for index in 0...61 {
                    matches[index].advanceWinnersInitial()
                }
                for index in 115...120{
                    matches[index].advanceWinnersInitial()
                }
                
            }
            else if currentBracket?.bracketType == 5{
                //16-player DE
                for index in 0...31{
                    if matches[index].player1 == nil && matches[index].player2 == nil{
                        //both are BYES
                        matches[index].hasBye = 3
                    }
                    else if matches[index].player1 == nil && matches[index].player2 != nil {
                        //Player 1 is a BYE
                        matches[index].hasBye = 1
                    }
                    else if matches[index].player2 == nil && matches[index].player1 != nil{
                        //Player 2 is a BYE
                        matches[index].hasBye = 2
                    }
                    else {
                        //No byes
                        matches[index].hasBye = 0
                    }
                }
                for index in 103...110{
                    matches[index].hasBye = 2
                }
                for index in 111...118{
                    matches[index].hasBye = 3
                }
                for index in 119...126{
                    matches[index].hasBye = 0 
                }
                for index in 0...59 {
                    matches[index].advanceWinnersInitial()
                }
                for index in 103...114{
                    matches[index].advanceWinnersInitial()
                }
                
            }
            
            else if currentBracket?.bracketType == 7{
                //32-player DE
                for index in 0...31{
                    if matches[index].player1 == nil && matches[index].player2 == nil{
                        //both are BYES
                        matches[index].hasBye = 3
                    }
                    else if matches[index].player1 == nil && matches[index].player2 != nil {
                        //Player 1 is a BYE
                        matches[index].hasBye = 1
                    }
                    else if matches[index].player2 == nil && matches[index].player1 != nil{
                        //Player 2 is a BYE
                        matches[index].hasBye = 2
                    }
                    else {
                        //No byes
                        matches[index].hasBye = 0
                    }
                }
                for index in 79...94{
                    matches[index].hasBye = 2
                }
                for index in 95...110{
                    matches[index].hasBye = 3
                }
                for index in 111...126{
                    matches[index].hasBye = 0
                }
                for index in 0...55 {
                    matches[index].advanceWinnersInitial()
                }
                for index in 79...102{
                    matches[index].advanceWinnersInitial()
                }
                
            }
            else if currentBracket?.bracketType == 9{
                //64-player DE
                for index in 0...31{
                    if matches[index].player1 == nil && matches[index].player2 == nil{
                        //both are BYES
                        matches[index].hasBye = 3
                    }
                    else if matches[index].player1 == nil && matches[index].player2 != nil {
                        //Player 1 is a BYE
                        matches[index].hasBye = 1
                    }
                    else if matches[index].player2 == nil && matches[index].player1 != nil{
                        //Player 2 is a BYE
                        matches[index].hasBye = 2
                    }
                    else {
                        //No byes
                        matches[index].hasBye = 0
                    }
                }
                for index in 63...94{
                    matches[index].hasBye = 3
                }
                for index in 95...126{
                    matches[index].hasBye = 0
                }
                for index in 0...47 {
                    matches[index].advanceWinnersInitial()
                }
                for index in 63...94{
                    matches[index].advanceWinnersInitial()
                }
                
            }

        }

        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save assign to winners \(error)")
        }
        
    }
    
    func createRounds(){
        if currentBracket?.bracketType == 0{
            //4-person SE 
            for index in 60...61{
                if matches[index].hasBye == 0{
                    wSemiRound.append(matches[index])
                }
                else{
                    //do nothing
                }
            }
            wFinalRound.append(matches[62])
        }
        else if currentBracket?.bracketType == 1{
            //4-person DE 
            for index in 60...61{
                if matches[index].hasBye == 0{
                    wSemiRound.append(matches[index])
                }
                else {
                    //do nothing
                }
            }
            wFinalRound.append(matches[62])
            if matches[123].hasBye == 0{
                lSemiRound.append(matches[123])
            }
            lFinalRound.append(matches[124])
            grandFinalsRound.append(matches[125])
            grandFinalsRound.append(matches[126])
        }
        else if currentBracket?.bracketType == 2{
            //8-person SE 
            for index in 56...59{
                if matches[index].hasBye == 0{
                    wQuarterRound.append(matches[index])
                }
            }
            for index in 60...61{
                if matches[index].hasBye == 0{
                    wSemiRound.append(matches[index])
                }
                else{
                    //do nothing
                }
            }
            wFinalRound.append(matches[62])
        }
        else if currentBracket?.bracketType == 3{
            //8-person DE
            for index in 56...59{
                if matches[index].hasBye == 0{
                    wQuarterRound.append(matches[index])
                }
            }
            for index in 60...61{
                if matches[index].hasBye == 0{
                    wSemiRound.append(matches[index])
                }
                else {
                    //do nothing
                }
            }
            for index in 119...120{
                if matches[index].hasBye == 0 {
                    l7thRound.append(matches[index])
                }
            }
            for index in 121...122{
                if matches[index].hasBye == 0{
                    lQuarterRound.append(matches[index])
                }
            }
            wFinalRound.append(matches[62])
            if matches[123].hasBye == 0{
                lSemiRound.append(matches[123])
            }
            lFinalRound.append(matches[124])
            grandFinalsRound.append(matches[125])
            grandFinalsRound.append(matches[126])
        }
        else if currentBracket?.bracketType == 4{
            //16-person SE
            for index in 48...55{
                if matches[index].hasBye == 0{
                    w3rdRound.append(matches[index])
                }
            }
            for index in 56...59{
                if matches[index].hasBye == 0{
                    wQuarterRound.append(matches[index])
                }
            }
            for index in 60...61{
                if matches[index].hasBye == 0{
                    wSemiRound.append(matches[index])
                }
                else{
                    //do nothing
                }
            }
            wFinalRound.append(matches[62])
        }
        else if currentBracket?.bracketType == 5{
            //16-person DE
            for index in 48...55{
                if matches[index].hasBye == 0{
                    w3rdRound.append(matches[index])
                }
            }
            for index in 56...59{
                if matches[index].hasBye == 0{
                    wQuarterRound.append(matches[index])
                }
            }
            for index in 60...61{
                if matches[index].hasBye == 0{
                    wSemiRound.append(matches[index])
                }
                else {
                    //do nothing
                }
            }
            for index in 111...114{
                if matches[index].hasBye == 0{
                   l5thRound.append(matches[index])
                }
            }
            for index in 115...118{
                if matches[index].hasBye == 0{
                    l6thRound.append(matches[index])
                }
            }
            for index in 119...120{
                if matches[index].hasBye == 0 {
                    l7thRound.append(matches[index])
                }
            }
            for index in 121...122{
                if matches[index].hasBye == 0{
                    lQuarterRound.append(matches[index])
                }
            }
            wFinalRound.append(matches[62])
            if matches[123].hasBye == 0{
                lSemiRound.append(matches[123])
            }
            lFinalRound.append(matches[124])
            grandFinalsRound.append(matches[125])
            grandFinalsRound.append(matches[126])
        }
        
        else if currentBracket?.bracketType == 6{
            //32-person SE
            for index in 32...47{
                if matches[index].hasBye == 0{
                    w2ndRound.append(matches[index])
                }
            }
            for index in 48...55{
                if matches[index].hasBye == 0{
                    w3rdRound.append(matches[index])
                }
            }
            for index in 56...59{
                if matches[index].hasBye == 0{
                    wQuarterRound.append(matches[index])
                }
            }
            for index in 60...61{
                if matches[index].hasBye == 0{
                    wSemiRound.append(matches[index])
                }
                else{
                    //do nothing
                }
            }
            wFinalRound.append(matches[62])
        }
        else if currentBracket?.bracketType == 7{
            //32-person DE
            for index in 32...47{
                if matches[index].hasBye == 0{
                    w2ndRound.append(matches[index])
                }
            }
            for index in 48...55{
                if matches[index].hasBye == 0{
                    w3rdRound.append(matches[index])
                }
            }
            for index in 56...59{
                if matches[index].hasBye == 0{
                    wQuarterRound.append(matches[index])
                }
            }
            for index in 60...61{
                if matches[index].hasBye == 0{
                    wSemiRound.append(matches[index])
                }
                else {
                    //do nothing
                }
            }
            for index in 95...102{
                if matches[index].hasBye == 0{
                    l3rdRound.append(matches[index])
                }
            }
            for index in 103...110{
                if matches[index].hasBye == 0{
                    l4thRound.append(matches[index])
                }
            }
            for index in 111...114{
                if matches[index].hasBye == 0{
                    l5thRound.append(matches[index])
                }
            }
            for index in 115...118{
                if matches[index].hasBye == 0{
                    l6thRound.append(matches[index])
                }
            }
            for index in 119...120{
                if matches[index].hasBye == 0 {
                    l7thRound.append(matches[index])
                }
            }
            for index in 121...122{
                if matches[index].hasBye == 0{
                    lQuarterRound.append(matches[index])
                }
            }
            wFinalRound.append(matches[62])
            if matches[123].hasBye == 0{
                lSemiRound.append(matches[123])
            }
            lFinalRound.append(matches[124])
            grandFinalsRound.append(matches[125])
            grandFinalsRound.append(matches[126])
        }
        
        else if currentBracket?.bracketType == 8{
            //64-person SE
            for index in 0...31{
                if matches[index].hasBye == 0{
                    w1stRound.append(matches[index])
                }
            }
            for index in 32...47{
                if matches[index].hasBye == 0{
                    w2ndRound.append(matches[index])
                }
            }
            for index in 48...55{
                if matches[index].hasBye == 0{
                    w3rdRound.append(matches[index])
                }
            }
            for index in 56...59{
                if matches[index].hasBye == 0{
                    wQuarterRound.append(matches[index])
                }
            }
            for index in 60...61{
                if matches[index].hasBye == 0{
                    wSemiRound.append(matches[index])
                }
                else{
                    //do nothing
                }
            }
            wFinalRound.append(matches[62])
        }
        
        else if currentBracket?.bracketType == 9{
            //32-person DE
            for index in 0...31{
                if matches[index].hasBye == 0{
                    w1stRound.append(matches[index])
                }
            }
            for index in 32...47{
                if matches[index].hasBye == 0{
                    w2ndRound.append(matches[index])
                }
            }
            for index in 48...55{
                if matches[index].hasBye == 0{
                    w3rdRound.append(matches[index])
                }
            }
            for index in 56...59{
                if matches[index].hasBye == 0{
                    wQuarterRound.append(matches[index])
                }
            }
            for index in 60...61{
                if matches[index].hasBye == 0{
                    wSemiRound.append(matches[index])
                }
                else {
                    //do nothing
                }
            }
            for index in 63...78{
                if matches[index].hasBye == 0{
                    l1stRound.append(matches[index])
                }
            }
            for index in 79...94{
                if matches[index].hasBye == 0{
                    l2ndRound.append(matches[index])
                }
            }
            for index in 95...102{
                if matches[index].hasBye == 0{
                    l3rdRound.append(matches[index])
                }
            }
            for index in 103...110{
                if matches[index].hasBye == 0{
                    l4thRound.append(matches[index])
                }
            }
            for index in 111...114{
                if matches[index].hasBye == 0{
                    l5thRound.append(matches[index])
                }
            }
            for index in 115...118{
                if matches[index].hasBye == 0{
                    l6thRound.append(matches[index])
                }
            }
            for index in 119...120{
                if matches[index].hasBye == 0 {
                    l7thRound.append(matches[index])
                }
            }
            for index in 121...122{
                if matches[index].hasBye == 0{
                    lQuarterRound.append(matches[index])
                }
            }
            wFinalRound.append(matches[62])
            if matches[123].hasBye == 0{
                lSemiRound.append(matches[123])
            }
            lFinalRound.append(matches[124])
            grandFinalsRound.append(matches[125])
            grandFinalsRound.append(matches[126])
        }

        
    } //end function

    func getCellText(thisMatch: Match) -> String{
        var p1name: String?
        var p2name: String?
        var p1seed: Int?
        var p2seed: Int?
        if thisMatch.hasBye == 1{
            p1name = "TBD"
            p2name = thisMatch.player2!.name!
            p2seed = Int(thisMatch.player2!.seed!)
            return "\(p1name!) vs \(p2seed!): \(p2name!)"
        }
        else if thisMatch.hasBye == 2{
            p2name = "TBD"
            p1name = thisMatch.player1!.name!
            p1seed = Int(thisMatch.player1!.seed!)
            return "\(p1seed!): \(p1name!) vs \(p2name!)"
        }
        else if thisMatch.hasBye! == 0{
            if thisMatch.player1 == nil && thisMatch.player2 == nil {
                return "TBD vs TBD"
            }
            else if thisMatch.player1 != nil && thisMatch.player2 == nil{
                p2name = "TBD"
                p1name = thisMatch.player1!.name!
                p1seed = Int(thisMatch.player1!.seed!)
                return "\(p1seed!): \(p1name!) vs \(p2name!)"
            }
            else if thisMatch.player1 == nil && thisMatch.player2 != nil{
                p1name = "TBD"
                p2name = thisMatch.player2!.name!
                p2seed = Int(thisMatch.player2!.seed!)
                return "\(p1name!) vs \(p2seed!): \(p2name!)"
            }
            else{
                p1name = thisMatch.player1!.name!
                p1seed = Int(thisMatch.player1!.seed!)
                p2name = thisMatch.player2!.name!
                p2seed = Int(thisMatch.player2!.seed!)
                return "\(p1seed!): \(p1name!) vs \(p2seed!): \(p2name!)"
            }
        }
        else{
            return "Error asd"
        }

    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        globalMatch = matches[indexPath.row]
        
        var matchViewController: UIViewController!
        
        matchViewController = storyboard!.instantiateViewControllerWithIdentifier("MatchViewController") as! MatchViewController
        matchViewController = UINavigationController(rootViewController: matchViewController)
        self.slideMenuController()?.changeMainViewController(matchViewController, close: true)
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
