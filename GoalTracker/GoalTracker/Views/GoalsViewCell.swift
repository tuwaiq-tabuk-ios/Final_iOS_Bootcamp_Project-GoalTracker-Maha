//
//  GoalsViewCell.swift
//  GoalTracker
//
//  Created by Maha S on 15/12/2021.
//

import UIKit

class GoalsViewCell: UICollectionViewCell {

  
  @IBOutlet weak var goalImage: UIImageView!
  @IBOutlet weak var goalTitle: UILabel!
  
    override func awakeFromNib() {
        super.awakeFromNib()
      
      goalTitle.layer.cornerRadius = 10
    
      
    }
  
  func setup(with goal: Goal) {
    goalImage.image = goal.image
    goalTitle.text = goal.title
  }


}
