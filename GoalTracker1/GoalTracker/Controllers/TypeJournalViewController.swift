//
//  TypeJournalViewController.swift
//  GoalTracker
//
//  Created by Maha S on 20/12/2021.
//

import UIKit

class TypeJournalViewController: UIViewController {
  
  
  @IBOutlet weak var titleTextField: UITextField!
  @IBOutlet weak var journalTextField: UITextField!
  @IBOutlet weak var saveAction: UIButton!
  
  
    override func viewDidLoad() {
      super.viewDidLoad()
      setUpElement()
  }
  

  func setUpElement() {

          // style the elements
    Utilities.styleTextField(titleTextField)
//  Utilities.styleTextField(journalTextField)
    Utilities.styleFilledButton(saveAction)

  }
}
