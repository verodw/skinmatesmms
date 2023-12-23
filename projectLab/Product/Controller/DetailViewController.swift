//
//  DetailViewController.swift
//  projectLab
//
//  Created by prk on 16/12/23.
//

import UIKit

class DetailViewController: UIViewController {
    
    var makeup:Makeup?
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var brandLabel: UILabel!
    
    @IBOutlet weak var typeLabel: UILabel!
    
    @IBOutlet weak var priceLabel: UILabel!
    
    @IBOutlet weak var makeupImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let makeup = makeup {
            nameLabel.text = makeup.name!
            brandLabel.text = makeup.brand!
            typeLabel.text = makeup.type!
            
            if let price = makeup.price {
                        priceLabel.text = "$\(price)"
                    } else {
                        priceLabel.text = "Price not available"
                    }
            
            if var imageURLString = makeup.img, !imageURLString.isEmpty {
                
                if !imageURLString.lowercased().hasPrefix("https:") {
                    imageURLString = "https:" + imageURLString
                }
                
                if let imageURL = URL(string: imageURLString) {
                    DispatchQueue.global().async {
                        if let imageData = try? Data(contentsOf: imageURL),
                           let image = UIImage(data: imageData) {
                            DispatchQueue.main.async {
                                self.makeupImageView.image = image
                            }
                        }
                    }
                    print("Image URL: \(imageURLString)")
                } else {
                    makeupImageView.image = UIImage(named: "defaultImage")
                }
            }
        }
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "createReviewSegue" {
                if let nextPage = segue.destination as? CreateReviewViewController {
                    nextPage.makeup = makeup
            }
        }
        else if segue.identifier == "showReviewSegue" {
                if let nextPage = segue.destination as? ReviewTableViewController {
                    nextPage.makeup = makeup
            }
        }
    }

}
