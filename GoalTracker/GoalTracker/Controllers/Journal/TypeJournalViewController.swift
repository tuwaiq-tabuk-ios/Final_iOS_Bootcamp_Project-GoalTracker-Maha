//
//  TypeJournalViewController.swift
//  GoalTracker
//
//  Created by Maha S on 20/12/2021.
//

import UIKit

class TypeJournalViewController: UIViewController {
  
  
  @IBOutlet weak var titleTextField: UITextField!
  @IBOutlet weak var dateText: UITextField!
  @IBOutlet weak var journalTextField: UITextField!
  @IBOutlet weak var saveAction: UIButton!
  
  
    override func viewDidLoad() {
      super.viewDidLoad()
      
      setUpElement()
      
      
      let datePicker = UIDatePicker()
      datePicker.datePickerMode = .date
      datePicker.addTarget(self, action: #selector(dateChange(datePicker:)), for: UIControl.Event.valueChanged)
      datePicker.frame.size = CGSize(width: 0, height: 300)
      datePicker.preferredDatePickerStyle = .wheels
      
      dateText.inputView = datePicker
      dateText.text = formatDate(date: Date())
  }
  
  
  @objc func dateChange(datePicker: UIDatePicker) {
    dateText.text = formatDate(date: datePicker.date)
  }
  
  
  func formatDate(date: Date) -> String {
    
    let formatter = DateFormatter()
    formatter.dateFormat = "MMM dd yy"
    
    return formatter.string(from: date)
  }

  
  func setUpElement() {
    
    titleTextField.becomeFirstResponder()
          // style the elements
    Utilities.styleTextField(titleTextField)
//  Utilities.styleTextField(journalTextField)
    Utilities.styleFilledButton(saveAction)

  }
}
