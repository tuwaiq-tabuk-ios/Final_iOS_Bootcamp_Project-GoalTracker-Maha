//
//  AddGoalViewController.swift
//  GoalTracker
//
//  Created by Maha S on 27/12/2021.
//

import UIKit

class GoalCategoryViewController: UIViewController {
  
  
  @IBOutlet weak var collectionView: UICollectionView!
  weak var addGoalDelegate: AddGoalViewControllerDelegate?
  
  
  @IBSegueAction func addGaol(_ coder: NSCoder, sender: Any?) -> AddGoalViewController? {
    let addGoalVC = AddGoalViewController(coder: coder)
    addGoalVC?.delegate = addGoalDelegate
    return addGoalVC
  }
  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.addSubview(collectionView)

    collectionView.dataSource = self
    collectionView.delegate = self
    
    collectionView.collectionViewLayout = UICollectionViewFlowLayout()
  }
  
}


extension GoalCategoryViewController: UICollectionViewDataSource {
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return cg.count
    
  }
  
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GoalsViewCell", for: indexPath) as! CategoryCollectionViewCell
    cell.setup(with: cg[indexPath.row])
    cell.layer.cornerRadius = 20
    return cell
  }
}


extension GoalCategoryViewController: UICollectionViewDelegateFlowLayout {

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

    return CGSize(width: collectionView.frame.width/2.1, height: collectionView.frame.width/2.1)
  }
}


extension GoalCategoryViewController: UICollectionViewDelegate {
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    print(cg[indexPath.row].title)
  }
}
