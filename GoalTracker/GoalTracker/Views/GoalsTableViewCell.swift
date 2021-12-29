//
//  GoalsTableViewCell.swift
//  GoalTracker
//
//  Created by Maha S on 28/12/2021.
//

import UIKit


protocol GoalsTableViewCellDelegate: AnyObject {
  func goalsTableViewCell(_ cell: GoalsTableViewCell, didChagneCheckedState checked: Bool)
}

class GoalsTableViewCell: UITableViewCell {

  
  @IBOutlet weak var goalLabel: UILabel!
  @IBOutlet weak var checkBox: Checkbox!
  
  weak var delegate: GoalsTableViewCellDelegate?
  
  @IBAction func checked(_ sender: Checkbox) {
    updateChecked()
    delegate?.goalsTableViewCell(self, didChagneCheckedState: checkBox.checked)
  }
  
  func set(title: String, checked: Bool) {
    goalLabel.text = title
    set(checked: checked)
  }
  
  func set(checked: Bool) {
    checkBox.checked = checked
    updateChecked()
  }
  
  private func updateChecked() {
    let attributedString = NSMutableAttributedString(string: goalLabel.text!)
    
    if checkBox.checked {
      attributedString.addAttribute(.strikethroughStyle, value: 2, range: NSMakeRange(0, attributedString.length-1))
    } else {
      attributedString.removeAttribute(.strikethroughStyle, range: NSMakeRange(0, attributedString.length-1))
    }
    
    goalLabel.attributedText = attributedString
  }
}
   

