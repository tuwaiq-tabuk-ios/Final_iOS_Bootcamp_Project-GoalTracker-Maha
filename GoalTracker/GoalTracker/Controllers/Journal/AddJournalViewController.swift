//
//  TypeJournalViewController.swift
//  GoalTracker
//
//  Created by Maha S on 20/12/2021.
//

import UIKit

protocol AddJournal {
  func addJournal(title: String, date: String, body: String)
}

class AddJournalViewController: UIViewController, UITextFieldDelegate {
  
  
  @IBOutlet weak var titleTextField: UITextField!
  @IBOutlet weak var dateText: UITextField!
  @IBOutlet weak var journalTextView: UITextView!
  @IBOutlet weak var saveButton: UIButton!
  
  let datePicker = UIDatePicker()
  var delegate: AddJournal?

  
    override func viewDidLoad() {
      super.viewDidLoad()
      
      setUpElement()
      createDatePicker()
  }
  
  
  func createToolBar() -> UIToolbar{
    let toolbar = UIToolbar()
    toolbar.sizeToFit()
    
    let doneButton = UIBarButtonItem(barButtonSystemItem: .done,
                                     target: nil,
                                     action: #selector(donePressed))
    toolbar.setItems([doneButton], animated: true)
    
    return toolbar
    
  }
  
  
  func createDatePicker() {
    datePicker.preferredDatePickerStyle = .wheels
    datePicker.datePickerMode = .date
    dateText.textAlignment = .center
    dateText.inputView = datePicker
    dateText.inputAccessoryView = createToolBar()
    
  }
  
  // datePicker
  @objc func donePressed() {
    
    let dateFormatter = DateFormatter()
    dateFormatter.dateStyle = .medium
    dateFormatter.timeStyle = .none
    
    self.view.endEditing(true)
    self.dateText.text = dateFormatter.string(from: datePicker.date)
    
  }
  
  
  @IBAction func savePressed(_ sender: UIButton) {
    if titleTextField.text != "" {
      delegate?.addJournal(title: titleTextField.text!, date: dateText.text!, body: journalTextView.text!)
      navigationController?.popViewController(animated: true)
    }
  }

  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    view.endEditing(true)
  }
  
  
  func setUpElement() {
    titleTextField.becomeFirstResponder()
    Utilities.styleFilledButton(saveButton)

  }
}

