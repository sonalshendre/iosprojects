//
//  ShowTableViewController.swift
//  loginAs
//
//  Created by user214291 on 2/7/22.
//

import UIKit
import CoreData

class ShowTableViewController: ViewController,UITableViewDelegate, UITableViewDataSource{
    var data : [String?]=[]
    var peoples : [NSManagedObject] = []
    var a : String?
    var b : String?
    
    @IBOutlet weak var namelist2: UITableView!
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return peoples.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell { let cell = tableView.dequeueReusableCell(withIdentifier:"cellid", for: indexPath)
        // cell.textLabel?.text = data[indexPath.row]
         let person = peoples[indexPath.row]
             
             cell.textLabel?.text =
               person.value(forKeyPath: "bookName") as? String
         
         return cell
        
    }
  
    

    override func viewDidLoad() {
        super.viewDidLoad()
        namelist2.delegate=self
        namelist2.dataSource=self
        
        // Do any additional setup after loading the view.
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
