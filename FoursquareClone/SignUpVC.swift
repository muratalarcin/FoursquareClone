//
//  ViewController.swift
//  FoursquareClone
//
//  Created by Murat Alarcin on 4.03.2025.
//

import UIKit
import Parse

class SignUpVC: UIViewController {
    @IBOutlet weak var usernameText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
//        let parseObject = PFObject(className: "fruits")
//        parseObject["name"] = "Banana"
//        parseObject["calories"] = 150
//        parseObject.saveInBackground { success, error in
//            if (error != nil) {
//                print(error?.localizedDescription ?? "error")
//            } else {
//                print("succes")
//            }
//        }
        
//        let query = PFQuery(className: "fruits")
//        query.whereKey("name", contains: "Apple")
//        query.findObjectsInBackground { objects, error in
//            if (error != nil) {
//                print(error?.localizedDescription)
//            } else {
//                print(objects)
//            }
//        }
        
        
        
        
        
    }
    
    @IBAction func signInButton(_ sender: Any) {
        
        if(usernameText.text != "" && passwordText.text != "") {
            
            PFUser.logInWithUsername(inBackground: usernameText.text!, password: passwordText.text!) { user, error in
                if(error != nil) {
                    self.makeAlert(titleInput: "Error", messageInput: error?.localizedDescription ?? "Error")
                } else {
                    self.performSegue(withIdentifier: "toPlacesVC", sender: nil)
                }
            }
            
        } else {
            makeAlert(titleInput: "Error", messageInput: "Username or password is invalid")
        }
        
    }
    
    @IBAction func signUpButton(_ sender: Any) {
        
        if(usernameText.text != "" && passwordText.text != ""){
            
            let user = PFUser()
            user.username = usernameText.text
            user.password = passwordText.text
            user.signUpInBackground { success, error in
                if(error != nil) {
                    self.makeAlert(titleInput: "Error", messageInput: error?.localizedDescription ?? "Error")
                } else {
                    self.performSegue(withIdentifier: "toPlacesVC", sender: nil	)
                }
            }
            
        } else {
            makeAlert(titleInput: "Error", messageInput: "Username or password is invalid")
        }
        
    }
    
    func makeAlert(titleInput: String, messageInput: String){
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
    
}

