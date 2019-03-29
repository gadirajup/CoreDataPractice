//
//  UINavigationController+theme.swift
//  CoreDataPractice
//
//  Created by Prudhvi Gadiraju on 3/28/19.
//  Copyright © 2019 Prudhvi Gadiraju. All rights reserved.
//

import UIKit

extension UINavigationController {
    func customNavSetup() {
        navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationBar.barTintColor = .lightRed
        navigationBar.tintColor = .white
        navigationBar.prefersLargeTitles = true
    }
}
