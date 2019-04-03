//
//  CreateCompanyVC.swift
//  CoreDataPractice
//
//  Created by Prudhvi Gadiraju on 3/28/19.
//  Copyright © 2019 Prudhvi Gadiraju. All rights reserved.
//

import UIKit
import CoreData

protocol CreateCompanyControllerDelegate {
    func didAddCompany(company: Company)
    func didEditCompany(company: Company)
}

class CreateCompanyVC: UIViewController {

    var delegate: CreateCompanyControllerDelegate?
    let nameLabel = UILabel()
    let nameTextField = UITextField()
    var company: Company? {
        didSet {
            nameTextField.text = company?.name
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupNavigationBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationItem.title = company == nil ? "Create Company" : "Edit Company"
    }
    
    fileprivate func setupView() {
        view.backgroundColor = .white
        
        setupNameLabel()
        setupNameTextField()
    }
    
    fileprivate func setupNavigationBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(handleCancelButtonTapped))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(handleSaveButtonTapped))
    }
    
    @objc
    fileprivate func handleCancelButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
    
    fileprivate func createCompany() {
        let context = CoreDataManager.shared.persistentContainer.viewContext
        let company = NSEntityDescription.insertNewObject(forEntityName: "Company", into: context)
        company.setValue(nameTextField.text, forKey: "name")
        
        do {
            try context.save()
            dismiss(animated: true, completion: {
                self.delegate?.didAddCompany(company: company as! Company)
            })
        } catch {
            print(error.localizedDescription)
        }
    }
    
    fileprivate func editCompany() {
        let context = CoreDataManager.shared.persistentContainer.viewContext
        company?.name = nameTextField.text
        
        do {
            try context.save()
            dismiss(animated: true, completion: {
                self.delegate?.didEditCompany(company: self.company!)
            })
        } catch {
            print(error.localizedDescription)
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    @objc
    fileprivate func handleSaveButtonTapped() {
        if company == nil {
            createCompany()
        } else {
            editCompany()
        }
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
