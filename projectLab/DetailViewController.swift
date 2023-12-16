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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if(makeup != nil){
            nameLabel.text = makeup!.name!
            brandLabel.text = makeup!.brand!
            typeLabel.text = makeup!.type!
            priceLabel.text = "$\(makeup!.price!)"
        }
        
    }
    
    

}
