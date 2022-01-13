//
//  ViewController.swift
//  GoalTracker
//
//  Created by Maha S on 15/12/2021.
//

import UIKit
import FSCalendar
import UserNotifications
import Firebase

class ToDoViewController: UIViewController {
  
  var todos = [Todo]()
  var calendarHeightConstraint: NSLayoutConstraint!
  let db = Firestore.firestore()
  var ref: CollectionReference!
  private var calendar = FSCalendar()
  
  @IBOutlet weak var tableView: UITableView!
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    
    ref = db.collection("Tasks")
    
    ref.getDocuments { snapshot, error in
      if let error = error {
        print(error)
        return
      }
      
      let documents = snapshot?.documents ?? []
      var allTasks: [Todo] = []
      for document in documents {
        print(document.documentID, document.data())
        let data = document.data()
        let title = data["title"] as? String ?? ""
        let isComplete = data["isComplete"] as? Bool ?? false
        var todo = Todo(title: title, isComplete: isComplete)
        todo.uuid = document.documentID
        allTasks.append(todo)
      }
      self.tableView.reloadData()
      DispatchQueue.main.async {
        self.tableView.reloadData()
      }
    }
    
    
    let center = UNUserNotificationCenter.current()
    
    center.requestAuthorization(options: [.alert, .badge, .sound])
    { granted, error in
      
    }
    
    let content = UNMutableNotificationContent()
    content.title = "Hey"
    content.body = "Don't forget to finish your tasks for today!"
    
    let date = Date().addingTimeInterval(5)
    
    let dateComponents = Calendar.current.dateComponents([.year,
                                                          .month,
                                                          .day,
                                                          .hour,
                                                          .minute,
                                                          .second],
                                                         from: date)
    
    let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
    
    let uuidString = UUID().uuidString
    
    let request = UNNotificationRequest(identifier: uuidString,
                                        content: content,
                                        trigger: trigger)
    
    center.add(request) { error in
    }
    
    setCalendarConstraints()
    
    calendar.delegate = self
    calendar.dataSource = self
    
    let db = Firestore.firestore()
    
    db.collection("Tasks").getDocuments() { (querySnapshot, err) in
      if let err = err {
        print("Error getting documents: \(err)")
      } else {
        for document in querySnapshot!.documents {
          print("\(document.documentID) => \(document.data())")
        }
      }
    }
  }
  
  
  @IBSegueAction func todoViewController(_ coder: NSCoder) -> AddTaskViewController? {
    let vc = AddTaskViewController(coder: coder)
    
    if let indexpath = tableView.indexPathForSelectedRow {
      let todo = todos[indexpath.row]
      vc?.todo = todo
    }
    
    vc?.delegate = self
    vc?.presentationController?.delegate = self
    
    return vc
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    tableView.reloadData()
  }
}



// MARK: - Table delegate

extension ToDoViewController: UITableViewDelegate {
  
  func tableView(
    _ tableView: UITableView,
    leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath
  ) -> UISwipeActionsConfiguration? {
    
    let action = UIContextualAction(style: .normal, title: "Complete") { action, view, complete in
      
      let todo = self.todos[indexPath.row].completeToggled()
      self.todos[indexPath.row] = todo
      
      let cell = tableView.cellForRow(at: indexPath) as! CheckTableViewCell
      cell.set(checked: todo.isComplete)
      
      complete(true)
      
      print("complete")
    }
    return UISwipeActionsConfiguration(actions: [action])
  }
  
  
  func tableView(
    _ tableView: UITableView,
    editingStyleForRowAt indexPath: IndexPath
  ) -> UITableViewCell.EditingStyle {
    return .delete
  }
}



// MARK: - Table data source

extension ToDoViewController: UITableViewDataSource {
  
