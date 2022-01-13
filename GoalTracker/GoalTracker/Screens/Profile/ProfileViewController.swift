//
//  ProfileViewController.swift
//  GoalTracker
//
//  Created by Maha S on 06/01/2022.
//

import UIKit
import Firebase

class ProfileViewController: UIViewController {
  
  let db = Firestore.firestore()
  
  @IBOutlet weak var firstName: UITextView!
  @IBOutlet weak var lastName: UITextView!
  @IBOutlet weak var logOut: UIButton!
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setUpElement()
    
    guard let uid = Auth.auth().currentUser?.uid, !uid.isEmpty else {
      return
    }
    FirebaseManager.shared.fetchUserInfo(using: uid) { result in
      switch result {
      case .failure(let error):
        print(error)
        
      case .success(let snapshot):
        if let data = snapshot.documents.first {
          let firstName = data["firstname"] as? String
          let lastName = data["lastname"] as? String
          self.firstName.text = firstName
          self.lastName.text = lastName
        }
      }
    }
  }
  
  
  @IBAction func signOutPressed(_ sender: Any) {
    do {
      try Auth.auth().signOut()
      if let mainViewController: MainViewController = UIStoryboard.main.instantiate()  {
        view.window?.rootViewController = mainViewController
      }
    } catch let signOutError as NSError {
      print("Error signing out: %@", signOutError)
    }
  }
  
    
  func setUpElement() {
    Utilities.styleTextView(firstName)
    Utilities.styleTextView(lastName)
    Utilities.styleFilledButton(logOut)
    
  }
}


final class FirebaseManager {
  enum FirebaseError: String, Error {
    case noData = "Snapshot doesn't contain any data!!!"
  }
  
  static let shared = FirebaseManager()
  private let db = Firestore.firestore()
  
  private init() {}
  
  func fetchUserInfo(using uid: String,
                     then: ((Result<QuerySnapshot, Error>) -> Void)?) {
    db.collection("users").whereField("uid", isEqualTo: uid)
      .addSnapshotListener { (querySnapshot, error) in
        MainThread.run {
          if let error = error {
            then?(.failure(error))
            return
          }
          
          if let snapshot = querySnapshot {
            then?(.success(snapshot))
            return
          }
          
          then?(.failure(FirebaseError.noData))
        }
      }
  }
 
  func fetchGoals(_ completion: ((Result<[Goal], Error>) -> Void)?) {
    db.collection("Goals").getDocuments { snapshot, error in
      MainThread.run {
        if let error = error {
          completion?(.failure(error))
          return
        }
        
        let documents = snapshot?.documents ?? []
        let goals = documents.map { Goal(document: $0) }.sorted(by: { $0.date > $1.date })
        completion?(.success(goals))
      }
    }
  }
}
