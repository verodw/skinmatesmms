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
    let baseURL = "https://makeup-api.herokuapp.com/api/v1/products.json?rating_greater_than=3.5&rating_less_than=4.5&price_greater_than=5.0"
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
                var dbJson =  self.db
                if(dbJson.getProducts(contxt: self.contxt).count==0){
                    print("masuk")
                    for makeup in self.makeupList {
                        print(makeup["brand"])
                        let name = makeup["name"] as! String
                        var brand = makeup["brand"] as? String
                        let price = makeup["price"] as! String
                        let type = makeup["product_type"] as! String
                        let image = makeup["api_featured_image"] as! String
                        // karena dalam api terdapat brand dengan nilai null, maka agar program tidak error saya set jadi string "null"
                        if(brand == nil){
                            brand = "Null"
                        }
                        var makeupItem = Makeup(name: name, brand: brand, price: price, type: type, img: image)
                        dbJson.insertProduct(contxt: self.contxt, product: makeupItem)
                        
                    }
                } 
            }catch {
                
            }
            
        }.resume()
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        makeupList.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "productCell") as! ProductTableViewCell
        cell.name.text = makeupList[indexPath.row]["name"] as! String
        cell.brand.text = makeupList[indexPath.row]["brand"] as? String
        cell.type.text = makeupList[indexPath.row]["product_type"] as! String
        cell.price.text = "$\(makeupList[indexPath.row]["price"]!)" as! String
        
        //
//        if let imagePath = makeupList[indexPath.row]["api_featured_image"], let image = UIImage(contentsOfFile: imagePath as! String) {
//               // Mengatur gambar pada UIImageView jika imagePath ada dan file gambar dapat dibaca
//               cell.imageProduct.image = image
//           } else {
//               // Mengatur gambar default jika imagePath tidak ada atau file gambar tidak dapat dibaca
//               cell.imageProduct.image = UIImage(named: "defaultImage")
//           }
        if let imagePath = makeupList[indexPath.row]["api_featured_image"] as? String {
            let imageUrlString = "https:" + imagePath
            if let imageUrl = URL(string: imageUrlString), let imageData = try? Data(contentsOf: imageUrl) {
                   let image = UIImage(data: imageData)
                   cell.imageProduct.image = image
               } else {
                   cell.imageProduct.image = UIImage(named: "defaultImage")
               }
           } else {
               cell.imageProduct.image = UIImage(named: "defaultImage")
           }
        
                
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let name = makeupList[indexPath.row]["name"] as! String
        var brand = makeupList[indexPath.row]["brand"] as? String
        let price = makeupList[indexPath.row]["price"] as! String
        let type = makeupList[indexPath.row]["product_type"] as! String
        let img = makeupList[indexPath.row]["api_featured_image"] as! String
        
        // karena dalam api terdapat brand dengan nilai null, maka agar program tidak error saya set jadi string "null"
        if(brand == nil){
            brand = "Null"
        }
        
        makeup = Makeup(
            name: name,
            brand: brand,
            price: price,
            type: type,
            img: img
        )
        
        if let nextview = storyboard?.instantiateViewController(withIdentifier: "DetailPage") {
            let detailView = nextview as! DetailViewController

            detailView.makeup = makeup

            navigationController?.pushViewController(detailView, animated: true)
        }
    }

}
