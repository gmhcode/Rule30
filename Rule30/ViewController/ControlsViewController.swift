//
//  ControlsViewController.swift
//  Rule30
//
//  Created by Greg Hughes on 12/15/20.
//

import UIKit
import Combine

class ControlsViewController: UIViewController {
    
    var viewModel : Rule30ViewModel!
    @IBOutlet weak var startStopButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func changePrimaryTapped(_ sender: Any) {
        //presents the colorPickerController on the Rule30ViewController and sets the primaryColor
        viewModel.colorPickerColor = .primary
    }
    @IBAction func changeSecondaryTapped(_ sender: Any) {
        //presents the colorPickerController on the Rule30ViewController and sets the secondaryColor
        viewModel.colorPickerColor = .secondary
    }
    @IBAction func resetTapped(_ sender: Any) {
        //resets the pyramid on the Rule30ViewController
        viewModel.reset()
    }
    
    @IBAction func stopStartTapped(_ sender: Any) {
        
        if startStopButton.titleLabel?.text == "Stop"{
            viewModel.startStopPyramid.send(true)
            startStopButton.setTitle("Start", for: .normal)
        }else {
            viewModel.startStopPyramid.send(true)
            startStopButton.setTitle("Stop", for: .normal)
        }
    }

}

