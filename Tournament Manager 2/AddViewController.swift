//
//  AddViewController.swift
//  Tournament Manager
//
//  Created by Ishin Iwasaki on 10/6/15.
//  Copyright © 2015 ABIITJ. All rights reserved.
//

import UIKit

class AddViewController: UIViewController {
    var mainViewController: UIViewController!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.setNavigationBarItem()
        navigationItem.title = "Add Bracket"
        let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.Plain, target: self, action: "cancelButton")
        navigationItem.leftBarButtonItem = cancelButton
    }
    
    
    func cancelButton(){
        let mainViewController = storyboard!.instantiateViewControllerWithIdentifier("ViewController") as! ViewController
        self.mainViewController = UINavigationController(rootViewController: mainViewController)
        self.slideMenuController()?.changeMainViewController(self.mainViewController, close: true)
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
