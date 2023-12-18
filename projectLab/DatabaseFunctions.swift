//
//  DatabaseFunctions.swift
//  projectLab
//
//  Created by prk on 06/12/23.
//

import Foundation
import CoreData

class Database {
    
    func insertUser(contxt:NSManagedObjectContext, person:Person) {
        
        let entity = NSEntityDescription.entity(forEntityName: "User", in: contxt)
        
        let newPerson = NSManagedObject(entity: entity!, insertInto: contxt)
        newPerson.setValue(person.name, forKey: "name")
        newPerson.setValue(person.email, forKey: "email")
        newPerson.setValue(person.pass, forKey: "password")
        
        do {
            try contxt.save()
            getUsers(contxt:contxt)
        } catch {
            print("Entity creation failed")
        }
        
    }
    
    func getUsers(contxt:NSManagedObjectContext) {
        var userArr = [Person]()
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        
        do {
            let result = try contxt.fetch(request) as! [NSManagedObject]
            
            for data in result {
                userArr.append(
                    Person(name: data.value(forKey: "name") as! String, email: data.value(forKey: "email") as! String, pass: data.value(forKey: "password") as! String))
            }
            
            for i in userArr {
                print(i)
            }
            
        } catch {
            print("Data loading failure")
        }
    }
    
    func getUser(contxt:NSManagedObjectContext, email:String) -> Person{
        var person:Person?
        
        // check all user
        getUsers(contxt: contxt)
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        
        request.predicate = NSPredicate(format: "email=%@", email)
        
        do {
            let result = try contxt.fetch(request) as! [NSManagedObject]
            
            for data in result {
                person = Person(name: data.value(forKey: "name") as! String, email: data.value(forKey: "email") as! String, pass: data.value(forKey: "password") as! String)
            }
            
        } catch {
            print("Data loading failure")
        }
        
        return person ?? Person(name: nil, email: nil, pass: nil)
    }
    
    
    func insertProduct(contxt:NSManagedObjectContext, product:Makeup) {

        var makeupArr = [Makeup]()

        let entity = NSEntityDescription.entity(forEntityName: "Product", in: contxt)

        let newProduct = NSManagedObject(entity: entity!, insertInto: contxt)
        newProduct.setValue(product.name, forKey: "name")
        newProduct.setValue(product.brand, forKey: "brand")
        newProduct.setValue(product.price, forKey: "price")
        newProduct.setValue(product.type, forKey: "type")
        do {
            try contxt.save()
            makeupArr = getProducts(contxt:contxt)
        } catch {
            print("Entity creation failed")
        }
    }
    
    
    func getProducts(contxt:NSManagedObjectContext) -> [Makeup] {
        var makeupArr = [Makeup]()

        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Product")

        do {
            let result = try contxt.fetch(request) as! [NSManagedObject]

            for data in result {
                makeupArr.append(
                    Makeup(name: data.value(forKey: "name") as! String, brand: data.value(forKey: "brand") as! String, price: data.value(forKey: "price") as! String, type: data.value(forKey: "type") as! String))
            }

            for i in makeupArr {
                print(i)
            }

        } catch {
            print("Data loading failure")
        }

        return makeupArr
    }


    func getProductID(contxt:NSManagedObjectContext, name:String) -> Makeup{
//        var product:Makeup?
        var productID:UUID?

        // check all user
        getProducts(contxt: contxt)

        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Product")

        request.predicate = NSPredicate(format: "name=%@", name)

        do {
            let result = try contxt.fetch(request) as! [NSManagedObject]

            for data in result {
                productID = data.objectID
//                product = Makeup(name: data.value(forKey: "name") as! String, brand: data.value(forKey: "brand") as! String, price: data.value(forKey: "price") as! String, type: data.value(forKey: "type") as! String)
            }
            
        } catch {
            print("Data loading failure")
        }

//        return product ?? Makeup(name: nil, brand: nil, price: nil, type: nil)
        return productID ?? nil
    }
}
