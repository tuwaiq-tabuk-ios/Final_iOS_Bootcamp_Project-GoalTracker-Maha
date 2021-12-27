//
//  Goals.swift
//  GoalTracker
//
//  Created by Maha S on 27/12/2021.
//

import UIKit


struct Goal {
  
  let title: String
  let image: UIImage
  
}

let goals: [Goal] = [
  Goal(title: "Career&Work", image: UIImage(named: "Career")!),
  Goal(title: "Finance&Money", image: UIImage(named: "Money")!),
  Goal(title: "LifeStyle", image: UIImage(named: "LifeStyle")!),
  Goal(title: "WorkingOut", image: UIImage(named: "Workingout")!),
  Goal(title: "Meditation", image: UIImage(named: "Meditation")!),
  Goal(title: "Reading", image: UIImage(named: "Reading")!)
]
