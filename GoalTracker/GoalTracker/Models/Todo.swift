//
//  Todo.swift
//  GoalTracker
//
//  Created by Maha S on 15/12/2021.
//

import Foundation
import Firebase

struct Todo {
  
  // MARK: - Properties
  
  var title: String
  var isComplete: Bool
  var uuid = "1234"
  
  // MARK: - Init
  
  init(title: String, isComplete: Bool = false) {
    self.title = title
    self.isComplete = isComplete
  }
  
  
  init(data: [String: Any]) {
    title = data["title"] as? String ?? ""
    isComplete = data["isComplete"] as? Bool ?? false
    
  }
  
  init(document: QueryDocumentSnapshot) {
    let data = document.data()
    title = data["title"] as? String ?? ""
    isComplete = data["isComplete"] as? Bool ?? false
    uuid = document.documentID
  }
  
  // MARK: - Methods
  
  func completeToggled() -> Todo {
    return Todo(title: title, isComplete: !isComplete)
  }
  
}
