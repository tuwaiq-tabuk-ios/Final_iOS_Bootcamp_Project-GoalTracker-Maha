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
  
  
  // MARK: - IBOutlets
  
  @IBOutlet var firstNameTextField: UITextField!
  @IBOutlet var lastNameTextField: UITextField!
  @IBOutlet var emailTextField: UITextField!
  @IBOutlet var passwordTextField: UITextField!
  @IBOutlet var confirmPassword: UITextField!
  @IBOutlet var signUpButton: UIButton!
  @IBOutlet var errorLabel: UILabel!
  
  // MARK: - View Controller LifeCycle
  
  override func viewDidLoad() {
    super.viewDidLoad()

    
    setUpElement()
    passwordTextField.enablePasswordToggle()
    confirmPassword.enablePasswordToggle()
  }
  
  
  // MARK: - Register
  
  func validateFields() -> String? {
    if firstNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
        lastNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
        emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
        passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
      
      return "Please fill in all fields"
    }
    
    let cleanedPassword = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
    
    if Utilities.isPasswordValid(cleanedPassword) == false {
      return "Incorrect password"
    }
    
    return nil
  }
  
  // MARK: - IBAction
  
  @IBAction func signUpTapped(_ sender: Any) {
    
    let error = validateFields()
    
    if error != nil {
      showError(error!)
    } else {
      
      let firstName = firstNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
      let lastName = lastNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
      let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
      let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
      
      
      if passwordTextField.text != confirmPassword.text {
        self.showError("Password not maching")
      } else {
        Auth.auth().createUser(withEmail: email, password: password) { (result, err) in
          
          if err != nil {
            
            self.showError("Error creating user")
          } else {
            
            let db = Firestore.firestore()
            
            db.collection("users").addDocument(data: ["firstname":firstName,
                                                      "lastname":lastName,
                                                      "uid": result!.user.uid ]) { (error) in
              
              if error != nil {
                self.showError("Error saving user data")
              }
            }
            self.transitionToHome()
          }
        }
      }
    }
  }
  
  
  // MARK: - Methods
  
  func showError(_ message:String) {
    errorLabel.text = message
    errorLabel.alpha = 1
  }
  
  
  func transitionToHome() {
    let homeViewController = storyboard?.instantiateViewController(identifier: "HomeVC")
    
    view.window?.rootViewController = homeViewController
    view.window?.makeKeyAndVisible()
  }
  
  
  func setUpElement() {
    errorLabel.alpha = 0
    firstNameTextField.becomeFirstResponder()
    Utilities.styleFilledButton(signUpButton)
    
  }
  
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    view.endEditing(true)
  }
}


// MARK: - Password TextField

extension UITextField {
  fileprivate func setPasswordToggleImage(_ button: UIButton) {
    if(isSecureTextEntry){
      button.setImage(UIImage(named: "CloseEye"), for: .normal)
    } else {
      button.setImage(UIImage(named: "OpenEye"), for: .normal)
    }
  }
  
  
  func enablePasswordToggle(){
    
    let button = UIButton(type: .custom)
    setPasswordToggleImage(button)
    button.imageEdgeInsets = UIEdgeInsets(top: 0,
                                          left: -16,
                                          bottom: 0,
                                          right: 0)
    
    button.addTarget(self, action: #selector(self.togglePasswordView), for: .touchUpInside)
    self.rightView = button
    self.rightViewMode = .always
    
  }
  
  @IBAction func togglePasswordView(_ sender: Any) {
    self.isSecureTextEntry = !self.isSecureTextEntry
    setPasswordToggleImage(sender as! UIButton)
  }
}
