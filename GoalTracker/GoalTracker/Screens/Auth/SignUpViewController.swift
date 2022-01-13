//
//  SignUpViewController.swift
//  GoalTracker
//
//  Created by Maha S on 12/12/2021.
//

import UIKit
import FirebaseAuth
import Firebase


class SignUpViewController: UIViewController, UITextFieldDelegate {
  
  
  @IBOutlet var firstNameTextField: UITextField!
  @IBOutlet var lastNameTextField: UITextField!
  @IBOutlet var emailTextField: UITextField!
  @IBOutlet var passwordTextField: UITextField!
  @IBOutlet var signUpButton: UIButton!
  @IBOutlet var errorLabel: UILabel!
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setUpElement()
  }
  
  
  func addLeftImageTo(textField: UITextField, andImage img: UIImage) {
    let leftImageView = UIImageView(frame: CGRect(x: 0.0,
                                                  y: 0.0,
                                                  width: img.size.width,
                                                  height: img.size.height))
    leftImageView.image = img
    emailTextField.rightView = leftImageView
    emailTextField.rightViewMode = .always
  }
  
  
  func setUpElement() {
    errorLabel.alpha = 0
    firstNameTextField.becomeFirstResponder()
    
    Utilities.styleTextField(firstNameTextField)
    Utilities.styleTextField(lastNameTextField)
    Utilities.styleTextField(emailTextField)
    Utilities.styleTextField(passwordTextField)
    Utilities.styleFilledButton(signUpButton)
    
  }
  
  
  func validateFields() -> String? {
    if firstNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
        lastNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
        emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
        passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
      
      return "Please fill in all fields."
    }
    
    let cleanedPassword = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
    
    if Utilities.isPasswordValid(cleanedPassword) == false {
      return "Incorrect password."
    }
    
    return nil
  }
  
  
  @IBAction func signUpTapped(_ sender: Any) {

    let error = validateFields()
    
    if error != nil {
      showError(error!)
    } else {
      
      let firstName = firstNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
      let lastName = lastNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
      let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
      let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
      
      Auth.auth().createUser(withEmail: email, password: password) { (result, err) in
        
        if err != nil {
          
          self.showError("Error creating user")
        } else {
          
          let db = Firestore.firestore()
          
          db.collection("users").addDocument(data: ["firstname":firstName, "lastname":lastName, "uid": result!.user.uid ]) { (error) in
            
            if error != nil {
              self.showError("Error saving user data")
            }
          }
              self.transitionToHome()
        }
      }
    }
  }
  
  
  func showError(_ message:String) {
    errorLabel.text = message
    errorLabel.alpha = 1
  }
  
  
  func transitionToHome() {
    let homeViewController = storyboard?.instantiateViewController(identifier: "HomeVC")
    
    view.window?.rootViewController = homeViewController
    view.window?.makeKeyAndVisible()
  }
  
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    view.endEditing(true)
  }
}

