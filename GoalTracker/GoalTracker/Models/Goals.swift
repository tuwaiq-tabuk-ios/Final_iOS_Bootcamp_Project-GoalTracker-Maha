//
//  Goals.swift
//  GoalTracker
//
//  Created by Maha S on 28/12/2021.
//

import Foundation

struct Goal {
  
  let title: String
  let isComplete: Bool
  
  init(title: String, isComplete: Bool = false) {
    self.title = title
    self.isComplete = isComplete
  }
  
  
  func completeToggled() -> Goal {
    return Goal(title: title, isComplete: !isComplete)
  }
  
}
