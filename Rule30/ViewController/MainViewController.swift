//
//  MainViewController.swift
//  Rule30
//
//  Created by Greg Hughes on 12/15/20.
//

import UIKit

class MainViewController: UIViewController {
    
    var drawerView : UIView!
    var drawerPanGestureRecognizer : UIPanGestureRecognizer!
    lazy var topDrawerTarget = self.view.frame.maxY * 0.40
    lazy var bottomDrawerTarget = self.view.frame.maxY * 0.92
    var drawerIsOpen = false
    var controlsVC : ControlsViewController!
    var r30VC : Rule30ViewController!
    @IBOutlet weak var containerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setDrawerFunctionality()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
    }
}

extension MainViewController {
    func setupViewControllers() {
        
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        r30VC = (storyboard.instantiateViewController(withIdentifier: "Rule30ViewController") as! Rule30ViewController)
        containerView.addSubview(r30VC.view)
        r30VC.view.frame = containerView.bounds
        
        controlsVC = {

            let viewController = storyboard.instantiateViewController(withIdentifier: "ControlsViewController") as! ControlsViewController
            viewController.viewModel = r30VC.viewModel
            viewController.view.frame = drawerView.bounds
            viewController.view.layer.cornerRadius = 10
            viewController.view.layer.borderWidth = 1
            viewController.view.layer.borderColor = #colorLiteral(red: 0.2134257277, green: 0.2134257277, blue: 0.2134257277, alpha: 1)
            viewController.view.layer.masksToBounds = true


            return viewController
        }()
    }
    

    
    // MARK: - SetDrawerFunctionality
    func setDrawerFunctionality(){
        drawerView = createDrawerView()
        setupViewControllers()
        
        drawerView.addSubview(controlsVC.view)
        self.view.addSubview(drawerView)
        
        drawerPanGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(panGestureActivated))
        drawerPanGestureRecognizer.cancelsTouchesInView = false
        drawerView.addGestureRecognizer(drawerPanGestureRecognizer)
    }
    
    func createDrawerView() -> UIView {
        
        let width = self.view.frame.width
        let height = self.view.frame.height * 0.9
        let x = CGFloat(0.0)
        let y = bottomDrawerTarget
        
        let frame = CGRect(x: x, y: y, width: width, height: height)
        
        let drawerView = UIView(frame: frame)
        drawerView.backgroundColor = .blue
        
        return drawerView
    }
    
    @objc func panGestureActivated(_ sender: UIPanGestureRecognizer) {
        
        switch drawerPanGestureRecognizer.state {
            
        case .began:
            
            panDrawer(withPanPoint: CGPoint(x: drawerView.center.x, y: drawerView.center.y + drawerPanGestureRecognizer.translation(in: drawerView).y))
            
            drawerPanGestureRecognizer.setTranslation(CGPoint.zero, in: drawerView)
            
        case .changed:
            
            panDrawer(withPanPoint: CGPoint(x: drawerView.center.x, y: drawerView.center.y + drawerPanGestureRecognizer.translation(in: drawerView).y))
            drawerPanGestureRecognizer.setTranslation(CGPoint.zero, in: drawerView)
            
        case .ended:
            
            drawerPanGestureRecognizer.setTranslation(CGPoint.zero, in: drawerView)
            panDidEnd()
            
        default:
            return
        }
    }
    
    
    func panDrawer(withPanPoint panPoint: CGPoint) {
        
        if drawerView.frame.maxY < self.view.frame.maxY * 1.3 {
            
            drawerView.center.y += drawerPanGestureRecognizer.translation(in: drawerView).y / 100
            
        } else {
            drawerView.center.y += drawerPanGestureRecognizer.translation(in: drawerView).y
        }
    }
    
    
    func panDidEnd() {
        let aboveHalfWay = drawerView.frame.minY < ((self.view.frame.maxY) * 0.75)
        let velocity = drawerPanGestureRecognizer.velocity(in: drawerView).y
        if velocity > 400 {
            self.closeDrawer()
        } else if velocity < -400 {
            self.openDrawer()
        } else if aboveHalfWay {
            self.openDrawer()
        } else if !aboveHalfWay {
            self.closeDrawer()
        }
    }
    
    
    func openDrawer() {
        
        let target = topDrawerTarget
        
        self.userInteractionAnimate(view: drawerView, edge: drawerView.frame.minY, to: target, velocity: drawerPanGestureRecognizer.velocity(in: drawerView).y) {[weak self] (complete) in
            self?.drawerIsOpen = true
        }
        
    }
    
    func closeDrawer() {
        
        let target = bottomDrawerTarget
        
        self.userInteractionAnimate(view: drawerView, edge: drawerView.frame.minY, to: target, velocity: drawerPanGestureRecognizer.velocity(in: drawerView).y) {[weak self] (complete) in
            self?.drawerIsOpen = false
        }
    }
    
    fileprivate func userInteractionAnimate(view: UIView, edge: CGFloat, to target: CGFloat, velocity: CGFloat, completion: @escaping (Bool?) -> Void) {
        let distanceToTranslate = target - edge
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.97, initialSpringVelocity: abs(velocity) * 0.01, options: .curveEaseOut , animations: {
            
            //Sets view to new location (target
            view.frame =  view.frame.offsetBy(dx: 0, dy: distanceToTranslate)
            
        }, completion: { (success) in
            
            completion(true)
        })
    }
    
    @objc func drawerTogglePosition(){
        
        if Int(drawerView.frame.origin.y) == Int(topDrawerTarget) {
            
            closeDrawer()
            
        } else {
            openDrawer()
        }
    }
}
