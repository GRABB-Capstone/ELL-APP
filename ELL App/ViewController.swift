//
//  ViewController.swift
//  ELL App
//
//  Created by Brian Carreon on 11/10/15.
//  Copyright © 2015 Bcarreon. All rights reserved.
//

import UIKit

class ViewController: UIViewController, SSRadioButtonControllerDelegate {
    
    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var button3: UIButton!
    
    var radioButtonController: SSRadioButtonsController?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        radioButtonController = SSRadioButtonsController(buttons: button1, button2, button3)
        radioButtonController!.delegate = self
        radioButtonController!.shouldLetDeSelect = true
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func didSelectButton(aButton: UIButton?) {
        if aButton == button3 {
            print("hello")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

