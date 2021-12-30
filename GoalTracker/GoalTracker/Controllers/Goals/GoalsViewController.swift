//
//  GoalsViewController.swift
//  GoalTracker
//
//  Created by Maha S on 27/12/2021.
//

import UIKit

class GoalsViewController: UIViewController {
  
  var goals = [Goal]()
  let customAlert = MyAlert()
  
  @IBOutlet weak var tableView: UITableView!
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
  
  }
  
  
  @IBAction func didTapButton() {
    
    customAlert.showAlert(with: "Congratulations!",
                          message: "You completed the Goal.",
                          on: self)
  }
  
  
  @objc func dismissAlert() {
    customAlert.dismissAlert()
  }
  
  
  @IBAction func startEditing(_ sender: Any) {
    tableView.isEditing = !tableView.isEditing
  }
  
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
  
  
  func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
    return .delete
  }
}


extension GoalsViewController: UITableViewDataSource {
  
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return goals.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueReusableCell(withIdentifier: "GoalViewCell", for: indexPath) as! GoalsTableViewCell
    
    cell.delegate = self
    
    let goal = goals[indexPath.row]
    cell.set(title: goal.title, checked: goal.isComplete)
    return cell
  }
  
  
  func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    
    if editingStyle == .delete {
      goals.remove(at: indexPath.row)
      tableView.deleteRows(at: [indexPath], with: .automatic)
    }
  }
  
  
  func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
    let goal = goals.remove(at: sourceIndexPath.row)
    goals.insert(goal, at: destinationIndexPath.row)
  }
  
}


extension GoalsViewController: GoalsTableViewCellDelegate {
  
  func goalsTableViewCell(_ cell: GoalsTableViewCell, didChagneCheckedState checked: Bool) {
    guard let indexPath = tableView.indexPath(for: cell) else {
      return
    }
    let goal = goals[indexPath.row]
    let newGoal = Goal(title: goal.title, isComplete: checked)
    goals[indexPath.row] = newGoal
    
  }
}


extension GoalsViewController: AddGoalViewControllerDelegate {
  
  func addGoalViewController(_ vc: AddGoalViewController, didSaveGoal goal: Goal) {
    
    dismiss(animated: true) {
      if let indexPath = self.tableView.indexPathForSelectedRow {
        
        self.goals[indexPath.row] = goal
        self.tableView.reloadRows(at: [indexPath], with: .none)
        
      } else {
        self.goals.append(goal)
        self.tableView.insertRows(at: [IndexPath(row: self.goals.count-1, section: 0)], with: .automatic)
        self.tableView.reloadData()
      }
    }
  }
}


extension GoalsViewController: UIAdaptivePresentationControllerDelegate {
  
  func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
    
    if let indexPath = tableView.indexPathForSelectedRow {
      tableView.deselectRow(at: indexPath, animated: true)
      
    }
  }
}


class MyAlert{
  
  struct Constants {
    static let backgroundAlphaTo: CGFloat = 0.6
  }
  
  private let backgroundView: UIView = {
    let backgroundView = UIView()
    backgroundView.backgroundColor = .lightGray
    backgroundView.alpha = 0
    return backgroundView
  }()
  
  
  private let alertView : UIView = {
    let alert = UIView()
    alert.backgroundColor = .white
    alert.layer.masksToBounds = true
    alert.layer.cornerRadius = 12
    return alert
  }()
  
  
  private var mytargetView: UIView?
  
  func showAlert(with title: String,
                 message: String,
                 on viewController: UIViewController) {
    guard let targetView = viewController.view else {
      return
    }
    
    mytargetView = targetView
    
    backgroundView.frame = targetView.bounds
    targetView.addSubview(backgroundView)
    
    targetView.addSubview(alertView)
    alertView.frame = CGRect(x: 40,
                             y: -250,
                             width: targetView.frame.size.width-80,
                             height: 250)
    
    let titleLabel = UILabel(frame: CGRect(x: 0,
                                           y: 0,
                                           width: alertView.frame.size.width,
                                           height: 80))
    titleLabel.text = title
    titleLabel.font = .systemFont(ofSize: 25)
    titleLabel.textAlignment = .center
    alertView.addSubview(titleLabel)
    
    
    let button = UIButton(frame: CGRect(x: 0,
                                        y: alertView.frame.size.height-50,
                                        width: alertView.frame.size.width,
                                        height: 50))
    
    button.setTitle("Dismiss", for: .normal)
    button.setTitleColor(.link, for: .normal)
    button.addTarget(self,
                     action: #selector(dismissAlert),
                     for: .touchUpInside)
    alertView.addSubview(button)
    
    let messageLabel = UILabel(frame: CGRect(x: 0,
                                             y: 80,
                                             width: alertView.frame.size.width,
                                             height: 100))
    messageLabel.text = message
    messageLabel.textAlignment = .center
    messageLabel.numberOfLines = 0
    alertView.addSubview(messageLabel)
    
    
    UIView.animate(withDuration: 0.20, animations: {
      self.backgroundView.alpha = Constants.backgroundAlphaTo
      
    }, completion: { done in
      if done {
        
        UIView.animate(withDuration: 0.20, animations: {
          self.alertView.center = targetView.center
        })
      }
    })
  }
  
  
  @objc func dismissAlert() {
    
    guard let targetView = mytargetView else {
      return
    }
    
    UIView.animate(withDuration: 0.20,
                   animations: {
      self.alertView.frame = CGRect(x: 40,
                                    y: -250,
                                    width: targetView.frame.size.width-80,
                                    height: 250)
    }, completion: { done in
      if done {
        UIView.animate(withDuration: 0.20, animations: {
          self.alertView.center = targetView.center
          self.backgroundView.alpha = 0
        }, completion: { done in
          if done {
            self.alertView.removeFromSuperview()
            self.backgroundView.removeFromSuperview()
          }
        })
      }
    })
  }
  
}
