//
//  HomeViewController.swift
//  projectLab
//
//  Created by prk on 06/12/23.
//

import UIKit
import CoreData

class HomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var greetingLabel: UILabel!
    var activeUser:Person?
    var db = Database()
    var contxt: NSManagedObjectContext!
    
    var makeupList = [Makeup]()
    var makeup:Makeup?
    @IBOutlet weak var productTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // setup core data
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        contxt = appDelegate.persistentContainer.viewContext

        // Do any additional setup after loading the view.
        let email = UserDefaults.standard.string(forKey: "userEmail")
        activeUser = db.getUser(contxt: contxt, email: email!)
        print(activeUser!.name)
        greetingLabel.text = "Hello, \(activeUser!.name!)!"
        
        productTable.dataSource = self
        productTable.delegate = self
        
//        initData()
    }
    
//    func initData(){
//        makeupList = db.getProducts(contxt: contxt)
//    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        makeupList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "productCell") as! ProductTableViewCell
        cell.productName.text = makeupList[indexPath.row].name
        cell.productCategory.text = makeupList[indexPath.row].brand
        cell.productPrice.text = "Rp\(makeupList[indexPath.row].price!)"
        
        //
        if let imagePath = makeupList[indexPath.row].img, let image = UIImage(contentsOfFile: imagePath) {
               // Mengatur gambar pada UIImageView jika imagePath ada dan file gambar dapat dibaca
               cell.productImage.image = image
           } else {
               // Mengatur gambar default jika imagePath tidak ada atau file gambar tidak dapat dibaca
               cell.productImage.image = UIImage(named: "defaultImage")
           }
                
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        makeup = makeupList[indexPath.row]
        
        if let nextview = storyboard?.instantiateViewController(withIdentifier: "DetailPage") {
            let detailView = nextview as! DetailViewController

            detailView.makeup = makeup // atau tipe data dari variabelnya

            navigationController?.pushViewController(detailView, animated: true)
        }
    }

}
