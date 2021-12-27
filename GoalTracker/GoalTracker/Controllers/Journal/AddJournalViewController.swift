//
//  TypeJournalViewController.swift
//  GoalTracker
//
//  Created by Maha S on 20/12/2021.
//

import UIKit

class AddJournalViewController: UIViewController {
  
  
  @IBOutlet weak var titleTextField: UITextField!
  @IBOutlet weak var dateText: UITextField!
  @IBOutlet weak var journalTextField: UITextField!
  
  @IBOutlet weak var saveButton: UIButton!
  
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
  
  
  @IBAction func savePressed(_ sender: UIButton) {
    if (titleTextField.text != nil) && titleTextField.text != "" {
      journalList?.append(titleTextField.text!)
      titleTextField.text = ""

    }
    
    if (journalTextField.text != nil) && journalTextField.text != "" {
      journalList?.append(journalTextField.text!)
      journalTextField.text = ""
    }
    
    if (dateText.text != nil) && dateText.text != "" {
      journalList?.append(dateText.text!)
    
    }

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
    journalTextField.borderStyle = .roundedRect
          // style the elements
//    Utilities.styleTextField(titleTextField)
//    Utilities.styleTextField(journalTextField)
    Utilities.styleFilledButton(saveButton)

  }
}
