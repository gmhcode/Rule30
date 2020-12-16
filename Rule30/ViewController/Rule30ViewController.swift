//
//  Rule30ViewController.swift
//  Rule30
//
//  Created by Greg Hughes on 12/15/20.
//

import UIKit
import Combine

class Rule30ViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    var timer = Timer()

    var viewModel : Rule30ViewModel!
    var cancellable = Set<AnyCancellable>()
    let colorPicker = UIColorPickerViewController()
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        startPyramid()
    }

    private func startPyramid() {
        timer = Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true) {[weak self] (timer) in
            self?.viewModel.addCell(timer: timer)
        }
    }
    
    func setup() {
        viewModel = Rule30ViewModel()
        colorPicker.delegate = self
        
        viewModel.colorPickerTrigger.sink {[weak self] (color) in
            guard let strongSelf = self else {return}
            strongSelf.present(strongSelf.colorPicker, animated: true, completion: nil)
        }.store(in: &cancellable)
        
        viewModel.startStopPyramid.sink {[weak self] (_) in
            if self?.timer.isValid == true {
                self?.timer.invalidate()
            }else {
                self?.startPyramid()
            }
        }.store(in: &cancellable)
        
        viewModel.$reloadData.sink {[weak self] (received) in
            self?.collectionView.reloadData()
        }.store(in: &cancellable)
    }
}

// MARK: - UICollectionViewDataSource
extension Rule30ViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.cellCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        var cell = collectionView.dequeueReusableCell(withReuseIdentifier: "r30Cell", for: indexPath) as! Rule30CollectionViewCell
        
        if viewModel.isFirstCell(indexPath: indexPath) {
            return viewModel.configureCell(cell:cell, indexPath: indexPath, neighborhoodCells: nil)
        }
        
        else if viewModel.isAfterFirstRow(indexPath: indexPath) {
            
            let neighborhoodCells = getNeiborhoodCells(indexPath: indexPath)
            
            cell = viewModel.configureCell(cell:cell, indexPath: indexPath, neighborhoodCells: neighborhoodCells)
            
        } else {
            cell = viewModel.configureCell(cell:cell, indexPath: indexPath, neighborhoodCells: nil)
            
        }
        return cell
    }
    
    //Grabs all the neighboring cells around the indexpath and puts them in a RVMNeighborhoodCells struct, which is used to determine the color of the cell
    func getNeiborhoodCells(indexPath: IndexPath) -> RVMNeighborhoodCells {
        
        let topCellIndexPath = viewModel.topCellIndexPath(indexPath: indexPath)
        let topLeftCellIndexPath = viewModel.topLeftCellIndexPath(indexPath: indexPath)
        let topRightCellIndexPath = viewModel.topRightCellIndexPath(indexPath: indexPath)
        let topCell = collectionView.cellForItem(at: topCellIndexPath) as! Rule30CollectionViewCell
        let topLeftCell = collectionView.cellForItem(at: topLeftCellIndexPath) as! Rule30CollectionViewCell
        let topRightCell = collectionView.cellForItem(at: topRightCellIndexPath) as! Rule30CollectionViewCell
        
        let neighborhoodCells = RVMNeighborhoodCells(topCell: topCell, topLeftCell: topLeftCell, topRightCell: topRightCell)
        
        return neighborhoodCells
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension Rule30ViewController : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return viewModel.sizeForItemAt()
    }
}

extension Rule30ViewController : UIColorPickerViewControllerDelegate {
    func colorPickerViewControllerDidFinish(_ viewController: UIColorPickerViewController) {
            
            dismiss(animated: true, completion: nil)
    }
    func colorPickerViewControllerDidSelectColor(_ viewController: UIColorPickerViewController) {
        
        if viewModel.colorPickerColor == .primary {
            viewModel.primaryColor = viewController.selectedColor
        }else {
            viewModel.secondaryColor = viewController.selectedColor
        }
        collectionView.reloadData()
    }
}
