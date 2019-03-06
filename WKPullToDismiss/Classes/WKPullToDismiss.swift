//
//  WKPullToDismiss.swift
//
//  Created by Wojtek Kordylewski on 04.03.19.
//  Copyright (c) 2019 Wojtek Kordylewski. All rights reserved.
//

import UIKit

public class WKPullToDismiss: NSObject {
    private unowned let viewController: UIViewController
    private unowned let dismissView: UIView
    
    /// Interaction Controller which is used to handle the transition.
    public let interactionController = PullToDismissInteractionController()
    
    /// The Pan Gesture Recognizer that triggers the transition.
    public var panGestureRecognizer: UIPanGestureRecognizer
    
    /// Defines if the pan gesture recognizer is supposed to trigger the transition. Default is `true`.
    public var isEnabled = true
    
    /// If you are using a Scrollview as view for dismissal you can set a custom offset (Y value) at which the transition is supposed to be triggered.
    /// By default the respective Scrollview's contentInset.top value is used.
    public var customScrollTriggerValue: CGFloat?
    
    /**
     The single initializer. A if you pass `UIScrollView` as `dismissView` parameter, the scrollviews `UIPanGestureRecognizer` will be used to trigger the dismissal. Otherwise, a new `UIPanGestureRecognizer` will be created and added to the `dismissal` view. Make sure that other gesture recognizers do not interfere.
     - Parameter viewController: The `UIViewController` to perform the dismissal on.
     - Parameter dismissView: The view which is supposed to trigger the dismissal. Can be regular `UIView` or any subclass, as well as a `UIScrollView`
    */
    public init(viewController: UIViewController, dismissView: UIView) {
        self.viewController = viewController
        self.dismissView = dismissView
        if let scroll = dismissView as? UIScrollView {
            panGestureRecognizer = scroll.panGestureRecognizer
        }
        else {
            let pan = UIPanGestureRecognizer()
            dismissView.addGestureRecognizer(pan)
            panGestureRecognizer = pan
        }
        super.init()
        panGestureRecognizer.addTarget(self, action: #selector(pan(_:)))
        if let nav = viewController.navigationController {
            nav.transitioningDelegate = self
        }
        else {
            viewController.transitioningDelegate = self
        }
    }
    
    @objc private func pan(_ panGestureRecognizer: UIPanGestureRecognizer) {
        let translation = panGestureRecognizer.translation(in: panGestureRecognizer.view!)
        let velocity = panGestureRecognizer.velocity(in: panGestureRecognizer.view!)
        var progress = (translation.y / viewController.view.bounds.height)
        progress = CGFloat(fminf(fmaxf(Float(progress), 0.0), 1.0))
        switch panGestureRecognizer.state {
        case .began:
            if velocity.y > 0 && isEnabled {
                if let scroll = dismissView as? UIScrollView, scroll.contentOffset.y > scroll.contentInset.top {
                    let trigger = customScrollTriggerValue ?? scroll.contentInset.top
                    if scroll.contentOffset.y > trigger { return }
                }
                interactionController.started = true
                viewController.dismiss(animated: true, completion: nil)
            }
        case .changed:
            interactionController.handle(progress: progress)
        case .ended:
            interactionController.finishState()
        case .cancelled:
            interactionController.cancelState()
        default:
            break
        }
    }
}

extension WKPullToDismiss: UIViewControllerTransitioningDelegate {
    public func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return interactionController.started ? PullToDismissAnimationController() : nil
    }
    
    public func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return interactionController.started ? interactionController : nil
    }
}

public class PullToDismissAnimationController: NSObject, UIViewControllerAnimatedTransitioning {
    /// The Duration of the transition. Default value is `0.5`.
    public var transitionDuration: TimeInterval = 0.5
    public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return transitionDuration
    }
    
    public func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from), let toViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to) else { return }
        let containerView = transitionContext.containerView
        containerView.insertSubview(toViewController.view, at: 0)
        let screenBounds = UIScreen.main.bounds
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
            fromViewController.view.frame = CGRect(origin: CGPoint(x: 0, y: screenBounds.height), size: screenBounds.size)
        }) { (finished) in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
    }
}

public class PullToDismissInteractionController: UIPercentDrivenInteractiveTransition {
    /// Tells whether the transition has started or not.
    public var started = false
    
    /// The percentage which has to be completed in order to finish the transition. Default value is `0.3`.
    public var dismissThreshold: CGFloat = 0.3
    
    private var canFinish = false
    
    func handle(progress: CGFloat) {
        canFinish = progress > dismissThreshold
        update(progress)
    }
    func cancelState() {
        started = false
        cancel()
    }
    func finishState() {
        started = false
        canFinish ? finish() : cancel()
    }
}
