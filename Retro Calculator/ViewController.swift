//
//  ViewController.swift
//  Retro Calculator
//
//  Created by Monur on 03/05/16.
//  Copyright © 2016 Monur. All rights reserved.
//

import UIKit
import AVFoundation
class ViewController: UIViewController {
    
    enum Operation: String{
        case Divide = "/"
        case Multiply = "*"
        case Subtract = "-"
        case Add = "+"
        case Empty = "Empty"
    }
    
    @IBOutlet weak var outputLbl: UILabel!
    var btnSound: AVAudioPlayer!
    var runningNumber = ""
    var leftValStr = "0"
    var rightValStr = ""
    var currentOperation: Operation = Operation.Empty
    var result = ""
    
    override func viewDidLoad() {
        sleep(2)
        super.viewDidLoad()
        
        let path = NSBundle.mainBundle().pathForResource("btn", ofType: "wav")
        
        let soundUrl = NSURL(fileURLWithPath: path!)
        do{
            try btnSound = AVAudioPlayer(contentsOfURL: soundUrl)
            btnSound.prepareToPlay();
        } catch let err as NSError{
            print(err.debugDescription);
        }
        
    }

    @IBAction func numberPressed(btn: UIButton){
        playSound();
        runningNumber += "\(btn.tag)"
        outputLbl.text = runningNumber;
    }
    @IBAction func dividePressed(sender: AnyObject) {
        processOperation(Operation.Divide)
    }

    @IBAction func multiplePressed(sender: AnyObject) {
        processOperation(Operation.Multiply)
    }
    @IBAction func substractPressed(sender: AnyObject) {
        processOperation(Operation.Subtract)
    }
    
    @IBAction func addPressed(sender: AnyObject) {
        processOperation(Operation.Add)
    }
    
    @IBAction func equalPressed(sender: AnyObject) {
        processOperation(currentOperation)
    }
    
    func processOperation(op : Operation){
        playSound();
        
        if currentOperation != Operation.Empty{
            
            if runningNumber != "" {
                rightValStr = runningNumber
                runningNumber = ""
                switch currentOperation {
                case Operation.Multiply:
                    result = "\(Int(leftValStr)! * Int(rightValStr)!)"
                    break
                case Operation.Add:
                    result = "\(Int(leftValStr)! + Int(rightValStr)!)"
                    break
                case Operation.Subtract:
                    result = "\(Int(leftValStr)! - Int(rightValStr)!)"
                    break
                case Operation.Divide:
                    result = "\(Int(leftValStr)! / Int(rightValStr)!)"
                    break
                default :
                    result = runningNumber
                    break
                }
                leftValStr = result;
                outputLbl.text = result;

            }
            currentOperation = op
            
            
        }else{
            if(runningNumber==""){
                leftValStr = "0"
            }else{
                leftValStr = runningNumber
            }
            
            runningNumber = ""
            currentOperation = op
        }
        
    }
    func playSound(){
        if(btnSound.playing){
            btnSound.stop()
        }
        btnSound.play()
    }
    @IBAction func clearPressed(sender: AnyObject) {
        playSound();
        runningNumber = ""
        leftValStr = "0"
        rightValStr = ""
        currentOperation = Operation.Empty
        result = ""
        outputLbl.text = "0"
    }
    
}

