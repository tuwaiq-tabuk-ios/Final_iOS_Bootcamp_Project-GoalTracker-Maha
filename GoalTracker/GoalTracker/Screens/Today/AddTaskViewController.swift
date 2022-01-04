//
//  TodoViewController.swift
//  GoalTracker
//
//  Created by Maha S on 15/12/2021.
//
import Firebase
import FirebaseFirestore
import UIKit

protocol AddTaskViewControllerDelegate: AnyObject {
  func todoViewController(_ vc: AddTaskViewController, didSaveTodo todo: Todo)
}


class AddTaskViewController: UIViewController, UITextFieldDelegate {
  
  @IBOutlet weak var done: UIButton!
  @IBOutlet weak var textfield: UITextField!
  
  
  var todo: Todo?
  
  weak var delegate: AddTaskViewControllerDelegate?

  override func viewDidLoad() {
    super.viewDidLoad()

    textfield.text = todo?.title
    setUpElement()
  }
    
  
  func setUpElement() {
    textfield.becomeFirstResponder()
    
    // style the elements
    Utilities.styleTextField(textfield)
    Utilities.styleFilledButton(done)
    
  }
  
  
  @IBAction func save(_ sender: Any) {
    let todo = Todo(title: textfield.text!)
    delegate?.todoViewController(self, didSaveTodo: todo)
    navigationController?.popViewController(animated: true)
  }
  
  
override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    view.endEditing(true)
  }
}
