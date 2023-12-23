//
//  UserReviewsViewController.swift
//  projectLab
//
//  Created by prk on 19/12/23.
//

import UIKit
import CoreData

class UserReviewsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var activeUser:Person?
    var reviewList = [MakeupReview]()
    var db = Database()
    var contxt: NSManagedObjectContext!
    @IBOutlet weak var userReviewsTable: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // setup core data
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        contxt = appDelegate.persistentContainer.viewContext

        userReviewsTable.dataSource = self
        userReviewsTable.delegate = self
        
        let email = UserDefaults.standard.string(forKey: "userEmail")
        
        // Do any additional setup after loading the view.
        reviewList = db.getReviewsByUser(contxt: contxt, userEmail: email!)
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reviewList.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 190
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "userCell") as! UserReviewTableViewCell
        
        let productName = reviewList[indexPath.row].productName
        let product = db.getProduct(contxt: contxt, name: productName!)
        let rating = reviewList[indexPath.row].rating
        let desc = reviewList[indexPath.row].desc
        let image = db.getProduct(contxt: contxt, name: productName!).img
        print(image)
        
        cell.productName.text = productName!
        cell.brand.text = product.brand!
        cell.rating.text = rating!
        cell.desc.text = desc!
        
        if let imagePath = image as? String {
            let imageUrlString = "https:" + imagePath
            if let imageUrl = URL(string: imageUrlString), let imageData = try? Data(contentsOf: imageUrl) {
                   let image = UIImage(data: imageData)
                cell.productImage.image = image
               } else {
                   cell.productImage.image = UIImage(named: "defaultImage")
               }
           } else {
               cell.productImage.image = UIImage(named: "defaultImage")
           }
        
        return cell
    }
    

}
