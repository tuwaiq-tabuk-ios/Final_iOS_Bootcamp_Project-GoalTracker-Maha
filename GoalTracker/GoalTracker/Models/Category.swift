//
//  Goals.swift
//  GoalTracker
//
//  Created by Maha S on 27/12/2021.
//

import UIKit

struct Category {
  
  let title: String
  let image: UIImage
  
}

   // cg = shortcut for category

let cg: [Category] = [
  Category(title: "Career & Work", image: UIImage(named: "Career")!),
  Category(title: "Finance & Money", image: UIImage(named: "Money")!),
  Category(title: "Lifestyle", image: UIImage(named: "LifeStyle")!),
  Category(title: "Reading", image: UIImage(named: "Reading")!),
  Category(title: "Meditation", image: UIImage(named: "Meditation")!),
  Category(title: "Working out", image: UIImage(named: "Workingout")!)
]


