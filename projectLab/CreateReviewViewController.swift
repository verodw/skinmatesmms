//
//  CreateReviewViewController.swift
//  projectLab
//
//  Created by prk on 18/12/23.
//

import UIKit

class CreateReviewViewController: UIViewController {
    
    var makeup:Makeup?
    @IBOutlet weak var ratingField: UITextField!
    @IBOutlet weak var descField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        print(makeup)
    }
    

    @IBAction func onPostClick(_ sender: Any) {
        
    }
    

}
