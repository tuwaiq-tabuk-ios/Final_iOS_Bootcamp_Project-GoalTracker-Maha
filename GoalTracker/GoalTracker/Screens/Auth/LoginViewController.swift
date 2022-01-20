//
//  LoginViewController.swift
//  GoalTracker
//
//  Created by Maha S on 12/12/2021.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController, UITextFieldDelegate {
  
  // MARK: - IBOutlets
  
  @IBOutlet var emailTextField: UITextField!
  @IBOutlet var passwordTextField: UITextField!
  @IBOutlet var logInButton: UIButton!
  @IBOutlet var errorLabel: UILabel!
  
  // MARK: - View Controller Lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setUpElement()
    passwordTextField.enablePasswordToggle()

  }
  
  
  // MARK: - IBAction
  
  @IBAction func loginTapped(_ sender: Any) {
    
    // TODO: Validate Text Fields
    
    let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
    let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
    
    let loadingViewController: LoadingViewController = .init()
    present(loadingViewController, animated: true) {
      
      // Signing in the user
      Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
        loadingViewController.dismiss(animated: true) {
          if error != nil {
            self.errorLabel.text = error!.localizedDescription
            self.errorLabel.isHidden = false
          } else {
            
            let homeViewController = self.storyboard?.instantiateViewController(identifier:"HomeVC")
            
            self.view.window?.rootViewController = homeViewController
            self.view.window?.makeKeyAndVisible()
          }
        }
      }
    }
  }
  
  
  // MARK: - Methods
  
  func setUpElement() {
    // hide error label
    errorLabel.isHidden = true
    emailTextField.becomeFirstResponder()
    Utilities.styleTextField(emailTextField)
    Utilities.styleTextField(passwordTextField)
    Utilities.styleFilledButton(logInButton)
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
    }else{
      button.setImage(UIImage(named: "OpenEye"), for: .normal)
      
    }
  }
  
  func enableLogInPasswordToggle(){
    
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
  
  @IBAction func toggleLogInPasswordView(_ sender: Any) {
    self.isSecureTextEntry = !self.isSecureTextEntry
    setPasswordToggleImage(sender as! UIButton)
  }
}
