//
//  ViewController.swift
//  Contacts
//
//  Created by user214291 on 2/3/22.
//

import UIKit
import CoreData

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    var data : [String?]=[]
    var people: [NSManagedObject] = []
    var a : String?
    @IBOutlet weak var namelist: UITableView!
    @IBOutlet weak var textView: UITextField!
    @IBOutlet weak var buttonLable: UIButton!
    @IBAction func buttAction(_ sender: Any) {
        a = textView.text
        data.append(a)
        namelist.reloadData()
        textView.text = ""
        if let value = a{
            save(name: value)
            getValue()
        }
        
        
    }
   @objc func addTapped()
    {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
    
        guard let detailsVC = storyboard.instantiateViewController(identifier: "detailsViewController") as? DetailsViewController else {
            print("ViewController not found")
            return
        }
        self.navigationController?.pushViewController(detailsVC, animated: true)
    }
    override func viewWillAppear(_ animated: Bool) {
        getValue()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        namelist.delegate=self
        namelist.dataSource=self
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(addTapped))
    }

    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       // return data.count
        return people.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:"cellid", for: indexPath)
       // cell.textLabel?.text = data[indexPath.row]
        let person = people[indexPath.row]
            
            cell.textLabel?.text =
              person.value(forKeyPath: "name") as? String
        
        return cell
    }
    
    func save(name: String) {
      
      guard let appDelegate =
        UIApplication.shared.delegate as? AppDelegate else {
        return
      }
      
      // 1
      let managedContext =
        appDelegate.persistentContainer.viewContext
      
      // 2
      let entity =
        NSEntityDescription.entity(forEntityName: "Entity",
                                   in: managedContext)!
      
      let person = NSManagedObject(entity: entity,
                                   insertInto: managedContext)
      
      // 3
      person.setValue(name, forKeyPath: "name")
        person.setValue(10, forKeyPath: "rollno")
      
      // 4
      do {
        try managedContext.save()
        //people.append(person)
      } catch let error as NSError {
        print("Could not save. \(error), \(error.userInfo)")
      }
    }
    func getValue(){
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
              return
          }
          
          let managedContext =
            appDelegate.persistentContainer.viewContext
          
          //2
          let fetchRequest =
            NSFetchRequest<NSManagedObject>(entityName: "Entity")
          
          //3
          do {
            people = try managedContext.fetch(fetchRequest)
              namelist.reloadData()
          } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
          }
    }
    
    
   

}

