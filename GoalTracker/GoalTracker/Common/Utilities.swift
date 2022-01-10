//
//  Utilities.swift
//
//   Created by Maha S on 12/12/2021.



import Foundation
import UIKit


class Utilities {
  
  static func styleTextField(_ textfield:UITextField) {
    
    textfield.layer.shadowOpacity = 0.5
    textfield.layer.shadowOffset = CGSize(width: 0, height: 0)
    textfield.layer.shadowColor = UIColor.lightGray.cgColor
    textfield.layer.cornerRadius = 10
  }
  
  static func styleFilledButton(_ button:UIButton) {
    
    // Filled rounded corner style
    button.layer.cornerRadius = 10
//    button.layer.shadowColor = UIColor.gray.cgColor
//    button.layer.shadowRadius = 6
//    button.layer.shadowOffset = CGSize(width: 0, height: 0)
//    button.layer.shadowOpacity = 0.5
  }
  
  
  static func styleTextView(_ textView: UITextView) {
    
    textView.layer.shadowColor = UIColor.gray.cgColor
    textView.layer.shadowOffset = CGSize(width: 0, height: 0)
    textView.layer.shadowOpacity = 0.5
    textView.layer.cornerRadius = 10
    
  }
  
  
  static func styleHollowButton(_ button:UIButton) {
    
    // Hollow rounded corner style
    button.layer.borderWidth = 3
    button.layer.borderColor = UIColor.black.cgColor
    button.layer.cornerRadius = 10

    //        button.tintColor = UIColor.white
  }
  
  static func isPasswordValid(_ password : String) -> Bool {
    
    let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&_])[A-Za-z\\d$@$#!%*?&_]{8,}")
    return passwordTest.evaluate(with: password)
  }
  
}


