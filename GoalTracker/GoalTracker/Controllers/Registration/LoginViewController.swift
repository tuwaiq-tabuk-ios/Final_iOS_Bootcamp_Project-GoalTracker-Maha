//
//  LoginViewController.swift
//  GoalTracker
//
//  Created by Maha S on 12/12/2021.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController, UITextFieldDelegate {
  
  
  
  @IBOutlet var emailTextField: UITextField!
  @IBOutlet var passwordTextField: UITextField!
  @IBOutlet var logInButton: UIButton!
  @IBOutlet var errorLabel: UILabel!
  

    override func viewDidLoad() {
        super.viewDidLoad()

      setUpElement()
    }
    
  
  func setUpElement() {
    
    // hide error label
    errorLabel.alpha = 0
    emailTextField.becomeFirstResponder()
    // style the elements
    Utilities.styleTextField(emailTextField)
    Utilities.styleTextField(passwordTextField)
    Utilities.styleFilledButton(logInButton)
    
  }
    
  @IBAction func loginTapped(_ sender: Any) {
    
    // TODO: Validate Text Fields
    
    // Create cleaned versions of the text field
    let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
    let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
    
    // Signing in the user
    Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
      
      if error != nil {
        // Couldn't sign in
        self.errorLabel.text = error!.localizedDescription
        self.errorLabel.alpha = 1
      }
      else {
        
        let homeViewController = self.storyboard?.instantiateViewController(identifier: Constants.Storyboard.homeViewController) as? HomeViewController
        
        self.view.window?.rootViewController = homeViewController
        self.view.window?.makeKeyAndVisible()
      }
    }
    
    
    func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
      view.endEditing(true)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
  }
