//
//  ProductTableViewCell.swift
//  projectLab
//
//  Created by prk on 15/12/23.
//

import UIKit
import CoreData

class ProductTableViewCell: UITableViewCell {


    
    @IBOutlet weak var imageProduct: UIImageView!
    
    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var brand: UILabel!
    
    @IBOutlet weak var type: UILabel!
    
    @IBOutlet weak var price: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        
    }

}
