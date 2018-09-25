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
    
    //Bounds
    let maxWidth = UIScreen.main.bounds.size.width
    let maxHeight = UIScreen.main.bounds.size.height
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        beatsPerMinuteLabel.isHidden = true//Hide label name
        
        changeShapeButton(tapButton)
        timerStart(tapButton)
        
        drawDottedLayer()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Draw circle layer under button
    func drawDottedLayer(){
        //Draw circles
        drawCircle("circleOne", maxWidth/2 - ((maxWidth/5)), maxHeight - (maxHeight/8))
        drawCircle("circleTwo", maxWidth/2 - ((maxWidth/4)/4), maxHeight - (maxHeight/8))
        drawCircle("circleThree", maxWidth/2 + ((maxWidth/4)/4), maxHeight - (maxHeight/8))
        drawCircle("circleFour", maxWidth/2 + ((maxWidth/5)), maxHeight - (maxHeight/8))
        
        //Hide them initially until button has been pushed
        hideLayer("circleOne", "circleTwo", "circleThree", "circleFour") //hides that layer
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
        button.layer.backgroundColor =  UIColor(red: 0, green: 150, blue: 255, alpha: 1.0).cgColor
    }
    
    
    //Draw circle
    func drawCircle(_ circleName: String, _ x: CGFloat, _ y: CGFloat){
        
        let circle = UIBezierPath(ovalIn:  CGRect(x: x , y: y, width: 10, height: 10))

        let shapeLayer = CAShapeLayer() //on first sublayer
        shapeLayer.name = circleName // make name for layer
        shapeLayer.path = circle.cgPath
        shapeLayer.fillColor = UIColor(red: 0.5, green: 1, blue: 0.5, alpha: 1).cgColor
        shapeLayer.strokeColor = UIColor.black.cgColor
        shapeLayer.lineWidth = 2.0
        
        view.layer.addSublayer(shapeLayer)
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

