//
//  Utilities.swift
//
//   Created by Maha S on 12/12/2021.



import Foundation
import UIKit

class Utilities {
  
  static func styleTextField(_ textfield:UITextField) {
    
      // Create the bottom line
    let bottomLine = CALayer()
    
    bottomLine.frame = CGRect(x: 0, y: textfield.frame.height,
                              width: textfield.frame.width, height: 1)
    
    bottomLine.backgroundColor = UIColor.lightGray.cgColor
    
    // Remove border on text field
    textfield.borderStyle = .none
    
    // Add the line to the text field
    textfield.layer.addSublayer(bottomLine)
  }
  
  static func styleFilledButton(_ button:UIButton) {
    
    // Filled rounded corner style
    //        button.backgroundColor = UIColor.lightGray
    button.layer.cornerRadius = 10
    //        button.tintColor = UIColor.white
  }
  
  
  static func styleHollowButton(_ button:UIButton) {
    
    // Hollow rounded corner style
    button.layer.borderWidth = 3
    button.layer.borderColor = UIColor.black.cgColor
    button.layer.cornerRadius = 10
    //        button.tintColor = UIColor.white
  }
  
  static func isPasswordValid(_ password : String) -> Bool {
    
    let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}")
    return passwordTest.evaluate(with: password)
  }
  
}


