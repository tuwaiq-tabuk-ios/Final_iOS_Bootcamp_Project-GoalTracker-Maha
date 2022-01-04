//
//  DetailVC.swift
//  GoalTracker
//
//  Created by Maha S on 26/12/2021.
//

import UIKit

class DetailsViewController: UIViewController {

  var titleText: String?
  var date: String?
  var body: String?
  
  var journal: Journal?
  
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var dateLabel: UILabel!
  @IBOutlet weak var bodyLabel: UILabel!
  

  override func viewWillAppear(_ animated: Bool) {
    titleLabel.text = titleText
    dateLabel.text = date
    bodyLabel.text = body

    }


  override func viewDidLoad() {
      super.viewDidLoad()
    
    navigationItem.title = "Journals"
    navigationItem.largeTitleDisplayMode = .never
  }
}

