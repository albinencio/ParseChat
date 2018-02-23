//
//  ChatCell.swift
//  ParseChat
//
//  Created by Alberto on 2/21/18.
//  Copyright © 2018 Alberto Nencioni. All rights reserved.
//

import UIKit

class ChatCell: UITableViewCell {
  
  @IBOutlet weak var userLabel: UILabel!
  @IBOutlet weak var messageLabel: UILabel!
  @IBOutlet weak var bubbleView: UIView!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
    //bubbleView.layer.cornerRadius = 16
    //bubbleView.clipsToBounds = true
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    // Configure the view for the selected state
  }
  
}
