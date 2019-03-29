//
//  CreateCompanyVC.swift
//  CoreDataPractice
//
//  Created by Prudhvi Gadiraju on 3/28/19.
//  Copyright © 2019 Prudhvi Gadiraju. All rights reserved.
//

import UIKit

protocol CreateCompanyControllerDelegate {
    func didAddCompany(company: Company)
}

class CreateCompanyVC: UIViewController {

    var delegate: CreateCompanyControllerDelegate?
    let nameLabel = UILabel()
    let nameTextField = UITextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupNavigationBar()
    }
    
    fileprivate func setupView() {
        view.backgroundColor = .white
        
        setupNameLabel()
        setupNameTextField()
    }
    
    fileprivate func setupNavigationBar() {
        navigationItem.title = "Create Company"
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(handleCancelButtonTapped))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(handleSaveButtonTapped))
    }
    
    @objc
    fileprivate func handleCancelButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc
    fileprivate func handleSaveButtonTapped() {
        dismiss(animated: true, completion: {
            let company = Company(name: self.nameTextField.text ?? " ", founded: Date())
            self.delegate?.didAddCompany(company: company)
        })
    }
}


extension CreateCompanyVC {
    fileprivate func setupNameLabel() {
        nameLabel.text = "Name: "
        nameLabel.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        
        view.addSubview(nameLabel)
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        nameLabel.widthAnchor.constraint(equalToConstant: 50).isActive = true
        nameLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    fileprivate func setupNameTextField() {
        nameTextField.placeholder = "Enter name"
        nameTextField.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        
        view.addSubview(nameTextField)
        
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        nameTextField.centerYAnchor.constraint(equalTo: nameLabel.centerYAnchor, constant: 0).isActive = true
        nameTextField.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor, constant: 8).isActive = true
        nameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 16).isActive = true
        nameTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
}
