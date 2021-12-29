//
//  TypeJournalViewController.swift
//  GoalTracker
//
//  Created by Maha S on 20/12/2021.
//

import UIKit

class AddJournalViewController: UIViewController, UITextFieldDelegate {
  
  
  @IBOutlet weak var titleTextField: UITextField!
  @IBOutlet weak var dateText: UITextField!
  @IBOutlet weak var journalTextField: UITextField!
  @IBOutlet weak var saveButton: UIButton!
  
  let datePicker = UIDatePicker()
  
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
    if (titleTextField.text != nil) && titleTextField.text != "" {
      journalList?.append(titleTextField.text!)
      titleTextField.text = ""

    }
  }
 
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    view.endEditing(true)
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
