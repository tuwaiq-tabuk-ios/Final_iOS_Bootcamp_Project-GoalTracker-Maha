//
//  TypeJournalViewController.swift
//  GoalTracker
//
//  Created by Maha S on 20/12/2021.
//

import UIKit

protocol AddJournal {
  func addJournal(title: String, date: Double, body: String)
}

class AddJournalViewController: UIViewController, UITextFieldDelegate {
  
  // MARK: - Properties
  
  let datePicker = UIDatePicker()
  var delegate: AddJournal?
  
  // MARK: - IBOutlets
  
  @IBOutlet weak var titleTextField: UITextField!
  @IBOutlet weak var dateText: UITextField!
  @IBOutlet weak var journalTextView: UITextView!
  @IBOutlet weak var saveButton: UIButton!
  
  // MARK: - View Controller Lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setUpElement()
    createDatePicker()
    navigationItem.title = "Add Entry"
    navigationItem.largeTitleDisplayMode = .never
    
  }
  
  // MARK: - Methods
  
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
  
  
  func setUpElement() {
    titleTextField.becomeFirstResponder()
    Utilities.styleTextField(dateText)
    Utilities.styleTextField(titleTextField)
    journalTextView.layer.cornerRadius = 10
    Utilities.styleFilledButton(saveButton)
  }
  
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    view.endEditing(true)
  }
  
  // MARK: - IBAction
  
  @IBAction func savePressed(_ sender: UIButton) {
    if titleTextField.text != "" {
      let date = datePicker.date.timeIntervalSince1970
      delegate?.addJournal(title: titleTextField.text!, date: date, body: journalTextView.text!)
      navigationController?.popViewController(animated: true)
    }
  }
}

