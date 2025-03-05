//
//  PlacesVC.swift
//  FoursquareClone
//
//  Created by Murat Alarcin on 4.03.2025.
//

import UIKit
import Parse

class PlacesVC: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(addButtonClicked))
        
        
        navigationController?.navigationBar.topItem?.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: UIBarButtonItem.Style.plain, target: self, action: #selector(logoutButtonClicked))
        
        
    }
    
    @objc func addButtonClicked() {
        
        performSegue(withIdentifier: "toAddPlaceVC", sender: nil)
        
        
    }
    
    
    @objc func logoutButtonClicked() {
        
        PFUser.logOutInBackground { error in
            if(error != nil) {
                let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default)
                alert.addAction(okButton)
                self.present(alert, animated: true)
            } else {
                self.performSegue(withIdentifier: "toSignUpVC", sender: nil)
            }
            
        }
        
    }
    
    
}
