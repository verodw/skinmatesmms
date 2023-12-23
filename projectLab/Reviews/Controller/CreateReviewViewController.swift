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
        
        let email = UserDefaults.standard.string(forKey: "userEmail")
        activeUser = db.getUser(contxt: contxt, email: email!)
        print(makeup)
    }
    

    @IBAction func onPostClick(_ sender: Any) {
        
        if let ratingText = ratingField.text,
               let desc = descField.text,
               let rating = Double(ratingText) {
               
                // Memastikan rating berada dalam rentang 1-5
                if rating >= 1 && rating <= 5 {
                    // Membuat objek MakeupReview jika rating valid
                    let review = MakeupReview(userEmail: activeUser?.email!, productName: makeup?.name!, rating: String(rating), desc: desc)
                    
                    let reviewFound = db.getReviewsByUserAndProduct(contxt: contxt, newReview: review)
                    
                    if (reviewFound.productName != nil){
                        // update review yang pernah di post sebelumnya
                        print("masuk update")
                        db.updateReview(contxt: contxt, newReview: review)
                        showAlertSuccess(message: "Your review has been updated!")
                    }
                    else {
                        // Menyimpan review ke database
                        print("masuk insert")
                        db.insertReview(contxt: contxt, review: review)
                        showAlertSuccess(message: "Your review has been added!")
                    }
                    
                } else {
                    // Menampilkan pesan kesalahan jika rating tidak valid
                    showAlertError(message: "Rating must number be from 1-5.")
                }
            } else {
                // Menampilkan pesan kesalahan jika rating tidak berupa angka
                showAlertError(message:"Rating must be a number.")
            }
    }
    
    func showAlertSuccess(message: String) {
        let alertController = UIAlertController(title: "Success", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: {_ in
            if let nextView = self.storyboard?.instantiateViewController(withIdentifier: "MainPage") {
                    let mainPageView = nextView as! TabViewController

                self.navigationController?.setViewControllers([mainPageView], animated: true)
            }
        })
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    
    func showAlertError(message: String){
        let alertController = UIAlertController(title: "Success", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    

}
