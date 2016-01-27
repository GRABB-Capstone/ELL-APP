//
//  AssessmentViewController.swift
//  ELLoquent
//
//  Created by Brian Carreon on 1/27/16.
//  Copyright © 2016 Bcarreon. All rights reserved.
//

import UIKit

class AssessmentViewController: UIViewController, SSRadioButtonControllerDelegate {
    
    
    @IBOutlet var word1sad: UIButton!
    @IBOutlet var word1maybe: UIButton!
    @IBOutlet var word1happy: UIButton!
    
    @IBOutlet var word2sad: UIButton!
    @IBOutlet var word2maybe: UIButton!
    @IBOutlet var word2happy: UIButton!
    
    
    var radioButtonController1: SSRadioButtonsController?
    var radioButtonController2: SSRadioButtonsController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        radioButtonController1 = SSRadioButtonsController(buttons: word1sad, word1maybe, word1happy)
        radioButtonController1!.delegate = self
        radioButtonController1!.shouldLetDeSelect = true
        
        radioButtonController2 = SSRadioButtonsController(buttons: word2sad, word2maybe, word2happy)
        radioButtonController2!.delegate = self
        radioButtonController2!.shouldLetDeSelect = true
        
        let happyImage = UIImage(named: "happy.png")
        let sadImage = UIImage(named: "sad.png")
        let maybeImage = UIImage(named: "maybe.png")
        word1happy.setBackgroundImage(happyImage, forState: UIControlState.Normal)
        word1sad.setBackgroundImage(sadImage, forState: UIControlState.Normal)
        word1maybe.setBackgroundImage(maybeImage, forState: UIControlState.Normal)
        
        word2happy.setBackgroundImage(happyImage, forState: UIControlState.Normal)
        word2sad.setBackgroundImage(sadImage, forState: UIControlState.Normal)
        word2maybe.setBackgroundImage(maybeImage, forState: UIControlState.Normal)
    }
    
    func didSelectButton(aButton: UIButton?) {
        if aButton == word1happy {
            print("hello")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}