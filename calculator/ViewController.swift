//
//  ViewController.swift
//  calculator
//
//  Created by Meitar Basson on 27/05/2016.
//  Copyright © 2016 meitar. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    var sirenSound: AVAudioPlayer!
    @IBOutlet weak var display: UILabel!
    

    
    enum Operation: String{
        case Divide = "/"
        case Multiply = "*"
        case Add = "+"
        case Substract = "-"
        case Equals = "="
        case Empty = "Empty"
    }
    
    var result = ""
    var leftNum = ""
    var rightNum = ""
    var runningNum = ""
    var currentOperation: Operation = Operation.Empty
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let path = NSBundle.mainBundle().pathForResource("siren", ofType: "wav")
        let soundUrl = NSURL(fileURLWithPath: path!)
        
        do{
            try sirenSound = AVAudioPlayer(contentsOfURL: soundUrl)
            sirenSound.prepareToPlay()
        }catch let err as NSError{
            print(err.debugDescription)
        }
    
    }
    
    @IBAction func NumberPressed(btn: UIButton!){
        playSound()
        
        runningNum += "\(btn.tag)"
        display.text = runningNum
    }
    
    @IBAction func add(sender: UIButton) {
        proccessedOperation(Operation.Add)
        
    }
    
    @IBAction func substract(sender: UIButton) {
        proccessedOperation(Operation.Substract)
    }

    @IBAction func multiply(sender: UIButton) {
        proccessedOperation(Operation.Multiply)
    }
    
    @IBAction func divide(sender: UIButton) {
        proccessedOperation(Operation.Divide)
    }
    
    @IBAction func equal(sender: UIButton) {
        proccessedOperation(currentOperation)
    }
    
    @IBAction func clear(sender: UIButton) {
        display.text = "0"
        runningNum = ""
        rightNum = ""
        leftNum = ""
        result = ""
        currentOperation = Operation.Empty
    }
    
    func proccessedOperation(op: Operation){
        if currentOperation != Operation.Empty{
            
            if runningNum != ""{
                rightNum = runningNum
                if currentOperation == Operation.Add{
                    result = "\(Double(leftNum)! + Double(rightNum)! )"
                }else if currentOperation == Operation.Substract{
                    result = "\(Double(leftNum)! - Double(rightNum)! )"
                }else if currentOperation == Operation.Multiply{
                    result = "\(Double(leftNum)! * Double(rightNum)! )"
                }else if currentOperation == Operation.Divide{
                    if Double(rightNum) != 0{
                        result = "\(Double(leftNum)! / Double(rightNum)! )"
                    }
                }
                runningNum = ""
                leftNum = result
                display.text = result
                if Double(rightNum) == 0 {
                    display.text = "Meitar Basson"
                }
            }

            currentOperation = op
            
            // Run Some Math 
        }else {
            if runningNum != ""{
                leftNum = runningNum
                runningNum = ""
                currentOperation = op
            }
        }
    
    }
    func playSound(){
        if sirenSound.playing{
            sirenSound.stop()
        }
        
        sirenSound.play()
    }

    
}

