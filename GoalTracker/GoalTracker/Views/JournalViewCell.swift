//
//  JournalViewCell.swift
//  GoalTracker
//
//  Created by Maha S on 01/01/2022.
//

import UIKit

class JournalViewCell: UITableViewCell {


  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var bodyLabel: UILabel!
  @IBOutlet weak var dateLabel: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    selectionStyle = .none
  }
}
