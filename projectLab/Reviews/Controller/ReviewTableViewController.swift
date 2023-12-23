//
//  ReviewTableViewController.swift
//  projectLab
//
//  Created by prk on 19/12/23.
//

import UIKit
import CoreData

class ReviewTableViewController: UITableViewController {
    
    var makeup:Makeup?
    var db = Database()
    var contxt: NSManagedObjectContext!
    
    var reviewList = [MakeupReview]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // setup core data
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        contxt = appDelegate.persistentContainer.viewContext
        reviewList = db.getReviewsByProduct(contxt: contxt, productName: (makeup?.name)!)
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reviewList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "productReviewCell", for: indexPath) as! ProductReviewTableViewCell

        let useremail = reviewList[indexPath.row].userEmail
        let username = db.getUser(contxt: contxt, email: useremail!).name
        let productname = reviewList[indexPath.row].productName
        let rating = reviewList[indexPath.row].rating
        let desc = reviewList[indexPath.row].desc
        
        cell.usernameLabel.text = username!
        cell.ratingLabel.text = rating!
        cell.descLabel.text = desc!

        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 350
    }

}
