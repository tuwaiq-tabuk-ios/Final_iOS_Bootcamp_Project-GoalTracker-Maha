//
//  GoalsViewCell.swift
//  GoalTracker
//
//  Created by Maha S on 15/12/2021.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {

  
  @IBOutlet weak var goalImage: UIImageView!
  @IBOutlet weak var goalTitle: UILabel!
  
    override func awakeFromNib() {
        super.awakeFromNib()
      
      goalImage.layer.cornerRadius = 20
      
    }
  
  func setup(with goal: Category) {
    goalImage.image = goal.image
    goalTitle.text = goal.title
  }


}
