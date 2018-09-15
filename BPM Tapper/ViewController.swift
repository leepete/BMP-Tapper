//
//  ViewController.swift
//  Metronome
//
//  Created by Peter Lee on 13/09/18.
//  Copyright © 2018 Peter Lee. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tapButton: UIButton!
    @IBOutlet weak var beatsPerMinuteLabel: UILabel!
    
    var beatsPerMinute: Double = 0 //result of the taps
    
    var timer = Timer() //Timer
    var counter: Double = 0 //keep track of seconds
    
    var taps = 0 //keep track of taps
    let maxTaps = 4 //max of 4 taps to determine and show BPM
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        beatsPerMinuteLabel.isHidden = true//Hide label name
        
        changeShapeButton(tapButton)
        timerStart(tapButton)
        
        drawCircleLayer() //draws the dots
        hideLayer("circleOne", "circleTwo", "circleThree", "circleFour") //hides that layer

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Change the shape of the button to be circular
    func changeShapeButton(_ sender: UIButton){
        
        // To programatically get their position from storyboard, use .origin.x or .y
        let xPos = sender.frame.origin.x
        let yPos = sender.frame.origin.y
        
        //Edit width and height
        sender.frame = CGRect(x: xPos, y: yPos, width: 200, height: 200)
        sender.layer.cornerRadius = 0.5 * sender.bounds.size.width //getting circle needs half size of width
        sender.center.x = self.view.center.x //centre button by x axis
    }
    
    //Starts time
    func timerStart(_ button: UIButton){
        timer = Timer.scheduledTimer(timeInterval: 0.001, target: self, selector: #selector(counterTrack), userInfo: nil, repeats: true)
    }
    
    //Keep track of seconds - every interval, timerStart calls this method
    @objc func counterTrack(){
        counter += 0.001 //there is probably a better way to get milliseconds than this
    }

    
    @IBAction func countBeatsPerMinute(_ button: UIButton) {
        //Hide initial dotted layer that keeps track of the taps
        if(taps == 0){
            hideLayer("circleOne", "circleTwo", "circleThree", "circleFour")
        }
        
        //Only allow a maximum of 4 taps before label gets changed
        if(taps < maxTaps){
            taps += 1
            print(taps) //DEBUG
        }
        
        switch taps{
            case 1:
                showLayer("circleOne")
            case 2:
                showLayer("circleTwo")
            case 3:
                showLayer("circleThree")
            case 4:
                showLayer("circleFour")
            default:
                () // empty tuple - do nothing (break would work as well)
        }
        
        //If 4 taps have been registered
        if(taps == maxTaps){
            let seconds = counter
            
            beatsPerMinuteLabel.isHidden = false //show label
            
            print(Double(60/seconds)) //DEBUG
            beatsPerMinute = Double(60/seconds) * Double(maxTaps)
            
            beatsPerMinuteLabel.text = "\(Int(beatsPerMinute))" //change the text
            taps = 0 //reset the number of taps
            counter = 0 //reset timer
        }
        
    }
    
    //Draw dotted track layer
    func drawCircleLayer(){
        //Bounds
        let maxX = view.frame.maxX
        let maxY = view.frame.maxY
        
        //Draw 4 Circles under button to show how many presses have been made
        let circleOne = UIBezierPath(ovalIn:  CGRect(x: maxX/2 - ((maxX/5)) , y: maxY - (maxY/8), width: 10, height: 10))
        let circleTwo = UIBezierPath(ovalIn:  CGRect(x: maxX/2 - ((maxX/4)/4), y: maxY - (maxY/8), width: 10, height: 10))
        let circleThree = UIBezierPath(ovalIn:  CGRect(x: maxX/2 + ((maxX/4)/4), y: maxY - (maxY/8), width: 10, height: 10))
        let circleFour = UIBezierPath(ovalIn:  CGRect(x: maxX/2 + ((maxX/5)), y: maxY - (maxY/8), width: 10, height: 10))

        let shapeLayer1 = CAShapeLayer() //on first sublayer
        shapeLayer1.name = "circleOne" // make name for layer
        shapeLayer1.path = circleOne.cgPath
        shapeLayer1.fillColor = UIColor(red: 0.5, green: 1, blue: 0.5, alpha: 1).cgColor
        shapeLayer1.strokeColor = UIColor.black.cgColor
        shapeLayer1.lineWidth = 2.0
        
        let shapeLayer2 = CAShapeLayer() //on second sublayer
        shapeLayer2.name = "circleTwo" // make name for layer
        shapeLayer2.path = circleTwo.cgPath
        shapeLayer2.fillColor = UIColor(red: 0.5, green: 1, blue: 0.5, alpha: 1).cgColor
        shapeLayer2.strokeColor = UIColor.black.cgColor
        shapeLayer2.lineWidth = 2.0
        
        let shapeLayer3 = CAShapeLayer() //on third sublayer
        shapeLayer3.name = "circleThree" // make name for layer
        shapeLayer3.path = circleThree.cgPath
        shapeLayer3.fillColor = UIColor(red: 0.5, green: 1, blue: 0.5, alpha: 1).cgColor
        shapeLayer3.strokeColor = UIColor.black.cgColor
        shapeLayer3.lineWidth = 2.0
        
        let shapeLayer4 = CAShapeLayer() //on fourth sublayer
        shapeLayer4.name = "circleFour" // make name for layer
        shapeLayer4.path = circleFour.cgPath
        shapeLayer4.fillColor = UIColor(red: 0.5, green: 1, blue: 0.5, alpha: 1).cgColor
        shapeLayer4.strokeColor = UIColor.black.cgColor
        shapeLayer4.lineWidth = 2.0
        
        view.layer.addSublayer(shapeLayer1)
        view.layer.addSublayer(shapeLayer2)
        view.layer.addSublayer(shapeLayer3)
        view.layer.addSublayer(shapeLayer4)
    }
    
    //Hide dotted layer
    func hideLayer(_ circleOne: String, _ circleTwo: String, _ circleThree: String, _ circleFour: String){
        for layer in self.view.layer.sublayers!{
            if(layer.name == circleOne){
                layer.isHidden = true
            } else if (layer.name == circleTwo){
                layer.isHidden = true
            } else if (layer.name == circleThree){
                layer.isHidden = true
            } else if (layer.name == circleFour){
                layer.isHidden = true
            }
        }
    }
    
    //show dotten layer
    func showLayer(_ circle: String){
        for layer in self.view.layer.sublayers!{
            if(layer.name == circle){
                layer.isHidden = false
            }
        }
    }
}

