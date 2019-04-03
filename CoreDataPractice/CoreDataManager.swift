//
//  CoreDataManager.swift
//  CoreDataPractice
//
//  Created by Prudhvi Gadiraju on 4/3/19.
//  Copyright © 2019 Prudhvi Gadiraju. All rights reserved.
//

import CoreData

struct CoreDataManager {
    static let shared = CoreDataManager()
    
    let persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "CoreDataPractice")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error {
                fatalError("Failed to load Store: \(error)")
            }
        })
        return container
    }()
}
