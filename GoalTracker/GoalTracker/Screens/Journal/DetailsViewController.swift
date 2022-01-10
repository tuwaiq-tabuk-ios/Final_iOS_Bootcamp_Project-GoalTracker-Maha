//
//  DetailVC.swift
//  GoalTracker
//
//  Created by Maha S on 26/12/2021.
//

import UIKit

class DetailsViewController: UIViewController {
  
  var journal: Journal?
  
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var dateLabel: UILabel!
  @IBOutlet weak var bodyText: UITextView!
  

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    titleLabel.text = journal?.title
    bodyText.text = journal?.body
    if let timeInterval = journal?.date {
      let date = Date(timeIntervalSince1970: timeInterval)
      dateLabel.text = Formatter.mmmddYYYYDateFormatter.string(from: date)
    }
    
  }


  override func viewDidLoad() {
      super.viewDidLoad()
    bodyText.layer.cornerRadius = 10
    
    navigationItem.title = "Journals"
    navigationItem.largeTitleDisplayMode = .never
  }
}

