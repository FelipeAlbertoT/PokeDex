//
//  System.swift
//  PokeDex
//
//  Created by Felipe Treichel on 10/08/19.
//  Copyright © 2019 Felipe Treichel. All rights reserved.
//

import UIKit

struct System {
    static func clearNavigationBar(forBar navBar: UINavigationBar) {
        navBar.setBackgroundImage(UIImage(), for: .default)
        navBar.shadowImage = UIImage()
        navBar.isTranslucent = true
    }
    
    static func clearTabBar(forBar tabBar: UITabBar) {
        tabBar.backgroundImage = UIImage()
        tabBar.shadowImage = UIImage()
        tabBar.isTranslucent = true
    }
}
