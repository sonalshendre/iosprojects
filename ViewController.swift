//
//  ViewController.swift
//  loginAs
//
//  Created by user214291 on 2/4/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var email: [UILabel]!
    @IBOutlet weak var password: UILabel!
    @IBOutlet weak var enterEmail: UITextField!
    @IBOutlet weak var enterPassword: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    
    
    @IBAction func onClick(_ sender: Any) {
        UserDefaults.standard.set(enterEmail.text, forKey: "Key")
       let passw = enterPassword.text
        if(enterEmail.text == "sonal" && passw == "shendre" ){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
    
        guard let detailsVC = storyboard.instantiateViewController(identifier: "detailsViewController") as? DetailsViewController else {
            print("ViewController not found")
            return
            
        
        }
        self.navigationController?.pushViewController(detailsVC, animated: true)
        }
    }
    override func viewWillAppear(_ animated: Bool) {
     let st = UserDefaults.standard.string(forKey: "Key")
        enterEmail.text=st
       
    }
    
    /*@objc func addTapped()
    {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
    
        guard let detailsVC = storyboard.instantiateViewController(identifier: "detailsViewController") as? DetailsViewController else {
            print("ViewController not found")
            return
    }
    
        self.navigationController?.pushViewController(detailsVC, animated: true)
    }*/
        
    override func viewDidLoad() {
        super.viewDidLoad()
        //navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
        
       // navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(addTapped))
    }
        
}




