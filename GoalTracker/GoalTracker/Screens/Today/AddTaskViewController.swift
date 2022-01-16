//
//  TodoViewController.swift
//  GoalTracker
//
//  Created by Maha S on 15/12/2021.
//

import UIKit

protocol AddTaskViewControllerDelegate: AnyObject {
  func todoViewController(_ vc: AddTaskViewController, didSaveTodo todo: Todo)
}


class AddTaskViewController: UIViewController, UITextFieldDelegate {
  
  // MARK: - IBOutlets
  
  @IBOutlet weak var done: UIButton!
  @IBOutlet weak var textfield: UITextField!
  
  
  // MARK: - Properties
  
  var todo: Todo?
  weak var delegate: AddTaskViewControllerDelegate?
  
  
  // MARK: - View Controller Lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    textfield.text = todo?.title
    setUpElement()
    navigationItem.title = "Add Task"
    navigationItem.largeTitleDisplayMode = .never
  }
  
  
  // MARK: - IBAction
  
  @IBAction func save(_ sender: Any) {
    let todo = Todo(title: textfield.text!)
    delegate?.todoViewController(self, didSaveTodo: todo)
    navigationController?.popViewController(animated: true)
  }
  
  // MARK: - Methods
  
  func setUpElement() {
    textfield.becomeFirstResponder()
    // style the elements
    Utilities.styleTextField(textfield)
    Utilities.styleFilledButton(done)
  }
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    view.endEditing(true)
  }
}
