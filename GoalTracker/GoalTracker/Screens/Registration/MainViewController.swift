//
//  ViewController.swift
//  GoalTracker
//
//  Created by Maha S on 12/12/2021.
//

import UIKit

class MainViewController: UIViewController {
  
  
  @IBOutlet var signUpButton: UIButton!
  @IBOutlet var logInButton: UIButton!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setUpElements()
  
  }


  func setUpElements() {
    
    Utilities.styleFilledButton(signUpButton)
    Utilities.styleFilledButton(logInButton)
  }
}

