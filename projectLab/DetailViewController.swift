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
    @IBOutlet weak var categoryLabel: UILabel! // ini masih belum dihapus connection & dihubungin lagi
    @IBOutlet weak var priceLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if(makeup != nil){
            nameLabel.text = makeup!.name!
            categoryLabel.text = makeup!.brand! // masi perlu edit
            priceLabel.text = "Rp\(makeup!.price!)"
        }
        
    }
    
    

}
