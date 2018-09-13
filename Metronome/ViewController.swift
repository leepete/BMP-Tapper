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
    
    func timerStart(_ button: UIButton){
        timer = Timer.scheduledTimer(timeInterval: 0.001, target: self, selector: #selector(counterTrack), userInfo: nil, repeats: true)
    }
    
    //Keep track of seconds - every interval, timerStart calls this method
    @objc func counterTrack(){
        counter += 0.001 //probably a better way to get milliseconds
    }

    @IBAction func countBeatsPerMinute(_ button: UIButton) {
        let seconds = counter
        
        //Only allow a maximum of 4 taps before label gets changed
        if(taps < maxTaps){
            taps += 1
            print(taps) //DEBUG
        }
        
        //If 4 taps have been registered
        if(taps == maxTaps){
            beatsPerMinuteLabel.isHidden = false //show label
            
            print(Double(60/seconds)) //DEBUG
            beatsPerMinute = Double(60/seconds) * Double(maxTaps)
            
            beatsPerMinuteLabel.text = "\(Int(beatsPerMinute))" //change the text
            taps = 0 //reset the number of taps
            counter = 0 //reset timer
        }
        
    }
    
}

