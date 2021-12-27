//
//  AddGoalViewController.swift
//  GoalTracker
//
//  Created by Maha S on 27/12/2021.
//

import UIKit

class AddGoalViewController: UIViewController {
  
  
  @IBOutlet weak var collectionView: UICollectionView!
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.addSubview(collectionView)
    
    collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 40).isActive = true
    collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40).isActive = true
    collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 40).isActive = true
    collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 40).isActive = true
    
    
    collectionView.dataSource = self
    collectionView.delegate = self
    collectionView.collectionViewLayout = UICollectionViewFlowLayout()
  }

}


extension AddGoalViewController: UICollectionViewDataSource {
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return goals.count
    
  }
  
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GoalsViewCell", for: indexPath) as! GoalsViewCell
    cell.setup(with: goals[indexPath.row])
    
    return cell
  }
}


extension AddGoalViewController: UICollectionViewDelegateFlowLayout {

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

    return CGSize(width: collectionView.frame.width/2.1, height: collectionView.frame.width/2.1)
  }
}


extension AddGoalViewController: UICollectionViewDelegate {
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    print(goals[indexPath.row].title)
  }
}
