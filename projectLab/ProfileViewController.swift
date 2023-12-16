//
//  ProfileViewController.swift
//  projectLab
//
//  Created by prk on 15/12/23.
//

import UIKit
import CoreData


class ProfileViewController: UIViewController {
    
    
    @IBOutlet weak var usernameProfile: UILabel!
    
    @IBOutlet weak var emailProfile: UILabel!
    
    @IBOutlet weak var passwordProfile: UILabel!
    
    var activeUser:Person?
    var db = Database()
    var contxt: NSManagedObjectContext!

    override func viewDidLoad() {
        super.viewDidLoad()

        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        contxt = appDelegate.persistentContainer.viewContext
        
        let email = UserDefaults.standard.string(forKey: "userEmail")
        activeUser = db.getUser(contxt: contxt, email: email!)
        print(activeUser!.name)
        loadUserData()

    }
    
    func loadUserData(){
            usernameProfile.text = activeUser!.name!
            emailProfile.text = activeUser!.email!
            passwordProfile.text = activeUser!.pass!
            
        }
    
    @IBAction func onClikLogout(_ sender: Any) {
        
        UserDefaults.standard.removeObject(forKey: "userEmail")
        
        if let loginVC = storyboard?.instantiateViewController(withIdentifier: "LoginPage") {
            let loginView = loginVC as! ViewController
            navigationController?.setViewControllers([loginView], animated: true)
               }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
