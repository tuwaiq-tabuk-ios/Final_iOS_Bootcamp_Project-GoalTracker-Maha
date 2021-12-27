//
//  JournalViewController.swift
//  GoalTracker
//
//  Created by Maha S on 15/12/2021.
//

import UIKit

class JournalViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
  
  
  @IBOutlet weak var tableView: UITableView!
  
  var currentTitle: String = ""
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    tableView.delegate = self
    tableView.dataSource = self
    
  }
  
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    tableView.reloadData()
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
    if let journal = journalList{
      return journal.count
    } else {
      return 0
    }
  }
  
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
    if let journal = journalList {
      cell.textLabel?.text = journal[indexPath.row]
  }
    return cell
  
}
  
  
  func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    if editingStyle == .delete {
      journalList?.remove(at: indexPath.row)
      tableView.reloadData()
    }
  }
}
