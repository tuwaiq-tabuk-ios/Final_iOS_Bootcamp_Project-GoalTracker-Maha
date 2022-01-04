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
    
    navigationItem.title = "Categories"
    navigationItem.largeTitleDisplayMode = .never
    view.addSubview(collectionView)

    collectionView.dataSource = self
    collectionView.delegate = self
    
    let layout = UICollectionViewFlowLayout()
    layout.minimumLineSpacing = 16
    layout.minimumInteritemSpacing = 16
    layout.sectionInset = .init(top: 0, left: 16, bottom: 0, right: 16)
    collectionView.collectionViewLayout = layout
  }
}


extension GoalCategoryViewController: UICollectionViewDataSource {
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return cg.count
    
  }
  
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GoalsViewCell", for: indexPath) as! CategoryCollectionViewCell
    cell.setup(with: cg[indexPath.row])
    cell.layer.masksToBounds = true
    cell.layer.cornerRadius = 20
    return cell
  }
}


extension GoalCategoryViewController: UICollectionViewDelegateFlowLayout {

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let availableWidth: CGFloat = (collectionView.bounds.width - 16*3)
    let width: CGFloat = availableWidth / 2
    return CGSize(width: width, height: width)
  }
}


extension GoalCategoryViewController: UICollectionViewDelegate {
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    print(cg[indexPath.row].title)
  }
}
