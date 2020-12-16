//
//  Rule30ViewModel.swift
//  Rule30
//
//  Created by Greg Hughes on 12/15/20.
//

import UIKit
import Combine
class Rule30ViewModel {
    //when reloadData is set, the collectionView.reloadData will be called
    @Published var reloadData = true
    ///When colorPickerTrigger.send() is called, UIColorPickViewController will be presented on the Rule30ViewController
    var colorPickerTrigger = PassthroughSubject<ColorChange, Never>()
    ///When startStopPyramid.send() is called, the pyramid will start/stop
    var startStopPyramid = PassthroughSubject<Bool, Never>()
    ///When colorPickerColor is set, colorPickerTrigger will be...triggered, which will call the UIColorPickViewController
    var colorPickerColor : ColorChange = .primary {
        didSet {
            colorPickerTrigger.send(colorPickerColor)
        }
    }
    var cellSize: CGFloat = 0
    var cellCount: Int = 0
    var cellsPerRow: Int = 1
    var collectionViewWidth : CGFloat = 350.0
    var primaryColor : UIColor = .black
    var secondaryColor : UIColor = .white
    var currentRule : Rule = .rule30
    
    
    init() {
        reset()
    }
    
    func numberOfItemsInSection() -> Int {
        return cellCount
    }
    ///resets the pyramid
    func reset() {
        cellsPerRow = 1
        cellCount = cellsPerRow
        cellSize = collectionViewWidth / CGFloat(cellCount)
        reloadData = true
    }
    //adds a new cell to the pyramid, makes the pyramid bigger when needed. if the pyramid gets too big, it will stop
    func addCell(timer: Timer) {
        if cellCount < (cellsPerRow * cellsPerRow / 2) {
            cellCount += 1
        }
        else if cellsPerRow < 32 {
            cellsPerRow = cellsPerRow * 2
            cellSize = cellSize / 2
        }else {
            timer.invalidate()
        }
        reloadData = true
    }
    
    func isFirstCell(indexPath: IndexPath) -> Bool {
        return indexPath.item < cellsPerRow && indexPath.item == cellsPerRow / 2
    }
    
    func isAfterFirstRow(indexPath: IndexPath) -> Bool {
        return indexPath.item - cellsPerRow > 0
    }
    
    func sizeForItemAt() -> CGSize {
        return CGSize(width: cellSize, height: cellSize)
    }
    // MARK: - configureCell
    ///determines what color the cell should be
    /// - Parameters:
    ///     - cell: The the current indexPaths Rule30CollectionViewCell.
    ///     - indexPath: current indexPath in cellForItemat.
    ///     - neighborhoodCells: struct which holds the cells on the top left, top center and top right of the cell in the cell parameter of this function.
    func configureCell(cell: Rule30CollectionViewCell, indexPath: IndexPath, neighborhoodCells: RVMNeighborhoodCells?) -> Rule30CollectionViewCell {
        
        cell.colorIsActive = false
        cell.primaryColor = primaryColor
        cell.secondaryColor = secondaryColor
        
        
        if let neighborhoodCells = neighborhoodCells {
            if currentRule == .rule30 {
                if neighborhoodCells.topLeftCell.colorIsActive != (neighborhoodCells.topCell.colorIsActive || neighborhoodCells.topRightCell.colorIsActive) {
                    cell.colorIsActive = true
                }
            }else {
                if (neighborhoodCells.topLeftCell.colorIsActive && !neighborhoodCells.topCell.colorIsActive && !neighborhoodCells.topRightCell.colorIsActive) ||
                    (neighborhoodCells.topRightCell.colorIsActive && !neighborhoodCells.topCell.colorIsActive && !neighborhoodCells.topLeftCell.colorIsActive) ||
                    (!neighborhoodCells.topLeftCell.colorIsActive && neighborhoodCells.topCell.colorIsActive && neighborhoodCells.topRightCell.colorIsActive) ||
                    (!neighborhoodCells.topRightCell.colorIsActive && neighborhoodCells.topCell.colorIsActive && neighborhoodCells.topLeftCell.colorIsActive){
                    cell.colorIsActive = true
                    
                }
            }
            
        }  else if isFirstCell(indexPath: indexPath) {
            cell.colorIsActive = true
        }
        return cell
    }
    
    
    ///Gets the indexPath for the cell on the top-Center of the current indexPath cell. use like this
    ///
    /// - Parameters:
    ///     - cell: The the current indexPaths Rule30CollectionViewCell.
    func topCellIndexPath(indexPath: IndexPath) -> IndexPath {
        return IndexPath(item: indexPath.item - cellsPerRow, section: indexPath.section)
    }
    ///Gets the indexPath for the cell on the top-Left of the current indexPath cell. use like this
    ///
    /// - Parameters:
    ///     - indexPath: The current indexPath Rule30CollectionViewCell.
    func topLeftCellIndexPath(indexPath: IndexPath) -> IndexPath {
        return IndexPath(item: topCellIndexPath(indexPath: indexPath).item - 1, section: topCellIndexPath(indexPath: indexPath).section)
    }
    ///Gets the indexPath for the cell on the top-Right of the current indexPath cell. use like this
    /// - Parameters:
    ///     - indexPath: The current indexPath Rule30CollectionViewCell.
    func topRightCellIndexPath(indexPath: IndexPath) -> IndexPath {
        return IndexPath(item: topCellIndexPath(indexPath: indexPath).item + 1, section: topCellIndexPath(indexPath: indexPath).section)
    }
    enum Rule {
        case rule30
        case rule90
    }
    
    enum ColorChange {
        case primary
        case secondary
    }
}
///Used to find the top right, top center, and top left cells for the configureCell function
/// - Properties:
///     - topCell: use the topCellIndexPath() + CellForItemAt() functions to find this Cell
///     - topLeftCell: use the topLeftCellIndexPath() + CellForItemAt() functions to find this Cell.
///     - topRightCell: use the topRightCellIndexPath() + CellForItemAt() functions to find this Cell..
struct RVMNeighborhoodCells {
    let topCell : Rule30CollectionViewCell
    let topLeftCell : Rule30CollectionViewCell
    let topRightCell : Rule30CollectionViewCell
    
    init(topCell: Rule30CollectionViewCell, topLeftCell: Rule30CollectionViewCell, topRightCell: Rule30CollectionViewCell) {
        self.topCell = topCell
        self.topLeftCell = topLeftCell
        self.topRightCell = topRightCell
    }
}
