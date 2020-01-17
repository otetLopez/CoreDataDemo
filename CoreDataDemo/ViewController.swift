//
//  ViewController.swift
//  CoreDataDemo
//
//  Created by otet_tud on 1/16/20.
//  Copyright © 2020 otet_tud. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let appleDelegate = UIApplication.shared.delegate as! AppDelegate
        
        // We need the context.  This context is the manager like location manager, audio manager
        let context = appleDelegate.persistentContainer.viewContext
        
        // Write into context
        let newUser = NSEntityDescription.insertNewObject(forEntityName: "User", into: context)
        newUser.setValue("Ciri", forKey: "name")
        newUser.setValue(1234509876, forKey: "phone")
        newUser.setValue("email2@email.ca", forKey: "email")
        newUser.setValue(100, forKey: "age")
        
        // Save the context
        do {
            try context.save()
            print(newUser, " is saved")
        } catch {
            print(error)
        }
        
        
        // Fetch data and load it
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        do {
            let results = try context.fetch(request)
            if results.count > 0 {
                for idx in results as! [NSManagedObject] {
                    if let name = idx.value(forKey: "name") {
                        print(name)
                    }
                }
            }
        } catch { print(error) }
        
        // Search, fetch data and load it : NAME
        let searchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        // Helps filter the query
        searchRequest.predicate = NSPredicate(format: "name=%@", "Coco")
        searchRequest.returnsObjectsAsFaults = false
        do {
            let results = try context.fetch(searchRequest)
            if results.count > 0 {
                for idx in results as! [NSManagedObject] {
                    if let name = idx.value(forKey: "name") {
                        print(name)
                    }
                }
            }
        } catch { print(error) }
    
       // Search, fetch data and load it : EMAIL
        let searchRequestEmail = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        // Helps filter the query
        searchRequestEmail.predicate = NSPredicate(format: "email contains %@", "email.ca")
        searchRequestEmail.returnsObjectsAsFaults = false
        do {
            let results = try context.fetch(searchRequestEmail)
            if results.count > 0 {
                for idx in results as! [NSManagedObject] {
                    if let email = idx.value(forKey: "email") {
                        print(email)
                    }
                }
            }
        } catch { print(error) }
        
        // Update data
         let updateEmail = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
         // Helps filter the query
         updateEmail.predicate = NSPredicate(format: "email contains %@", "email.ca")
         updateEmail.returnsObjectsAsFaults = false
         do {
             let results = try context.fetch(updateEmail)
             if results.count > 0 {
                 for idx in results as! [NSManagedObject] {
                     if let email = idx.value(forKey: "email") {
                        print(email)
                        let email = email as! String
                        idx.setValue(String(email.dropLast(2)) + "com", forKey: "email")
                        do {
                            try context.save()
                          } catch {
                            print(error)
                          }
                     }
                 }
            
             }
         } catch { print(error) }
        
        //Print all emails
        let searchRequestAllEmail = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        // Helps filter the query
       // searchRequestAllEmail.predicate = NSPredicate(format: "email=%@", "")
        do {
            let results = try context.fetch(searchRequestAllEmail)
            if results.count > 0 {
                for idx in results as! [NSManagedObject] {
                    if let email = idx.value(forKey: "email") {
                        print("Updated ", email)
                    }
                }
            }
        } catch { print(error) }
        
        
        // Delete data  : NAME
        let deleteRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        // Helps filter the query
        deleteRequest.predicate = NSPredicate(format: "name=%@", "Coco")
        deleteRequest.returnsObjectsAsFaults = false
        do {
            let results = try context.fetch(searchRequest)
            if results.count > 0 {
                for idx in results as! [NSManagedObject] {
//                    if let name = idx.value(forKey: "name") {
//                        print(name)
//                    }
                    // Delete the user or entity
                    if let name = idx.value(forKey: "name") as? String {
                        context.delete(idx)
                        do {
                            try context.save()
                        } catch { print(error) }
                        print(name)
                    }
                    
                }
            }
        } catch { print(error) }
        

        
    }
}

