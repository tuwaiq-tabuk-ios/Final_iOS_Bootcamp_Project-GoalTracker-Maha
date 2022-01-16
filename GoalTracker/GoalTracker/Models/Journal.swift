//
//  Journal.swift
//  GoalTracker
//
//  Created by Maha S on 01/01/2022.
//

import UIKit

class Journal {
  
  // MARK: - Properties
  
  var title = ""
  var date: Double = 0.0
  var body = ""
  var uuid = "1234"
  var formattedDate: String {
    let date = Date(timeIntervalSince1970: self.date)
    let formattedDate = Formatter.mmmddYYYYDateFormatter.string(from: date)
    return formattedDate
  }
  
  // MARK: - Init
  
  convenience init(title: String, date: Double, body: String) {
    self.init()
    self.title = title
    self.date = date
    self.body = body
  }
}

