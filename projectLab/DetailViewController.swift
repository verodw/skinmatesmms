//
//  DetailViewController.swift
//  projectLab
//
//  Created by prk on 16/12/23.
//

import UIKit

class DetailViewController: UIViewController {
    
    var item:Item?
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if(item != nil){
            nameLabel.text = item!.name!
            categoryLabel.text = item!.category!
            priceLabel.text = "Rp\(item!.price!)"
        }
        
    }
    
    

}
