//
//  ViewController.swift
//  projectLab
//
//  Created by prk on 18/11/23.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    @IBOutlet weak var emailFieldLogin: UITextField!
    @IBOutlet weak var passFieldLogin: UITextField!
    
    var contxt: NSManagedObjectContext!
    var db=Database()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // setup core data
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        contxt = appDelegate.persistentContainer.viewContext
    }
    
    @IBAction func onLoginClick(_ sender: Any) {
        
        let emailTxtRegist = emailFieldLogin.text
        let passTxtRegist = passFieldLogin.text
        
        print("login pressed!")
        
        // validasi
        if(emailTxtRegist=="" || passTxtRegist==""){
            showAlert(msg: "All fields must be filled")
            return
        }
        
        var checkPerson:Person?
        checkPerson = db.getUser(contxt: contxt, email: emailTxtRegist!)
        
        if (checkPerson!.email == nil){
            showAlert(msg: "Email is invalid")
            return
        }
        else if (checkPerson!.pass != passTxtRegist){
            showAlert(msg: "Password is invalid")
            return
        }
        
        if let nextView = storyboard?.instantiateViewController(withIdentifier: "MainPage") {
                let mainPageView = nextView as! TabViewController
            
                // set user
                UserDefaults.standard.set(checkPerson!.email, forKey: "userEmail")

                navigationController?.setViewControllers([mainPageView], animated: true)
        }


    }
    
    @IBAction func onRegisClick(_ sender: Any) {
        if let nextView = storyboard?.instantiateViewController(withIdentifier: "RegisterPage") {
                let regisPageView = nextView as! RegisViewController

                navigationController?.setViewControllers([regisPageView], animated: true)
        }
    }
    
    
    func showAlert(msg:String){
        
        let alert = UIAlertController(title: "Login Failed", message: msg, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .cancel)
        
        alert.addAction(okAction)
        
        present(alert, animated: true)
    }
    
    
    //Keyboard Off
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
}

