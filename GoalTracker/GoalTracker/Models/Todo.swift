//
//  Todo.swift
//  GoalTracker
//
//  Created by Maha S on 15/12/2021.
//

import Foundation
import Firebase

struct Todo {
  
  var title: String
  var isComplete: Bool
  var uuid = "1234"

  
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
  
  func completeToggled() -> Todo {
    return Todo(title: title, isComplete: !isComplete)
  }
  
}
