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
        
        if let ratingText = ratingField.text,
               let desc = descField.text,
               let rating = Int(ratingText) {
               
                // Memastikan rating berada dalam rentang 1-5
                if rating >= 1 && rating <= 5 {
                    // Membuat objek MakeupReview jika rating valid
                    let review = MakeupReview(userEmail: activeUser?.email!, productName: makeup?.name!, rating: String(rating), desc: desc)
                    
                    // Menyimpan review ke database (asumsikan db dan contxt sudah didefinisikan)
                    db.insertReview(contxt: contxt, review: review)
                    let alertController = UIAlertController(title: "OK", message: "Item has been added into the cart", preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                    alertController.addAction(okAction)
                    present(alertController, animated: true, completion: nil)
                    
                    
                } else {
                    // Menampilkan pesan kesalahan jika rating tidak valid
                    showAlert(title: "Error", message: "Rating harus berada dalam rentang 1-5.")
                }
            } else {
                // Menampilkan pesan kesalahan jika rating tidak berupa angka
                showAlert(title: "Error", message: "Rating harus berupa angka.")
            }
    }
    
    func showAlert(title:String,message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    

}
