//
//  JournalData.swift
//  GoalTracker
//
//  Created by Maha S on 26/12/2021.
//

import Foundation


var journalList: [String]?

func saveData(journalList: [String]) {
  UserDefaults.standard.set(journalList, forKey: "journalList")
  
}


func fetchData() -> [String]? {
  if let journal = UserDefaults.standard.array(forKey: "journalList") as? [String] {
    return journal
  }
  else {
    return nil
  }
}
