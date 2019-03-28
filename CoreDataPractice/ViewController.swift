//
//  ViewController.swift
//  CoreDataPractice
//
//  Created by Prudhvi Gadiraju on 3/27/19.
//  Copyright © 2019 Prudhvi Gadiraju. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setupView()
        setupNavigationBar()
    }
    
    fileprivate func setupView() {
        view.backgroundColor = .white
    }
    
    fileprivate func setupNavigationBar() {
        let lightRed = UIColor(red: 247/255, green: 66/255, blue: 82/255, alpha: 1)
        
        navigationItem.title = "Title"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(handleAddCompanyButtonTapped))
        
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.barTintColor = lightRed
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    @objc
    func handleAddCompanyButtonTapped() {
        print("Tapped")
    }


}

