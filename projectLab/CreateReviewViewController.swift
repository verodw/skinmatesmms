//
//  CreateReviewViewController.swift
//  projectLab
//
//  Created by prk on 18/12/23.
//

import UIKit
import CoreData

class CreateReviewViewController: UIViewController {
    
    var makeup:Makeup?
    var activeUser:Person?
    var db = Database()
    var contxt: NSManagedObjectContext!
    @IBOutlet weak var ratingField: UITextField!
    @IBOutlet weak var descField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // setup core data
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        contxt = appDelegate.persistentContainer.viewContext
        
        // Do any additional setup after loading the view.
        let email = UserDefaults.standard.string(forKey: "userEmail")
        activeUser = db.getUser(contxt: contxt, email: email!)
        print(makeup)
    }
    

    @IBAction func onPostClick(_ sender: Any) {
        
        let rating = ratingField.text
        let desc = descField.text
        
        let review = MakeupReview(userEmail: activeUser?.email!, productName: makeup?.name!, rating: rating, desc: desc)
        
        db.insertReview(contxt: contxt, review: review)
    }
    

}
