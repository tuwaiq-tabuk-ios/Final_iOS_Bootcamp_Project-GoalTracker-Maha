//
//  CheckTableViewCell.swift
//  GoalTracker
//
//  Created by Maha S on 15/12/2021.
//

import UIKit


protocol CheckTableViewCellDelegate: AnyObject {
  func checkTableViewCell(_ cell: CheckTableViewCell, didChagneCheckedState checked: Bool)
}


class CheckTableViewCell: UITableViewCell {
  
  // MARK: - Properties
  
  weak var delegate: CheckTableViewCellDelegate?
  
  // MARK: - IBOutlets
  
  @IBOutlet weak var checkbox: Checkbox!
  @IBOutlet weak var label: UILabel!
  
  
  // MARK: - IBAction
  
  @IBAction func checked(_ sender: Checkbox) {
    updateChecked()
    delegate?.checkTableViewCell(self, didChagneCheckedState: checkbox.checked)
  }
  
  // MARK: - Methods
  
  func set(title: String, checked: Bool) {
    label.text = title
    set(checked: checked)
  }
  
  
  func set(checked: Bool) {
    checkbox.checked = checked
    updateChecked()
  }
  
  
  private func updateChecked() {
    let attributedString = NSMutableAttributedString(string: label.text!)
    
    if checkbox.checked {
      attributedString.addAttribute(.strikethroughStyle, value: 2, range: NSMakeRange(0, attributedString.length-1))
    } else {
      attributedString.removeAttribute(.strikethroughStyle, range: NSMakeRange(0, attributedString.length-1))
    }
    
    label.attributedText = attributedString
  }
}
