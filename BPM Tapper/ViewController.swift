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
        
        drawCircleLayer()

        
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
        //Only allow a maximum of 4 taps before label gets changed
        if(taps < maxTaps){
            taps += 1
            print(taps) //DEBUG
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
    
    func drawCircleLayer(){
        let maxX = view.frame.maxX
        let maxY = view.frame.maxY
        //Draw 4 Circles under button to show how many presses have been made
        let circleOne = UIBezierPath(ovalIn:  CGRect(x: maxX/2 - ((maxX/5)) , y: maxY - (maxY/8), width: 10, height: 10))
        let circleTwo = UIBezierPath(ovalIn:  CGRect(x: maxX/2 - ((maxX/4)/4), y: maxY - (maxY/8), width: 10, height: 10))
        let circleThree = UIBezierPath(ovalIn:  CGRect(x: maxX/2 + ((maxX/4)/4), y: maxY - (maxY/8), width: 10, height: 10))
        let circleFour = UIBezierPath(ovalIn:  CGRect(x: maxX/2 + ((maxX/5)), y: maxY - (maxY/8), width: 10, height: 10))

        let shapeLayer1 = CAShapeLayer() //on first sublayer
        shapeLayer1.name = "circleOne"
        shapeLayer1.path = circleOne.cgPath
        shapeLayer1.fillColor = UIColor(red: 0.5, green: 1, blue: 0.5, alpha: 1).cgColor
        shapeLayer1.strokeColor = UIColor.black.cgColor
        shapeLayer1.lineWidth = 2.0
        
        let shapeLayer2 = CAShapeLayer() //on second sublayer
        shapeLayer2.name = "circleTwo"
        shapeLayer2.path = circleTwo.cgPath
        shapeLayer2.fillColor = UIColor(red: 0.5, green: 1, blue: 0.5, alpha: 1).cgColor
        shapeLayer2.strokeColor = UIColor.black.cgColor
        shapeLayer2.lineWidth = 2.0
        
        let shapeLayer3 = CAShapeLayer() //on third sublayer
        shapeLayer3.name = "circleThree"
        shapeLayer3.path = circleThree.cgPath
        shapeLayer3.fillColor = UIColor(red: 0.5, green: 1, blue: 0.5, alpha: 1).cgColor
        shapeLayer3.strokeColor = UIColor.black.cgColor
        shapeLayer3.lineWidth = 2.0
        
        let shapeLayer4 = CAShapeLayer() //on fourth sublayer
        shapeLayer4.name = "circleFour"
        shapeLayer4.path = circleFour.cgPath
        shapeLayer4.fillColor = UIColor(red: 0.5, green: 1, blue: 0.5, alpha: 1).cgColor
        shapeLayer4.strokeColor = UIColor.black.cgColor
        shapeLayer4.lineWidth = 2.0
        
        view.layer.addSublayer(shapeLayer1)
        view.layer.addSublayer(shapeLayer2)
        view.layer.addSublayer(shapeLayer3)
        view.layer.addSublayer(shapeLayer4)
    }
    
    func hideLayer(){
        for layer in self.view.layer.sublayers!{
            if(layer.name == "circleOne"){
                layer.isHidden = true
            }
        }
    }
}

