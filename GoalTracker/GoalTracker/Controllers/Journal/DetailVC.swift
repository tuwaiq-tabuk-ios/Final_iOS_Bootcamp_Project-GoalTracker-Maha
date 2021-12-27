//
//  DetailVC.swift
//  GoalTracker
//
//  Created by Maha S on 26/12/2021.
//

import UIKit

class DetailVC: UIViewController {
  
  
  
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var dateLabel: UILabel!
  @IBOutlet weak var bodyLabel: UILabel!
  
  var titleText: String = ""
  
  
  override func viewWillAppear(_ animated: Bool) {
      titleLabel.text = titleText
    }
  
  
  override func viewDidLoad() {
      super.viewDidLoad()
  
    }
  
}
