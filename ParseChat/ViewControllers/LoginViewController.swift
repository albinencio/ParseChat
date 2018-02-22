//
//  LoginViewController.swift
//  ParseChat
//
//  Created by Alberto on 2/21/18.
//  Copyright © 2018 Alberto Nencioni. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {
  
  @IBOutlet weak var usernameField: UITextField!
  @IBOutlet weak var passwordField: UITextField!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  @IBAction func onSignUp(_ sender: Any) {
    let newUser = PFUser()
    
    if ((usernameField.text?.isEmpty)! || (passwordField.text?.isEmpty)!) {
      let alertController = UIAlertController(title: "Empty Field", message: "Please enter username and password", preferredStyle: .alert)
      let OKAction = UIAlertAction(title: "OK", style: .default, handler: { (action) in
        return
      })
      alertController.addAction(OKAction)
      
      self.present(alertController, animated: true, completion: {
        return
      })
    }
    
    if (!(usernameField.text?.isEmpty)!) {
      newUser.username = usernameField.text
    }
    
    if (!(passwordField.text?.isEmpty)!) {
      newUser.password = passwordField.text
    }
    
    newUser.signUpInBackground { (success, error) in
      if success {
        // Signup successful
        self.performSegue(withIdentifier: "loginSegue", sender: nil)
      } else {
        print(error?.localizedDescription ?? "Error instance is nil")
        
        // Handle different error codes
        let code = error?._code
        switch code {
          
        // Username already exists
        case 202?:
          let alertController = UIAlertController(title: "Username Taken", message: "Please choose another username", preferredStyle: .alert)
          let OKAction = UIAlertAction(title: "OK", style: .default, handler: { (action) in
            return
          })
          alertController.addAction(OKAction)
          self.present(alertController, animated: true, completion: {
            return
          })
          break
          
        default:
          break
        }
      }
    }
  }
  
  @IBAction func onLogIn(_ sender: Any) {
    if (!(usernameField.text?.isEmpty)! && !(passwordField.text?.isEmpty)!) {
      PFUser.logInWithUsername(inBackground: usernameField.text!, password: passwordField.text!, block: { (user, error) in
        if user != nil {
          // Login successful
          self.performSegue(withIdentifier: "loginSegue", sender: nil)
        } else {
          print(error?.localizedDescription ?? "Error instance is nil")
          
          // Handle different error codes
          let code = error?._code
          switch code {
            
          // Username already exists
          case 101?:
            let alertController = UIAlertController(title: "Invalid username/password", message: "Please insert correct fields", preferredStyle: .alert)
            let OKAction = UIAlertAction(title: "OK", style: .default, handler: { (action) in
              return
            })
            alertController.addAction(OKAction)
            self.present(alertController, animated: true, completion: {
              return
            })
            break
            
          default:
            break
          }
        }
      })
    }
  }
  
}
