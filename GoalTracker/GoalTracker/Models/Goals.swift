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
  let date: String
  let category: String
  
  
  init(title: String, isComplete: Bool = false, date: String, category: String) {
    self.title = title
    self.isComplete = isComplete
    self.date = date
    self.category = category
  }
  
  
  func completeToggled() -> Goal {
    return Goal(title: title, isComplete: !isComplete, date: date, category: category)
  }
  
}
