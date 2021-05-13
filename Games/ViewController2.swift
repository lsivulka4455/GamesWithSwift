//
//  ViewController2.swift
//  Games
//
//  Created by period2 on 4/27/21.
//

import UIKit
import AVFoundation

class ViewController2: UIViewController, UICollisionBehaviorDelegate {

    @IBOutlet weak var ballView: UIView!
    @IBOutlet weak var paddle: UIView!
    @IBOutlet weak var brickOne: UIView!
    @IBOutlet weak var brickTwo: UIView!
    @IBOutlet weak var brickThree: UIView!
    @IBOutlet weak var brickFour: UIView!
    @IBOutlet weak var brickFive: UIView!
    @IBOutlet weak var brickSix: UIView!
    @IBOutlet weak var brickSeven: UIView!
    @IBOutlet weak var brickEight: UIView!
    @IBOutlet weak var brickNine: UIView!
    @IBOutlet weak var brickTen: UIView!
    @IBOutlet weak var brickEleven: UIView!
    @IBOutlet weak var brickTwelve: UIView!
    @IBOutlet weak var brickThirteen: UIView!
    @IBOutlet weak var brickFourteen: UIView!
    @IBOutlet weak var brickFifteen: UIView!
    
    var allBricks = [UIView] ()
    var dynamicAnimator: UIDynamicAnimator!
    var collisionBehavior: UICollisionBehavior!
    var pushBehavior: UIPushBehavior!
    var ballDynamicItem: UIDynamicItemBehavior!
    var paddleDynamicItem: UIDynamicItemBehavior!
    var brickDynamicItem: UIDynamicItemBehavior!
    var brickCount = 15
    
    @IBOutlet weak var startButtonOutlet: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ballView.layer.cornerRadius = 20
        allBricks = [brickOne, brickTwo, brickThree, brickFour, brickFive, brickSix, brickSeven, brickEight, brickNine, brickTen, brickEleven, brickTwelve, brickThirteen, brickFourteen, brickFifteen]
        ballView.isHidden = true
        paddle.isHidden = true
    }
    
    @IBAction func panGesture(_ sender: UIPanGestureRecognizer) {
        paddle.center = CGPoint(x: sender.location(in: view).x, y: paddle.center.y)
        dynamicAnimator.updateItem(usingCurrentState: paddle)
    }
    
    func dynamicBehaviors() {
        dynamicAnimator = UIDynamicAnimator(referenceView: view)
        pushBehavior = UIPushBehavior(items:[ballView], mode: .instantaneous)
        pushBehavior.active = true
        pushBehavior.setAngle(0.6, magnitude: 0.6)
        dynamicAnimator.addBehavior(pushBehavior)
        
        collisionBehavior = UICollisionBehavior(items: [ballView, paddle] + allBricks)
        collisionBehavior.translatesReferenceBoundsIntoBoundary = true
        collisionBehavior.collisionMode = .everything
        dynamicAnimator.addBehavior(collisionBehavior)
        
        collisionBehavior.collisionDelegate = self
        ballDynamicItem = UIDynamicItemBehavior(items: [ballView])
        ballDynamicItem.allowsRotation = true
        ballDynamicItem.elasticity = 1
        ballDynamicItem.friction = 0
        ballDynamicItem.resistance = 0
        dynamicAnimator.addBehavior(ballDynamicItem)
        
        paddleDynamicItem = UIDynamicItemBehavior(items: [paddle])
        paddleDynamicItem.density = 10000
        paddleDynamicItem.elasticity = 0.5
        paddleDynamicItem.allowsRotation = false
        dynamicAnimator.addBehavior(paddleDynamicItem)
        
        brickDynamicItem = UIDynamicItemBehavior(items: allBricks)
        brickDynamicItem.density = 10000
        brickDynamicItem.elasticity = 0.5
        dynamicAnimator.addBehavior(brickDynamicItem)
        
    }
    func collisionBehavior(_ behavior: UICollisionBehavior, beganContactFor item1: UIDynamicItem, with item2: UIDynamicItem, at p: CGPoint) {
        for brick in allBricks {
        if item1.isEqual(ballView) && item2.isEqual(brick){
            brick.isHidden = true
            collisionBehavior.removeItem(brick)
            brickCount -= 1
            
            }
            if brickCount == 0 {
                let addAlert = UIAlertController(title: "You Win!", message: nil, preferredStyle: .alert)
                let doneAction = UIAlertAction(title: "New Game?", style: .default) { (action) in
                    self.startButtonOutlet.isHidden = false
                    self.brickCount = 15
                    self.ballView.isHidden = true
                    self.collisionBehavior.removeItem(self.ballView)
                    for brick in self.allBricks{
                        brick.isHidden = false
                    }
                }
                addAlert.addAction(doneAction)
                present(addAlert, animated: true, completion: nil)
            }
        
        }
        
    }
    
    func collisionBehavior(_ behavior: UICollisionBehavior, beganContactFor item: UIDynamicItem, withBoundaryIdentifier identifier: NSCopying?, at p: CGPoint) {
        if p.y + 20 > paddle.center.y {
            alert()
        }
        
    }
   
    func alert(){
        let addAlert = UIAlertController(title: "You Suck!", message: nil, preferredStyle: .alert)
        let doneAction = UIAlertAction(title: "Try Again?", style: .default) { (action) in
        }
        addAlert.addAction(doneAction)
        present(addAlert, animated: true, completion: nil)
        
    }
        
    @IBAction func startButton(_ sender: UIButton) {
    dynamicBehaviors()
        sender.isHidden = true
        paddle.isHidden = false
        ballView.isHidden = false
        let synth = AVSpeechSynthesizer()
        let utterance = AVSpeechUtterance(string: "Game time, get ready to win")
        synth.speak(utterance)
    }
   
    func reset(){
        
    }
}
