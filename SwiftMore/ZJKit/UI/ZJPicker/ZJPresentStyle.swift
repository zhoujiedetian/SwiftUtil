//
//  ZJPresentStyle.swift
//  SwiftMore
//
//  Created by 精灵要跳舞 on 2019/6/19.
//  Copyright © 2019 精灵要跳舞. All rights reserved.
//

import UIKit

class ZJPresentStyle: UIPresentationController {
    
    lazy var blackView : UIView = {
        let view = UIView()
        if let frame = self.containerView?.frame {
            view.frame = frame
        }
        view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        return view
    }()
    
    override var frameOfPresentedViewInContainerView: CGRect {
        return CGRect(x: 0, y: KScreenHeight - 300, width: KScreenWidth, height: 300)
    }
    
    override init(presentedViewController: UIViewController, presenting presentingViewController: UIViewController?) {
        super.init(presentedViewController: presentedViewController, presenting: presentingViewController)
    }
    
    override func presentationTransitionWillBegin() {
        blackView.alpha = 0
        containerView?.addSubview(blackView)
        UIView.animate(withDuration: 0.5) {
            self.blackView.alpha = 1
        }
    }
    
    override func dismissalTransitionWillBegin() {
        UIView.animate(withDuration: 0.5) {
            self.blackView.alpha = 0
        }
    }
    
    override func dismissalTransitionDidEnd(_ completed: Bool) {
        if completed {
           blackView.removeFromSuperview()
        }
    }
}

extension UIViewController : UIViewControllerTransitioningDelegate{
    @objc func presentVCByCustom(vc: UIViewController) {
        vc.modalPresentationStyle = .custom
        vc.transitioningDelegate = self
        self.present(vc, animated: true, completion: nil)
    }
    
    public func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        let datePicker = ZJPresentStyle.init(presentedViewController: presented, presenting: presenting)
        return datePicker
    }
}
