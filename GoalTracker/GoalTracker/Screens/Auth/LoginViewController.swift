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
  }
  
  
  // MARK: - IBAction
  
  @IBAction func loginTapped(_ sender: Any) {
    
    // TODO: Validate Text Fields
    
    // Create cleaned versions of the text field
    let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
    let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
    
    let loadingViewController: LoadingViewController = .init()
    present(loadingViewController, animated: true) {
      
      // Signing in the user
      Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
        loadingViewController.dismiss(animated: true) {
          if error != nil {
            // Couldn't sign in
            self.errorLabel.text = error!.localizedDescription
            self.errorLabel.alpha = 1
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
    errorLabel.alpha = 0
    emailTextField.becomeFirstResponder()
    Utilities.styleTextField(emailTextField)
    Utilities.styleTextField(passwordTextField)
    Utilities.styleFilledButton(logInButton)
  }
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    view.endEditing(true)
  }
}
