//
//  ResultsViewController.swift
//  Tournament Manager
//
//  Created by Ishin Iwasaki on 10/6/15.
//  Copyright © 2015 ABIITJ. All rights reserved.
//

import UIKit

class ResultsViewController: UIViewController, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.setNavigationBarItem()
        navigationItem.title = "Your Brackets"
        if (currentBracket == nil){
            navigationItem.title = "No Bracket Selected"
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "Cell")
        if currentBracket == nil{
            cell.textLabel!.text = "No bracket selected"
        }
        else {
            if currentBracket?.active != 2{
                cell.textLabel!.text = "Bracket is not finished."
            }
            else {
                let part = results[indexPath.row]
                let ranking = part.rank!
                let name = part.name!
                let winTotal = part.wins!
                let lossTotal = part.losses!
                cell.textLabel!.text = "\(ranking): \(name) W: \(winTotal) L: \(lossTotal)"
            }
        }
        return cell
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if currentBracket == nil {
            return 1
        }
        else{
            if currentBracket?.active != 2 {
                return 1
            }
            else {
                return results.count
            }
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

}