  func tableView(_ tableView: UITableView,
                 numberOfRowsInSection section: Int) -> Int {
    return todos.count
  }
  
  
  func tableView(_ tableView: UITableView,
                 cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueReusableCell(withIdentifier: K.Cells.cellWithIdentifierCheckedCell,
                                             for: indexPath) as! CheckTableViewCell
    
    cell.delegate = self
    let todo = todos[indexPath.row]
    cell.set(title: todo.title, checked: todo.isComplete)
    
    return cell
  }
  
  
  func tableView(_ tableView: UITableView,
                 commit editingStyle: UITableViewCell.EditingStyle,
                 forRowAt indexPath: IndexPath) {
    if editingStyle == .delete {
      todos.remove(at: indexPath.row)
      tableView.deleteRows(at: [indexPath], with: .automatic)
    }
  }
  
  
  func tableView(_ tableView: UITableView,
                 moveRowAt sourceIndexPath: IndexPath,
                 to destinationIndexPath: IndexPath) {
    let todo = todos.remove(at: sourceIndexPath.row)
    todos.insert(todo, at: destinationIndexPath.row)
  }
  
  
  func tableView(_ tableView: UITableView,
                 didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
  }
  
  
  func addTask(title: String, isComplete: Bool) {
    let todo = Todo(title: title, isComplete: isComplete)
    ref.addDocument(data: ["title": todo.title, "isComplete": todo.isComplete]) { error in
      if let error  = error {
        print(error)
        return
      }
      
      print("Successs")
      self.todos.insert(todo, at: 0)
      self.tableView.reloadData()
    }
  }
}



extension ToDoViewController: CheckTableViewCellDelegate {
  
  func checkTableViewCell(_ cell: CheckTableViewCell, didChagneCheckedState checked: Bool) {
    guard let indexPath = tableView.indexPath(for: cell) else {
      return
    }
    let todo = todos[indexPath.row]
    let newTodo = Todo(title: todo.title, isComplete: checked)
    todos[indexPath.row] = newTodo
  }
}


extension ToDoViewController: AddTaskViewControllerDelegate {
  
  func todoViewController(_ vc: AddTaskViewController, didSaveTodo todo: Todo) {
    dismiss(animated: true) {
      if let indexPath = self.tableView.indexPathForSelectedRow {
        // update
        self.todos[indexPath.row] = todo
        self.tableView.reloadRows(at: [indexPath], with: .none)
      } else {
        // create
        self.todos.append(todo)
        self.tableView.insertRows(at: [IndexPath(row: self.todos.count-1,
                                                 section: 0)],
                                  with: .automatic)
        self.tableView.reloadData()
        self.persistTodoToFireStore(todo)

      }
    }
  }
}



extension ToDoViewController: UIAdaptivePresentationControllerDelegate {
  
  func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
    if let indexPath = tableView.indexPathForSelectedRow {
      tableView.deselectRow(at: indexPath, animated: true)
    }
  }
}


// MARK: - Calendar data source and delegate

extension ToDoViewController: FSCalendarDataSource,
                              FSCalendarDelegate {
  
  func calendar(_ calendar: FSCalendar,
                boundingRectWillChange bounds: CGRect,
                animated: Bool) {
    calendarHeightConstraint.constant = bounds.height
    
    view.layoutIfNeeded()
  }
}


// MARK: - Setup calendar

extension ToDoViewController {
  
  func setCalendarConstraints() {
    view.addSubview(calendar)
    
    calendarHeightConstraint = NSLayoutConstraint(item: calendar,
                                                  attribute: .height,
                                                  relatedBy: .equal,
                                                  toItem: nil,
                                                  attribute: .notAnAttribute,
                                                  multiplier: 1,
                                                  constant: 200)
    calendar.addConstraint(calendarHeightConstraint)
    
    
    NSLayoutConstraint.activate([
      calendar.topAnchor
        .constraint(equalTo: view.topAnchor, constant: 90),
      calendar.leadingAnchor
        .constraint(equalTo: view.leadingAnchor, constant: 0),
      calendar.trailingAnchor
        .constraint(equalTo: view.trailingAnchor, constant: 0)
    ])
    
    calendar.translatesAutoresizingMaskIntoConstraints = false
    calendar.scope = .week
  }
}


extension ToDoViewController {
  
  fileprivate func persistTodoToFireStore(_ todo: Todo) {
    var data: [String: Any] = [:]
    data["title"] = todo.title
    data["isComplete"] = false
    
    MainThread.run {
      self.todos.insert(todo, at: 0)
      self.tableView.performBatchUpdates {
        self.tableView.insertRows(at: [IndexPath(row: 0, section: 0)], with: .automatic)
      } completion: { _ in }
    }
  }
}
