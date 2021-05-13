//
//  ViewController.swift
//  Games
//
//  Created by period2 on 4/5/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var labelOne: UILabel!
    @IBOutlet weak var labelTwo: UILabel!
    @IBOutlet weak var labelThree: UILabel!
    @IBOutlet weak var labelFour: UILabel!
    @IBOutlet weak var labelFive: UILabel!
    @IBOutlet weak var labelSix: UILabel!
    @IBOutlet weak var labelSeven: UILabel!
    @IBOutlet weak var labelEight: UILabel!
    @IBOutlet weak var labelNine: UILabel!
    
    @IBOutlet weak var viewThing: UIView!
    
    @IBOutlet weak var turnLabel: UILabel!
    
    var allLabels: [UILabel] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
  
        allLabels = [labelOne, labelTwo, labelThree, labelFour, labelFive, labelSix, labelSeven, labelEight, labelNine]
        
        turnLabel.text = "X"
    }

    @IBAction func tapGesture(_ sender: UITapGestureRecognizer)
    {
        let selectedPoint = sender.location(in: viewThing)
        for label in allLabels
        {
            if label.frame.contains(selectedPoint)
            {
                placeInToLabel(myLabel: label)
               
            }
        }
    
      checkForWinner()
    
    }
    func placeInToLabel(myLabel: UILabel) {
        if myLabel.text == "" {
            if turnLabel.text == "X" {
            myLabel.text = turnLabel.text
            turnLabel.text = "O"
        }
        else {
            myLabel.text = turnLabel.text
            turnLabel.text = "X"
             }
        }
    }
    func checkForWinner()
 
 {
    if labelOne.text == labelTwo.text && labelTwo.text == labelThree.text && labelOne.text != ""
    {
 alert()
}

    else if labelOne.text == labelFour.text && labelFour.text == labelSeven.text && labelOne.text != ""
        
    {
   alert()
}
    else if labelTwo.text == labelFive.text && labelFive.text == labelEight.text && labelTwo.text != ""
        
{
  alert()
    }
    
    else if labelThree.text == labelSix.text && labelSix.text == labelNine.text && labelThree.text != ""
        
        
        {
     alert()
    }
    else if labelFour.text == labelFive.text && labelFive.text == labelSix.text && labelFour.text != ""
        
        {
       alert()
    }

    else if labelSeven.text == labelEight.text && labelEight.text == labelNine.text && labelSeven.text != ""
        
        {
       alert()
    }
    
    else if labelOne.text == labelFive.text && labelFive.text == labelNine.text && labelOne.text != ""
        
        {
       alert()
    }
   
    else if labelThree.text == labelFive.text && labelFive.text == labelSeven.text && labelThree.text != ""
        
        
        {
      alert()
    }
    
}
    func alert () {
        let winnerAlert = UIAlertController(title: "You Won!!!", message: "Something the Bears can't do!!", preferredStyle: .alert)
        let winningButton = UIAlertAction(title: "New Game?", style: .default) { (action) in self.reset()
            
        }
        winnerAlert.addAction(winningButton)
        present(winnerAlert, animated: true, completion: nil)
        
    }
    
    
    
    
    @IBAction func resetButton(_ sender: UIButton){
        reset()
    }
  
    
    
    func reset() {
        for label in allLabels{
            label.text = ""
        }
    
    }
}


