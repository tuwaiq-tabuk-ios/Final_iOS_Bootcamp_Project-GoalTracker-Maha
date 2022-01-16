//
//  GoalsViewController.swift
//  GoalTracker
//
//  Created by Maha S on 27/12/2021.
//

import UIKit
import Firebase


class Format {
  static var mmmddYYYYDateFormatter: DateFormatter {
    let formatter = DateFormatter()
    formatter.dateFormat = "MMM dd, YYYY"
    return formatter
  }
}


class GoalsViewController: UIViewController {
  
  // MARK: - Properties
  
  var goals = [Goal]()
  let customAlert = MyAlert()
  let db = Firestore.firestore()
  var ref: CollectionReference!
  
  @IBOutlet weak var tableView: UITableView!
  
  
  // MARK: - View Controller Lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    ref = Firestore.firestore().collection("Goals")
    fetchGoals()
  }
  

  func deleteGoal(_ goal: Goal, completion: ((Error?) -> Void)?) {
    let deletionID = goal.uuid
    self.ref.document(deletionID).delete { error in
      if let error = error {
        completion?(error)
        return
      }
      completion?(nil)
      
    }
  }
  
  // MARK: - IBAction
  
  @IBAction func didTapButton() {
    customAlert.showAlert(with: "Congratulations🥳🎉!",
                          message: "You have reached your Goal.",
                          on: self)
  }
  
  
  @objc func dismissAlert() {
    customAlert.dismissAlert()
  }
  
  
  // MARK: - IBSegueActions
  
  @IBSegueAction func addGaolCategory(_ coder: NSCoder, sender: Any?) -> GoalCategoryViewController? {
    let catVC = GoalCategoryViewController(coder: coder)
    catVC?.addGoalDelegate = self
    return catVC
  }
  
  
  @IBSegueAction func goalVC(_ coder: NSCoder) -> AddGoalViewController? {
    let vc = AddGoalViewController(coder: coder)
    
    if let indexpath = tableView.indexPathForSelectedRow {
      let goal = goals[indexpath.row]
      vc?.goal = goal
    }
    
    vc?.delegate = self
    vc?.presentationController?.delegate = self
    
    return vc
    
  }
}

// MARK: - FireStore

extension GoalsViewController {
  fileprivate func fetchGoals()  {
    
    FirebaseManager.shared.fetchGoals { [weak self] result in
      guard let self = self else { return }
      self.tableView.backgroundView = nil
      switch result {
      case .failure(let error):
        print(error)
        
      case .success(let goals):
        self.goals = goals
        self.tableView.reloadData()
      }
    }
  }
  
  fileprivate func persistGoalToFireStore(_ goal: Goal) {
    var data: [String: Any] = [:]
    data["title"] = goal.title
    data["date"] = goal.date
    data["category"] = goal.category
    data["isCompleted"] = false
    ref.addDocument(data: data) { [weak self] error in
      
      MainThread.run {
        self!.goals.insert(goal, at: 0)
        self!.tableView.performBatchUpdates {
          self!.tableView.insertRows(at: [IndexPath(row: 0, section: 0)], with: .automatic)
        } completion: { _ in }
      }
    }
  }
}

// MARK: - UITableViewDelegate

extension GoalsViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
    
    let action = UIContextualAction(style: .normal, title: "Complete") { action, view, complete in
      
      let goal = self.goals[indexPath.row].completeToggled()
      self.goals[indexPath.row] = goal
      
      let cell = tableView.cellForRow(at: indexPath) as! GoalsTableViewCell
      cell.set(checked: goal.isComplete)
      
      complete(true)
      
      print("complete")
    }
    
    return UISwipeActionsConfiguration(actions: [action])
  }
}


// MARK: - UITableViewDataSource

extension GoalsViewController: UITableViewDataSource {
  func numberOfSections(in tableView: UITableView) -> Int {
    1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return goals.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "GoalViewCell",
                                             for: indexPath) as! GoalsTableViewCell
    let goal = goals[indexPath.row]
    cell.bind(goal)
    cell.delegate = self
    return cell
  }
  
  func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle,
                 forRowAt indexPath: IndexPath) {
    
    if editingStyle == .delete {
      let goal = goals[indexPath.row]
      let cancelaction = UIAlertAction(title: "Cancel", style: .cancel
                                       , handler: nil)
      let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { [unowned self] _ in
        deleteGoal(goal) { [weak self] error in
          guard self != nil else { return }
          if let error = error {
            print(error) // Show user error
            return
          }
          
          goals.remove(at: indexPath.row)
          tableView.performBatchUpdates {
            tableView.deleteRows(at: [indexPath], with: .automatic)
          } completion: { _ in }
        }
      }
      
      let alertController = UIAlertController(title: "Warning", message: "Would you like to delete this Goal now?", preferredStyle: .actionSheet)
      alertController.addAction(cancelaction)
      alertController.addAction(deleteAction)
      present(alertController, animated: true, completion: nil)
    }
  }
  
  
  func addGoal(title: String, date: Double, category: String) {
    let goal = Goal(title: title, date: date, category: category)
    ref.addDocument(data: ["title": goal.title, "date": goal.date, "category": goal.category]) { error in
      if let error  = error {
        print(error)
        return
      }
      
      print("Successs")
      self.goals.insert(goal, at: 0)
      self.tableView.reloadData()
    }
  }
}


// MARK: - GoalsTableViewCellDelegate

extension GoalsViewController: GoalsTableViewCellDelegate {
  
  func goalsTableViewCell(_ cell: GoalsTableViewCell, didChagneCheckedState checked: Bool) {
    guard let indexPath = tableView.indexPath(for: cell) else {
      return
    }
    let goal = goals[indexPath.row]
    let newGoal = Goal(title: goal.title,
                       isComplete: checked,
                       date: goal.date,
                       category: goal.category)
    goals[indexPath.row] = newGoal
    
  }
}


// MARK: - AddGoalViewControllerDelegate

extension GoalsViewController: AddGoalViewControllerDelegate {
  func addGoalViewController(_ vc: AddGoalViewController, didSaveGoal goal: Goal) {
    if let index = goals.firstIndex(where: { $0.uuid == goal.uuid }) {
      goals[index] = goal
      tableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: .none)
      return
    }
    
    persistGoalToFireStore(goal)
  }
}


// MARK: - UIAdaptivePresentationControllerDelegate

extension GoalsViewController: UIAdaptivePresentationControllerDelegate {
  func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
    if let indexPath = tableView.indexPathForSelectedRow {
      tableView.deselectRow(at: indexPath, animated: true)
    }
  }
}

struct MainThread {
  static func run(_ block: @escaping (() -> Void)) {
    if Thread.isMainThread {
      block()
    } else {
      DispatchQueue.main.async {
        block()
      }
    }
  }
}
