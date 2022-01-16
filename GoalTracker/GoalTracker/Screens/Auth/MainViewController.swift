//
//  ViewController.swift
//  GoalTracker
//
//  Created by Maha S on 12/12/2021.
//

import UIKit

class MainViewController: UIViewController {
  
  // MARK: - IBOutlets
  
  @IBOutlet var signUpButton: UIButton!
  @IBOutlet var logInButton: UIButton!
  
  // MARK: - View Controller Lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setUpElements()
  }
  
  // MARK: - Methods
  
  func setUpElements() {
    Utilities.styleFilledButton(signUpButton)
    Utilities.styleFilledButton(logInButton)
  }
}

