//
//  Checkbox.swift
//  GoalTracker
//
//  Created by Maha S on 15/12/2021.
//

import UIKit

@IBDesignable
class Checkbox: UIControl {
  
  // MARK: - Properties
  
  private weak var imageView: UIImageView!
  
  private var image: UIImage {
    return checked ? UIImage(systemName: "checkmark.square.fill")! : UIImage(systemName: "square")!
  }
  
  
  @IBInspectable
  public var checked: Bool = false {
    didSet {
      imageView.image = image
    }
  }
  
  // MARK: - Init
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setup()
  }
  
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    setup()
  }
  
  // MARK: - Methodsx
  
  private func setup() {
    let imageView = UIImageView()
    imageView.translatesAutoresizingMaskIntoConstraints = false
    addSubview(imageView)
    
    imageView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
    imageView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    imageView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
    imageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
    
    imageView.image = image
    imageView.contentMode = .scaleAspectFit
    
    self.imageView = imageView
    
    backgroundColor = UIColor.clear
    
    addTarget(self, action: #selector(touchUpInside), for: .touchUpInside)
  }
  
  
  @objc func touchUpInside() {
    checked = !checked
    sendActions(for: .valueChanged)
  }
  
}
