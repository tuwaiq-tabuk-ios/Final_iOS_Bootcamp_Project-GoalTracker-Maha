//
//  DetailVC.swift
//  GoalTracker
//
//  Created by Maha S on 26/12/2021.
//

import UIKit

class DetailsViewController: UIViewController {
  
  var titleText: String = ""
  var date: String = ""
  var body: String = ""

    
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var dateLabel: UILabel!
  @IBOutlet weak var bodyLabel: UILabel!
  
  override func viewWillAppear(_ animated: Bool) {
  
    }
  
  
  override func viewDidLoad() {
      super.viewDidLoad()
 
  }
  
}

