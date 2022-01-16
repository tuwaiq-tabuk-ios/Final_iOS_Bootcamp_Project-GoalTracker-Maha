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


class AddGoalViewController: UIViewController, UIPickerViewDelegate,
                             UIPickerViewDataSource, UITextFieldDelegate {
  
  
  // MARK: - Properties
  
  var selectedCategory: String?
  let categoryPicker = UIPickerView()
  var currentIndex = 0
  let datePicker = UIDatePicker()
  weak var delegate: AddGoalViewControllerDelegate?
  var goal: Goal?
  
  // MARK: - IBOutlets
  
  @IBOutlet weak var addTextField: UITextField!
  @IBOutlet weak var dateTextField: UITextField!
  @IBOutlet weak var categoryTextField: UITextField!
  @IBOutlet weak var addButton: UIButton!
  
  
  // MARK: - View Controller Lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    navigationItem.title = "Add Goal"
    navigationItem.largeTitleDisplayMode = .never
    
    if let selectedCategory = selectedCategory {
      categoryTextField.text = selectedCategory
    }
    
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
  
  
  // MARK: - IBActions
  
  @IBAction func save(_ sender: Any) {
    let title = addTextField.text ?? ""
    let date = Date().timeIntervalSince1970
    let category = categoryTextField.text ?? ""
    let goal = Goal(title: title, date: date, category: category)
    navigationController?.popToRootViewController(animated: true)
    delegate?.addGoalViewController(self, didSaveGoal: goal)
  }
  
  // MARK: - Methods
  
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
    Utilities.styleTextField(addTextField)
    Utilities.styleTextField(dateTextField)
    Utilities.styleTextField(categoryTextField)
    Utilities.styleFilledButton(addButton)
  }
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    view.endEditing(true)
  }
  
  // MARK: - UIPickerView
  
  func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 1
  }
  
  
  func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    return cg.count
  }
  
  
  func pickerView(_ pickerView: UIPickerView, titleForRow row: Int,
                  forComponent component: Int) -> String? {
    return cg[row].title
  }
  
  
  func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int,
                  inComponent component: Int) {
    currentIndex = row
    categoryTextField.text = cg[row].title
  }
  
}
