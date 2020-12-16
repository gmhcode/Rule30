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
    @IBOutlet weak var segmentControl: UISegmentedControl!
    
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
    @IBAction func segmentChanged(_ sender: Any) {
        //sets the new rule
        switch segmentControl.selectedSegmentIndex {
        case 0:
            viewModel.currentRule = .rule30
        default:
            viewModel.currentRule = .rule90
        }
    }
    @IBAction func stopStartTapped(_ sender: Any) {

            viewModel.startStopPyramid.send(true)

    }

}

