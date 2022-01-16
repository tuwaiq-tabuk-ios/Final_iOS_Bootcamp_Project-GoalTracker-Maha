//
//  IndicatorView.swift
//  GoalTracker
//
//  Created by Maha S on 16/01/2022.
//

import UIKit


final class LoadingView: UIView {
  
  // MARK: - Properties
  
  private lazy var indicatorView: UIActivityIndicatorView = {
    let indicatorView = UIActivityIndicatorView()
    indicatorView.style = .medium
    indicatorView.color = .black
    return indicatorView
  }()
  
  // MARK: - Init
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    indicatorView.translatesAutoresizingMaskIntoConstraints = false
    addSubview(indicatorView)
    indicatorView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    indicatorView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
  }
  
  required init?(coder: NSCoder) {
    fatalError()
  }
  
  // MARK: - Actions
  
  final func startAnimating() {
    indicatorView.startAnimating()
  }
  
  final func stopAnimating() {
    indicatorView.stopAnimating()
  }
}

final class LoadingViewController: UIViewController {
  
  // MARK: - Properties
  
  private lazy var loadingView = LoadingView()
  
  
  
  init() {
    super.init(nibName: nil, bundle: nil)
    
    modalPresentationStyle = .overCurrentContext
    modalTransitionStyle = .crossDissolve
  }
  
  required init?(coder: NSCoder) {
    fatalError()
  }
  
  // MARK: - Lifecycle
  
  override func loadView() {
    super.loadView()
    
    view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
    loadingView.startAnimating()
    view.addSubview(loadingView)
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    
    loadingView.frame = view.bounds
  }
  
  static func show(from viewController: UIViewController,
                   _ animated: Bool = true,
                   completion: (() -> Void)? = nil) {
    let loadingViewController: LoadingViewController = .init()
    viewController.present(loadingViewController, animated: animated, completion: completion)
  }
}

