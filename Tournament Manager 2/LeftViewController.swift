//
//  LeftViewController.swift
//  Tournament Manager
//
//  Created by Ishin Iwasaki on 10/6/15.
//  Copyright © 2015 ABIITJ. All rights reserved.
//

import UIKit

enum LeftMenu: Int {
    case Main = 0
    case Settings = 1
    case Add = 2
    case Bracket = 3 //dependent on bracket load
    case Results = 4 //dependent on bracket load
}

protocol LeftMenuProtocol : class {
    func changeViewController(menu: LeftMenu)
}

class LeftViewController : UIViewController, LeftMenuProtocol {
    
    @IBOutlet weak var tableView: UITableView!
    var menus = ["Home", "Settings", "Add Bracket", "Current Bracket", "Results"]
    var mainViewController: UIViewController!
    var settingsViewController: UIViewController!
    var addViewController: UIViewController!
    var bracketViewController: UIViewController!
    var resultsViewController: UIViewController!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {

        super.viewDidLoad()
        
        self.tableView.separatorColor = UIColor(red: 224/255, green: 224/255, blue: 224/255, alpha: 1.0)
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let mainViewController = storyboard.instantiateViewControllerWithIdentifier("ViewController") as! ViewController
        self.mainViewController = UINavigationController(rootViewController: mainViewController)
        
        let settingsViewController = storyboard.instantiateViewControllerWithIdentifier("SettingsViewController") as! SettingsViewController
        self.settingsViewController = UINavigationController(rootViewController: settingsViewController)
        
        let addViewController = storyboard.instantiateViewControllerWithIdentifier("AddViewController") as! AddViewController
        self.addViewController = UINavigationController(rootViewController: addViewController)
        
        let bracketViewController = storyboard.instantiateViewControllerWithIdentifier("BracketViewController") as! BracketViewController
        self.bracketViewController = UINavigationController(rootViewController: bracketViewController)
        
        let resultsViewController = storyboard.instantiateViewControllerWithIdentifier("ResultsViewController") as! ResultsViewController
        self.resultsViewController = UINavigationController(rootViewController: resultsViewController)
        
        self.tableView.registerCellClass(BaseTableViewCell.self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menus.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: BaseTableViewCell = BaseTableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: BaseTableViewCell.identifier)
        cell.backgroundColor = UIColor(red: 64/255, green: 170/255, blue: 239/255, alpha: 1.0)
        cell.textLabel?.font = UIFont.italicSystemFontOfSize(18)
        cell.textLabel?.textColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0)
        cell.textLabel?.text = menus[indexPath.row]
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if let menu = LeftMenu(rawValue: indexPath.item) {
            self.changeViewController(menu)
        }
    }
    
    func changeViewController(menu: LeftMenu) {
        switch menu {
        case .Main:
            self.slideMenuController()?.changeMainViewController(self.mainViewController, close: true)
        case .Settings:
            self.slideMenuController()?.changeMainViewController(self.settingsViewController, close: true)
            break
        case .Add:
            self.slideMenuController()?.changeMainViewController(self.addViewController, close: true)
            break
        case .Bracket:
            self.slideMenuController()?.changeMainViewController(self.bracketViewController, close: true)
            break
        case .Results:
            self.slideMenuController()?.changeMainViewController(self.resultsViewController, close: true)
            break
        default:
            break
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
