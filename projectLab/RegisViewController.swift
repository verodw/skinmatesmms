//
//  RegisViewController.swift
//  projectLab
//
//  Created by prk on 02/12/23.
//

import UIKit
import CoreData

class RegisViewController: UIViewController {

    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passField: UITextField!
    @IBOutlet weak var confirmPassField: UITextField!
    
    var contxt: NSManagedObjectContext!
    var db=Database()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // setup core data
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        contxt = appDelegate.persistentContainer.viewContext
    }
    
    @IBAction func onRegisClick(_ sender: Any) {
        
        var newPerson: Person?
        
        // ambil dari text field
        let name = nameField.text!
        let email = emailField.text!
        let pass = passField.text!
        let confirmPass = confirmPassField.text!
        
        // validasi
        if(name=="" || email=="" || pass=="" || confirmPass==""){
            showAlert(msg: "All fields must be filled")
            return
        }
        
        else if (name.count < 3 ){
            showAlert(msg: "Name Should be more than 3 characters")
            return
        }
        
        else if(!(pass==confirmPass)){
            showAlert(msg: "Password and Confirm Password should be the same")
            return
        }
        
        else if (!(email.hasSuffix(".com")) || (!(email.contains("@")))){
            showAlert(msg: "Email should contain '@' and ends with .com")
            return
        }
        
        print(name, email, pass)
        
        newPerson = db.getUser(contxt: contxt, email: email)
        if(newPerson!.email != nil){
            showAlert(msg: "Email has been registered!\nHead to sign in")
        }
        
        newPerson = Person(name: name, email: email, pass: pass)
        
        db.insertUser(contxt:contxt, person:newPerson!)
     
        if let nextView = storyboard?.instantiateViewController(withIdentifier: "MainPage") {
                let mainPageView = nextView as! TabViewController
            
                // set user
                UserDefaults.standard.set(email, forKey: "userEmail")

                navigationController?.setViewControllers([mainPageView], animated: true)
        }
    }
        
        

    @IBAction func onLoginClick(_ sender: Any) {
        if let nextView = storyboard?.instantiateViewController(withIdentifier: "LoginPage") {
                let loginPageView = nextView as! ViewController

                navigationController?.setViewControllers([loginPageView], animated: true)
        }
    }
    
    
    func showAlert(msg:String){
        
        // define alert
        let alert = UIAlertController(title: "Register Failed", message: msg, preferredStyle: .alert)
        
        // define action
        let okAction = UIAlertAction(title: "OK", style: .cancel)
        
        // add action to alert
        alert.addAction(okAction)
        
        // show alert
        present(alert, animated: true)
    }
    
    
    //Keyboard Off
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

}
