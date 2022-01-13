//
//  Goals.swift
//  GoalTracker
//
//  Created by Maha S on 28/12/2021.
//

import Foundation
import Firebase

struct Goal {
  
  var title: String
  var isComplete: Bool = false
  let date: Double
  let category: String
  var uuid: String = ""
  var formattedDate: String {
    let date = Date(timeIntervalSince1970: self.date)
    let formattedDate = Formatter.mmmddYYYYDateFormatter.string(from: date)
    return formattedDate
  }
  
  init(title: String, isComplete: Bool = false, date: Double, category: String) {
    self.title = title
    self.isComplete = isComplete
    self.date = date
    self.category = category
  }
  
  init(data: [String: Any]) {
    title = data["title"] as? String ?? ""
    date = data["date"] as? Double ?? 0.0
    category = data["category"] as? String ?? ""
    isComplete = data["isCompleted"] as? Bool ?? false
  }
  
  init(document: QueryDocumentSnapshot) {
    let data = document.data()
    title = data["title"] as? String ?? ""
    date = data["date"] as? Double ?? 0.0
    category = data["category"] as? String ?? ""
    isComplete = data["isCompleted"] as? Bool ?? false
    uuid = document.documentID
  }
  
  func completeToggled() -> Goal {
    return Goal(title: title, isComplete: !isComplete, date: date, category: category)
  }
  
}
