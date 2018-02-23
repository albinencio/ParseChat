//
//  ChatViewController.swift
//  ParseChat
//
//  Created by Alberto on 2/21/18.
//  Copyright © 2018 Alberto Nencioni. All rights reserved.
//

import UIKit
import Parse

class ChatViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
  
  @IBOutlet weak var messageField: UITextField!
  @IBOutlet weak var tableView: UITableView!
  
  var messages: [PFObject] = []
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    tableView.delegate = self
    tableView.rowHeight = UITableViewAutomaticDimension
    tableView.estimatedRowHeight = 50
    
    _ = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.refreshOnTimer), userInfo: nil, repeats: true)
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  @IBAction func onSend(_ sender: Any) {
    let chatMessage = PFObject(className: "Message")
    chatMessage["text"] = messageField.text ?? ""
    
    chatMessage.saveInBackground { (success, error) in
      if success {
        print("Message saved successfully")
        self.messageField.text = "" // Clear field
      } else {
        print(error?.localizedDescription ?? "Error instance was nil")
      }
    }
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return messages.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "ChatCell", for: indexPath) as! ChatCell
    let message = messages[indexPath.row]
    let text = message["text"] as! String
    cell.messageLabel.text = text
    return cell
  }
  
  @objc func refreshOnTimer() {
    let query = PFQuery(className: "Message")
    query.addDescendingOrder("createdAt")
    query.findObjectsInBackground { (objects, error) in
      if error == nil {
        if let objects = objects {
          self.messages = objects
          self.tableView.reloadData()
        }
      } else {
        print(error?.localizedDescription ?? "Error instance was nil")
      }
    }
  }
  
}
