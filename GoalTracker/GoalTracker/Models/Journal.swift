//
//  Journal.swift
//  GoalTracker
//
//  Created by Maha S on 01/01/2022.
//

import UIKit

class Journal {
  
  var title = ""
  var date = ""
  var body = ""

  
  convenience init(title: String, date: String, body: String) {
    self.init()
    self.title = title
    self.date = date
    self.body = body
  }
}

