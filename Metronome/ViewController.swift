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
    
    var beatsPerMinute = 0 //result of the taps
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        changeShapeButton(tapButton)
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

    @IBAction func countBeatsPerMinute(_ sender: UIButton) {
        print(sender.tag) //DEBUG: Just checking if it registers
        
        let max = 4 //max of 4 taps to determine BPM
        let secInMins = 60
        var count = 0 //keep track of taps
        
        while(count < max){
            beatsPerMinute += 2
            
            count += 1
        }
        
        beatsPerMinuteLabel.text = "\(beatsPerMinute)"
        
    }
    
}

