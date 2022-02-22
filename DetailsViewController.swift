//
//  DetailsViewController.swift
//  loginAs
//
//  Created by user214291 on 2/4/22.
//

import UIKit
import CoreData

class DetailsViewController: UIViewController , UITableViewDelegate , UITableViewDataSource{
    
   
    
    var data : [String?]=[]
    var people: [NSManagedObject] = []
    var a : String?
    var b : String?

    @IBOutlet weak var bookLable: UILabel!
    @IBOutlet weak var bookText: UITextField!
    @IBOutlet weak var authorLable: UILabel!
    @IBOutlet weak var authortext: UITextField!
    @IBOutlet weak var bookButton: UIButton!
    @IBOutlet weak var namelist: UITableView!
    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
       super.viewDidLoad()
        namelist.delegate=self
        namelist.dataSource=self
      // url()

       // Do any additional setup after loading the view.
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(addTapped))
        
    }
   
    @IBAction func onClick(_ sender: Any) {
        
            a = bookText.text
            b =  authortext.text
            data.append(a)
           data.append(b)
            namelist.reloadData()
        bookText.text = ""
        authortext.text=""
        if let value = a , let value2 = b{
           save (bookName: value, author: value2)
                getValue()
            }

    }
    /*func url()
    {
        let sharedSession = URLSession.shared

           if let url = URL(string: "https://goo.gl/wV9G4I") {
               // Create Request
               let request = URLRequest(url: url)

               // Create Data Task
               let dataTask = sharedSession.dataTask(with: request, completionHandler: { (data, response, error) -> Void in
                   if let data = data, let image = UIImage(data: data) {
                       DispatchQueue.main.async {
                           //self.imageView.image = image
                       }
                   }
               })

               dataTask.resume()
           
    }*/
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return people.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier:"Cellid", for: indexPath)
           // cell.textLabel?.text = data[indexPath.row]
            let person = people[indexPath.row]
                
                cell.textLabel?.text =
                  person.value(forKeyPath: "bookName") as? String
            
            return cell
        }
    @objc func addTapped()
    {
        let storyboard = UIStoryboard(name: "DetialsViewController", bundle: nil)
    
        guard let showsVC = storyboard.instantiateViewController(identifier: "showTableViewController") as? ShowTableViewController else {
            print("ViewController not found")
            return
    }
    
        self.navigationController?.pushViewController(showsVC, animated: true)
    }
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return.delete
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            tableView.beginUpdates()
            people.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.endUpdates()
        }
    }
    
        func save(bookName:String ,author:String) {
      
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
      person.setValue(bookName, forKeyPath: "bookName")
        person.setValue(author, forKeyPath: "author")
      
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
    override func viewWillAppear(_ animated: Bool) {
        getValue()
    }
    
}
/*queue = NSOperationQueue()

    queue.addOperationWithBlock { () -> Void in
        
        let img1 = Downloader.downloadImageWithURL(imageURLs[0])

        NSOperationQueue.mainQueue().addOperationWithBlock({
            self.imageView1.image = img1
        })
    }*/
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


