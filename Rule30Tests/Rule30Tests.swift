//
//  Rule30Tests.swift
//  Rule30Tests
//
//  Created by Greg Hughes on 12/15/20.
//

import XCTest
import UIKit
@testable import Rule30

class Rule30ViewModelTests: XCTestCase {

    let viewModel = Rule30ViewModel()
    
    override func setUpWithError() throws {
        let timer = Timer()
        //KEEP THIS AT 300
        for _ in 0...300 {
            viewModel.addCell(timer: timer)
        }
    }

    func testSizeForItemAt() {
        let width = Int(viewModel.sizeForItemAt().width)
        let height = Int(viewModel.sizeForItemAt().height)
        XCTAssertTrue(width == height)
        XCTAssertTrue(width == 10)
    }
    func testNumberOfItemsInSection() {
        XCTAssertTrue(viewModel.numberOfItemsInSection() == 297)
    }
    func testCellSize() {
        let size = Int(viewModel.cellSize)
        XCTAssertTrue(size == 10)
    }
    func testCellsPerRow() {
        XCTAssertTrue(viewModel.cellsPerRow == 32)
    }
    func testCellCount() {
        XCTAssertTrue(viewModel.cellCount == 297)
    }


    func testCellShouldBeActiveRule30() throws {
        let topLeft = Rule30CollectionViewCell()
        let top = Rule30CollectionViewCell()
        let topRight = Rule30CollectionViewCell()
        let configureCell = Rule30CollectionViewCell()
        let indexpath = IndexPath(row: 100, section: 0)
        let neighborhoodCells = RVMNeighborhoodCells(topCell: top, topLeftCell: topLeft, topRightCell: topRight)
        viewModel.currentRule = .rule30
        
        neighborhoodCells.topLeftCell.colorIsActive = true
        neighborhoodCells.topCell.colorIsActive = false
        neighborhoodCells.topRightCell.colorIsActive = false
        
        
        XCTAssertTrue(viewModel.configureCell(cell: configureCell, indexPath: indexpath, neighborhoodCells: neighborhoodCells).colorIsActive)
        
        neighborhoodCells.topLeftCell.colorIsActive = false
        neighborhoodCells.topCell.colorIsActive = true
        neighborhoodCells.topRightCell.colorIsActive = true
        
        XCTAssertTrue(viewModel.configureCell(cell: configureCell, indexPath: indexpath, neighborhoodCells: neighborhoodCells).colorIsActive)
        
        neighborhoodCells.topLeftCell.colorIsActive = false
        neighborhoodCells.topCell.colorIsActive = false
        neighborhoodCells.topRightCell.colorIsActive = true
        
        XCTAssertTrue(viewModel.configureCell(cell: configureCell, indexPath: indexpath, neighborhoodCells: neighborhoodCells).colorIsActive)
        
        neighborhoodCells.topLeftCell.colorIsActive = false
        neighborhoodCells.topCell.colorIsActive = true
        neighborhoodCells.topRightCell.colorIsActive = false
        
        XCTAssertTrue(viewModel.configureCell(cell: configureCell, indexPath: indexpath, neighborhoodCells: neighborhoodCells).colorIsActive)
    }
    func testCellShouldBeActiveRule90() throws {
        let topLeft = Rule30CollectionViewCell()
        let top = Rule30CollectionViewCell()
        let topRight = Rule30CollectionViewCell()
        let configureCell = Rule30CollectionViewCell()
        let indexpath = IndexPath(row: 100, section: 0)
        let neighborhoodCells = RVMNeighborhoodCells(topCell: top, topLeftCell: topLeft, topRightCell: topRight)
        viewModel.currentRule = .rule90
        
        neighborhoodCells.topLeftCell.colorIsActive = true
        neighborhoodCells.topCell.colorIsActive = true
        neighborhoodCells.topRightCell.colorIsActive = false
        
        
        XCTAssertTrue(viewModel.configureCell(cell: configureCell, indexPath: indexpath, neighborhoodCells: neighborhoodCells).colorIsActive)
        
        neighborhoodCells.topLeftCell.colorIsActive = false
        neighborhoodCells.topCell.colorIsActive = true
        neighborhoodCells.topRightCell.colorIsActive = true
        
        XCTAssertTrue(viewModel.configureCell(cell: configureCell, indexPath: indexpath, neighborhoodCells: neighborhoodCells).colorIsActive)
        
        neighborhoodCells.topLeftCell.colorIsActive = false
        neighborhoodCells.topCell.colorIsActive = false
        neighborhoodCells.topRightCell.colorIsActive = true
        
        XCTAssertTrue(viewModel.configureCell(cell: configureCell, indexPath: indexpath, neighborhoodCells: neighborhoodCells).colorIsActive)
        
        neighborhoodCells.topLeftCell.colorIsActive = true
        neighborhoodCells.topCell.colorIsActive = false
        neighborhoodCells.topRightCell.colorIsActive = false
        
        XCTAssertTrue(viewModel.configureCell(cell: configureCell, indexPath: indexpath, neighborhoodCells: neighborhoodCells).colorIsActive)
    }
    
    func testcollectionViewWidth() {
        XCTAssertTrue(viewModel.collectionViewWidth == 350.0)
    }
    
    func testReset() {
        viewModel.reset()
        
        XCTAssertTrue(viewModel.cellsPerRow == 1)
        XCTAssertTrue(viewModel.cellCount == viewModel.cellsPerRow)
        XCTAssertTrue(viewModel.cellSize == viewModel.collectionViewWidth / CGFloat(viewModel.cellCount))
        XCTAssertTrue(viewModel.reloadData == true)
    }
    
    func testIsAfterFirstRow() {
        var indexPath = IndexPath(item: 20, section: 0)
        XCTAssertFalse(viewModel.isAfterFirstRow(indexPath: indexPath))
        
        indexPath = IndexPath(item: 33, section: 0)
        XCTAssertTrue(viewModel.isAfterFirstRow(indexPath: indexPath))
    }
    
    func testIsFirstCell() {
        let indexPath = IndexPath(item: 16, section: 0)
        XCTAssertTrue(viewModel.isFirstCell(indexPath: indexPath))
    }
    
    func testTopCellIndexPath() {
        let indexPath = IndexPath(item: 40, section: 0)
        XCTAssertTrue(viewModel.topCellIndexPath(indexPath: indexPath).item == 8)
    }
    func testTopLeftCellIndexPath() {
        let indexPath = IndexPath(item: 40, section: 0)
        XCTAssertTrue(viewModel.topLeftCellIndexPath(indexPath: indexPath).item == 7)
    }
    func testTopRightCellIndexPath() {
        let indexPath = IndexPath(item: 40, section: 0)
        XCTAssertTrue(viewModel.topRightCellIndexPath(indexPath: indexPath).item == 9)
    }
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
