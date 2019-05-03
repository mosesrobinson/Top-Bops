//
//  AppearanceHelper.swift
//  TopBops
//
//  Created by Moses Robinson on 5/3/19.
//  Copyright © 2019 Moses Robinson. All rights reserved.
//

import UIKit

enum AppearanceHelper {
    
    // MARK: - Theme Colors
    
    static var paperWhite = UIColor(red:1.00, green:1.00, blue:1.00, alpha:1.00)
    static var softOrange = UIColor(red:0.84, green:0.25, blue:0.15, alpha:1.00)
    
    //MARK: - Theme Setup
    
    static func setAppearance() {
        UINavigationBar.appearance().barTintColor = softOrange
        UIBarButtonItem.appearance().tintColor = paperWhite
        
        let textAttributes = [NSAttributedString.Key.foregroundColor: paperWhite]
        
        UINavigationBar.appearance().titleTextAttributes = textAttributes
        UINavigationBar.appearance().largeTitleTextAttributes = textAttributes
    }
}
