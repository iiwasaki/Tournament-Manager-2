//
//  UIViewControllerExtension.swift
//  Tournament Manager
//
//  Created by Yuji Hato on 1/19/15.
//  Copyright (c) 2015 Yuji Hato. All rights reserved.
//
// Modified by Ishin Iwasaki for project purposes
//

import UIKit

extension UIViewController {
    
    func setNavigationBarItem() {
        self.addLeftBarButtonWithImage(UIImage(named: "ic_menu_black_24dp")!)
        self.slideMenuController()?.removeLeftGestures()
        self.slideMenuController()?.addLeftGestures()
    }
    
    func removeNavigationBarItem() {
        self.navigationItem.leftBarButtonItem = nil
        self.slideMenuController()?.removeLeftGestures()
    }
}