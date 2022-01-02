//
//  NewGoalViewController.swift
//  GoalTracker
//
//  Created by Maha S on 27/12/2021.
//

import UIKit


protocol AddGoalViewControllerDelegate: AnyObject {
  func addGoalViewController(_ vc: AddGoalViewController, didSaveGoal goal: Goal)
}


class AddGoalViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
  
  
  @IBOutlet weak var addTextField: UITextField!
  @IBOutlet weak var dateTextField: UITextField!
  @IBOutlet weak var categoryTextField: UITextField!
  @IBOutlet weak var addButton: UIButton!
  
  
  let categoryPicker = UIPickerView()
  var currentIndex = 0
  let datePicker = UIDatePicker()
  
  weak var delegate: AddGoalViewControllerDelegate?

  var goal: Goal?
  
  override func viewDidLoad() {
      super.viewDidLoad()
    
    addTextField.text = goal?.title
    
    setUpElement()
    
    categoryPicker.delegate = self
    categoryPicker.dataSource = self
    categoryTextField.inputView = categoryPicker
    
    let datePicker = UIDatePicker()
    datePicker.datePickerMode = .date
    datePicker.addTarget(self, action: #selector(dateChange(datePicker:)),
                         for: UIControl.Event.valueChanged)
    datePicker.frame.size = CGSize(width: 0, height: 300)
    datePicker.preferredDatePickerStyle = .wheels
    
    dateTextField.inputView = datePicker
    dateTextField.text = formatDate(date: Date())
    
    let toolBar = UIToolbar()
    toolBar.sizeToFit()
    let buttonDone = UIBarButtonItem(title: "Done",
                                     style: .plain,
                                     target: self,
                                     action: #selector(closePicker))
    toolBar.setItems([buttonDone], animated: true)
    
    categoryTextField.inputAccessoryView = toolBar
    categoryTextField.textAlignment = .center
    dateTextField.inputAccessoryView = toolBar
    dateTextField.textAlignment = .center
    
    }
  
  
  @IBAction func save(_ sender: Any) {
    let goal = Goal(title: addTextField.text!, date: dateTextField.text!, category: categoryTextField.text!)
    delegate?.addGoalViewController(self, didSaveGoal: goal)
  }
  
  
  @objc func dateChange(datePicker: UIDatePicker) {
    dateTextField.text = formatDate(date: datePicker.date)
  }
  
  
  func formatDate(date: Date) -> String {
    
    let formatter = DateFormatter()
    formatter.dateStyle = .medium
    formatter.timeStyle = .none
    
    self.view.endEditing(true)
    self.dateTextField.text = formatter.string(from: datePicker.date)
    
    return formatter.string(from: date)
  }

  
  @objc func closePicker() {
    categoryTextField.text = cg[currentIndex].title
    view.endEditing(true)
  }
  
  
  func setUpElement() {
    
    addTextField.becomeFirstResponder()
    Utilities.styleFilledButton(addButton)
  }
  
  
  func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 1
  }
  
  
  func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    return cg.count
  }
  
  
  func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    return cg[row].title
  }
  
  
  func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    currentIndex = row
    categoryTextField.text = cg[row].title
  }
  
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    view.endEditing(true)
  }
  
  
}
