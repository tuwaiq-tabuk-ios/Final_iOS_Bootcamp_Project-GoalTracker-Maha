//
//  GoalsViewCell.swift
//  GoalTracker
//
//  Created by Maha S on 15/12/2021.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {
  
  // MARK: - IBOutlets
  
  @IBOutlet weak var goalImage: UIImageView!
  @IBOutlet weak var goalTitle: UILabel!
  
  // MARK: - View Controller Lifecycle
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    goalImage.contentMode = .scaleAspectFill
    goalImage.layer.masksToBounds = true
    goalImage.layer.cornerRadius = 20
    goalImage.layer.cornerCurve = .continuous
  }
  
  // MARK: - Methods
  
  func setup(with goal: Category) {
    goalImage.image = goal.image
    goalTitle.text = goal.title
  }
  
  
}
