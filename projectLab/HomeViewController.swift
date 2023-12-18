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
    
    // bentuk json = key : value
    var makeupList = [[String:Any]]()
    let baseURL = "https://makeup-api.herokuapp.com/api/v1/products.json?rating_greater_than=3.5&rating_less_than=5.0&price_greater_than=5.0"
    var makeup:Makeup?
    @IBOutlet weak var makeupTable: UITableView!
    
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
        
        makeupTable.dataSource = self
        makeupTable.delegate = self
        
        initData()
    }
    
    func initData(){
        // 1. Prepare URL
        let url = URL(string: "\(baseURL)")
        
        // 2. Prepare Request
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        
        // 3. Execute / Call Request
        URLSession.shared.dataTask(with: request) { data, response, error in
            if error != nil {
                print("Get ERROR.")
                return
            }
            
            // parse JSON
            do {
                let json = try JSONSerialization.jsonObject(with: data!) as! [[String:Any]]
                self.makeupList = json
                DispatchQueue.main.async {
                    self.makeupTable.reloadData()
                }
            }catch {
                
            }
        }.resume()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        makeupList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "productCell") as! ProductTableViewCell
        cell.name.text = makeupList[indexPath.row]["name"] as! String
        cell.brand.text = makeupList[indexPath.row]["brand"] as! String
        cell.type.text = makeupList[indexPath.row]["product_type"] as! String
        cell.price.text = "$\(makeupList[indexPath.row]["price"]!)" as! String
        
        //
        if let imagePath = makeupList[indexPath.row]["api_featured_image"], let image = UIImage(contentsOfFile: imagePath as! String) {
               // Mengatur gambar pada UIImageView jika imagePath ada dan file gambar dapat dibaca
               cell.imageProduct.image = image
           } else {
               // Mengatur gambar default jika imagePath tidak ada atau file gambar tidak dapat dibaca
               cell.imageProduct.image = UIImage(named: "defaultImage")
           }
                
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        makeup = Makeup(
            name: makeupList[indexPath.row]["name"] as! String,
            brand: makeupList[indexPath.row]["brand"] as! String,
            price: Double(makeupList[indexPath.row]["price"] as! String),
            type: makeupList[indexPath.row]["product_type"] as! String,
            img: makeupList[indexPath.row]["api_featured_image"] as! String
        )
        
        if let nextview = storyboard?.instantiateViewController(withIdentifier: "DetailPage") {
            let detailView = nextview as! DetailViewController

            detailView.makeup = makeup // atau tipe data dari variabelnya

            navigationController?.pushViewController(detailView, animated: true)
        }
    }

}
