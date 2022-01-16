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
  
  // MARK: - Methods
  
  weak var delegate: GoalsTableViewCellDelegate?
  
  // MARK: - IBOutlets
  
  @IBOutlet weak var goalLabel: UILabel!
  @IBOutlet weak var checkBox: Checkbox!
  @IBOutlet weak var dateLabel: UILabel!
  @IBOutlet weak var categoryLabel: UILabel!
  
  // MARK: - IBAction
  
  @IBAction func checked(_ sender: Checkbox) {
    updateChecked()
    delegate?.goalsTableViewCell(self, didChagneCheckedState: checkBox.checked)
  }
  
  // MARK: - Methods
  
  func set(title: String, checked: Bool, date: Double, category: String) {
    goalLabel.text = title
    dateLabel.text = "date"
    categoryLabel.text = category
    set(checked: checked)
  }
  
  func bind(_ goal: Goal) {
    goalLabel.text = goal.title
    dateLabel.text = goal.formattedDate
    categoryLabel.text = goal.category
    set(checked: goal.isComplete)
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


