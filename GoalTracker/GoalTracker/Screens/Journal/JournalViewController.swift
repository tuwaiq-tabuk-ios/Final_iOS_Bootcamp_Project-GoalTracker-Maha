//
//  JournalViewController.swift
//  GoalTracker
//
//  Created by Maha S on 15/12/2021.
//

import UIKit
import Firebase

class Formatter {
  static var mmmddYYYYDateFormatter: DateFormatter {
    let formatter = DateFormatter()
    formatter.dateFormat = "MMM dd, YYYY"
    return formatter
  }
}


class JournalViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, AddJournal {
  
  // MARK: - Properties
  
  var journals = [Journal]()
  let db = Firestore.firestore()
  var ref: CollectionReference!
  
  // MARK: - IBOutlet
  
  @IBOutlet weak var tableView: UITableView!
  
  // MARK: - View Controller Lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    tableView.delegate = self
    tableView.dataSource = self
    
    
    ref = db.collection("journal")
    
    ref.getDocuments { snapshot, error in
      if let error = error {
        print(error)
        return
      }
      
      let documents = snapshot?.documents ?? []
      var allJournals: [Journal] = []
      for document in documents {
        print(document.documentID, document.data())
        let data = document.data()
        let title = data["title"] as? String ?? ""
        let date = data["createdDate"] as? Double ?? 0.0
        let body = data["body"] as? String ?? ""
        let journal = Journal(title: title, date: date, body: body)
        journal.uuid = document.documentID
        allJournals.append(journal)
      }
      
      self.journals = allJournals.sorted(by: { $0.date < $1.date })
      self.tableView.reloadData()
      
      DispatchQueue.main.async {
        self.tableView.reloadData()
      }
    }
  }
  
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    tableView.reloadData()
  }
  
  // MARK: - IBSegueActions
  
  @IBSegueAction func addTitle(_ coder: NSCoder) -> AddJournalViewController? {
    let aT = AddJournalViewController(coder: coder)
    aT?.delegate = self
    return aT
  }
  
  
  @IBSegueAction func addJournal(_ coder: NSCoder) -> DetailsViewController? {
    let vc = DetailsViewController(coder: coder)
    
    if let indexpath = tableView.indexPathForSelectedRow {
      let journal = journals[indexpath.row]
      vc?.journal = journal
    }
    
    return vc
  }
  
  // MARK: - Methods
  
  func addJournal(title: String, date: Double, body: String) {
    let journal = Journal(title: title, date: date, body: body)
    ref.addDocument(data: ["title": journal.title, "createdDate": journal.date, "body": journal.body]) { error in
      if let error  = error {
        print(error)
        return
      }
      
      print("Successs")
      self.journals.insert(journal, at: 0)
      self.tableView.reloadData()
    }
    
  }
  
  
  func deleteJournal(_ journal: Journal, completion: ((Error?) -> Void)?) {
    let deletionID = journal.uuid
    self.ref.document(deletionID).delete { error in
      if let error = error {
        completion?(error)
        return
      }
      
      completion?(nil)
    }
  }
  
  // MARK: - TableView
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return journals.count
  }
  
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "JournalCell", for: indexPath) as! JournalViewCell
    let journal = journals[indexPath.row]
    cell.titleLabel.text = journal.title
    cell.bodyLabel.text = journal.body
    cell.dateLabel.text = journal.formattedDate
    return cell
  }
  
  
  func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    
    if editingStyle == .delete {
      let journal = journals[indexPath.row]
      let cancelaction = UIAlertAction(title: "Cancel", style: .cancel
                                       , handler: nil)
      let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { [unowned self] _ in
        deleteJournal(journal) { [weak self] error in
          guard let self = self else { return }
          if let error = error {
            print(error) // Show user error
            return
          }
          
          self.journals.remove(at: indexPath.row)
          self.tableView.deleteRows(at: [indexPath], with: .automatic)
        }
      }
      // delete warning
      let alertController = UIAlertController(title: "Warning", message: "Would you like to delete this Journal now?", preferredStyle: .actionSheet)
      alertController.addAction(cancelaction)
      alertController.addAction(deleteAction)
      present(alertController, animated: true, completion: nil)
      
    }
  }
  
  //  DetailsViewController Segue
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let journal = journals[indexPath.row]
    
    if let detailViewController: DetailsViewController = UIStoryboard.main.instantiate() {
      detailViewController.journal = journal
      navigationController?.pushViewController(detailViewController, animated: true)
    }
  }
}


// MARK: - DetailsViewController Segue

extension UIStoryboard {
  static var main: UIStoryboard {
    return UIStoryboard(name: "Main", bundle: nil)
  }
  
  func instantiate<T: UIViewController>() -> T? {
    let viewController = instantiateViewController(withIdentifier: T.storyboardID) as? T
    return viewController
  }
}


extension UIViewController {
  static var storyboardID: String {
    return String(describing: self)
  }
}
