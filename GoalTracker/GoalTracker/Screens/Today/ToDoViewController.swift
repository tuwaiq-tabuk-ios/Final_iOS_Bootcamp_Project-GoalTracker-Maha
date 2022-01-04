//
//  ViewController.swift
//  GoalTracker
//
//  Created by Maha S on 15/12/2021.
//
import Firebase
import FirebaseFirestore
import UIKit
import FSCalendar


class ToDoViewController: UIViewController {
  
  var todos = [Todo]()
  var calendarHeightConstraint:NSLayoutConstraint!
  
  @IBOutlet weak var tableView: UITableView!
  
  private var calendar: FSCalendar = {
    let calendar = FSCalendar()
    calendar.translatesAutoresizingMaskIntoConstraints = false
    return calendar
  }()
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setConstraints()
    calendar.delegate = self
    calendar.dataSource = self
    calendar.scope = .week
    let db = Firestore.firestore()
    
    db.collection("users").getDocuments() { (querySnapshot, err) in
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
}


extension ToDoViewController: UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
    
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
  
  
  func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
    return .delete
  }
}


extension ToDoViewController: UITableViewDataSource {

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return todos.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueReusableCell(withIdentifier: "checked cell", for: indexPath) as! CheckTableViewCell
    
    cell.delegate = self
    let todo = todos[indexPath.row]
    cell.set(title: todo.title, checked: todo.isComplete)
    
    return cell
  }
  
  
  func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    if editingStyle == .delete {
      todos.remove(at: indexPath.row)
      tableView.deleteRows(at: [indexPath], with: .automatic)
    }
  }
  
  
  func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
    let todo = todos.remove(at: sourceIndexPath.row)
    todos.insert(todo, at: destinationIndexPath.row)
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
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
        self.tableView.insertRows(at: [IndexPath(row: self.todos.count-1, section: 0)], with: .automatic)
        self.tableView.reloadData()
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


extension ToDoViewController: FSCalendarDataSource, FSCalendarDelegate {
  func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {
    calendarHeightConstraint.constant = bounds.height
    view.layoutIfNeeded()
  }
  
}

extension ToDoViewController {
  
  func setConstraints() {
    view.addSubview(calendar)
    
    calendarHeightConstraint = NSLayoutConstraint(item: calendar, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 200)
    calendar.addConstraint(calendarHeightConstraint)
    
    
    NSLayoutConstraint.activate([
      calendar.topAnchor.constraint(equalTo: view.topAnchor, constant: 90),
      calendar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
      calendar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0)

    ])
    
  }
}
