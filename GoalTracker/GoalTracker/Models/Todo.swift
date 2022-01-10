//
//  Todo.swift
//  GoalTracker
//
//  Created by Maha S on 15/12/2021.
//

import Foundation

struct Todo {
  
  let title: String
  var isComplete: Bool
  var uuid = "1234"

  
  init(title: String, isComplete: Bool = false) {
    self.title = title
    self.isComplete = isComplete
  }
  
  
  func completeToggled() -> Todo {
    return Todo(title: title, isComplete: !isComplete)
  }
  
}
