//
//  PreferencesViewController.swift
//  Newsworthy
//
//  Created by Daniela Gonzalez on 6/6/19.
//  Copyright © 2019 Daniela Gonzalez. All rights reserved.
//

import UIKit

class PreferencesViewController : UIViewController {
    @IBOutlet weak var preferenceSlider: UISlider!
    
    @IBAction func sliderChanged(_ sender: Any) {
        if let tbc = self.tabBarController as? CustomTabController {
            tbc.preference = preferenceSlider.value
            print(tbc.preference)
        }
    }
}
