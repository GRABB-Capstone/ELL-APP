//
//  AssessmentViewController.swift
//  ELLoquent
//
//  Created by Brian Carreon on 1/27/16.
//  Copyright © 2016 Bcarreon. All rights reserved.
//

import UIKit

class AssessmentViewController: UIViewController, SSRadioButtonControllerDelegate {
    
    @IBOutlet var word1: UILabel!
    @IBOutlet var word2: UILabel!
    @IBOutlet var word3: UILabel!
    @IBOutlet var word4: UILabel!
    @IBOutlet var word5: UILabel!
    
    var words = [String]()
    
    @IBOutlet var word1sad: UIButton!
    @IBOutlet var word1maybe: UIButton!
    @IBOutlet var word1happy: UIButton!
    
    @IBOutlet var word2sad: UIButton!
    @IBOutlet var word2maybe: UIButton!
    @IBOutlet var word2happy: UIButton!
    
    @IBOutlet var word3sad: UIButton!
    @IBOutlet var word3maybe: UIButton!
    @IBOutlet var word3happy: UIButton!
    
    @IBOutlet var word4sad: UIButton!
    @IBOutlet var word4maybe: UIButton!
    @IBOutlet var word4happy: UIButton!
    
    @IBOutlet var word5sad: UIButton!
    @IBOutlet var word5maybe: UIButton!
    @IBOutlet var word5happy: UIButton!
    
    var radioButtonController1: SSRadioButtonsController?
    var radioButtonController2: SSRadioButtonsController?
    var radioButtonController3: SSRadioButtonsController?
    var radioButtonController4: SSRadioButtonsController?
    var radioButtonController5: SSRadioButtonsController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(words)
        print(words.count)
        
        if words.count >= 1 {
            word1.text = words[0]
        }
        
        if words.count >= 2 {
            print("test")
            word2.text = words[1]
        }
        
        if words.count >= 3 {
            word3.text = words[2]
        }
        
        if words.count >= 4 {
            word4.text = words[3]
        }
        
        if words.count >= 5 {
            word5.text = words[4]
        }
        
        radioButtonController1 = SSRadioButtonsController(buttons: word1sad, word1maybe, word1happy)
        radioButtonController1!.delegate = self
        radioButtonController1!.shouldLetDeSelect = true
        
        radioButtonController2 = SSRadioButtonsController(buttons: word2sad, word2maybe, word2happy)
        radioButtonController2!.delegate = self
        radioButtonController2!.shouldLetDeSelect = true
        
        radioButtonController3 = SSRadioButtonsController(buttons: word3sad, word3maybe, word3happy)
        radioButtonController3!.delegate = self
        radioButtonController3!.shouldLetDeSelect = true
        
        radioButtonController4 = SSRadioButtonsController(buttons: word4sad, word4maybe, word4happy)
        radioButtonController4!.delegate = self
        radioButtonController4!.shouldLetDeSelect = true
        
        radioButtonController5 = SSRadioButtonsController(buttons: word5sad, word5maybe, word5happy)
        radioButtonController5!.delegate = self
        radioButtonController5!.shouldLetDeSelect = true
        
        let happyImage = UIImage(named: "happy.png")
        let sadImage = UIImage(named: "sad.png")
        let maybeImage = UIImage(named: "maybe.png")
        
        word1happy.setBackgroundImage(happyImage, forState: UIControlState.Normal)
        word1sad.setBackgroundImage(sadImage, forState: UIControlState.Normal)
        word1maybe.setBackgroundImage(maybeImage, forState: UIControlState.Normal)
        
        word2happy.setBackgroundImage(happyImage, forState: UIControlState.Normal)
        word2sad.setBackgroundImage(sadImage, forState: UIControlState.Normal)
        word2maybe.setBackgroundImage(maybeImage, forState: UIControlState.Normal)
        
        word3happy.setBackgroundImage(happyImage, forState: UIControlState.Normal)
        word3sad.setBackgroundImage(sadImage, forState: UIControlState.Normal)
        word3maybe.setBackgroundImage(maybeImage, forState: UIControlState.Normal)
        
        word4happy.setBackgroundImage(happyImage, forState: UIControlState.Normal)
        word4sad.setBackgroundImage(sadImage, forState: UIControlState.Normal)
        word4maybe.setBackgroundImage(maybeImage, forState: UIControlState.Normal)
        
        word5happy.setBackgroundImage(happyImage, forState: UIControlState.Normal)
        word5sad.setBackgroundImage(sadImage, forState: UIControlState.Normal)
        word5maybe.setBackgroundImage(maybeImage, forState: UIControlState.Normal)
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