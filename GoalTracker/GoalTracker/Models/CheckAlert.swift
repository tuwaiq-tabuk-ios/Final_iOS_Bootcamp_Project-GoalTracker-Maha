//
//  CheckAlert.swift
//  GoalTracker
//
//  Created by Maha S on 02/01/2022.
//

import UIKit


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


    let button = UIButton(frame: CGRect(x: 20,
                                        y: alertView.frame.size.height-60,
                                        width: 270,
                                        height: 40))

    button.setTitle("Dismiss", for: .normal)
    button.setTitleColor(.link, for: .normal)
    button.layer.borderColor = UIColor.systemGray5.cgColor
    button.layer.borderWidth = 1
    button.layer.cornerRadius = 12
    button.backgroundColor = .systemGray5
    
    
    button.addTarget(self,
                     action: #selector(dismissAlert),
                     for: .touchUpInside)
    alertView.addSubview(button)


    let messageLabel = UILabel(frame: CGRect(x: 0,
                                             y: 70,
                                             width: alertView.frame.size.width,
                                             height: 80))
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
                                    y: targetView.frame.size.height,
                                    width: targetView.frame.size.width-80,
                                    height: 250)
    }, completion: { done in
      if done {
        UIView.animate(withDuration: 0.20, animations: {
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

