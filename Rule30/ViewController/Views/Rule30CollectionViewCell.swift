//
//  Rule30CollectionViewCell.swift
//  Rule30
//
//  Created by Greg Hughes on 12/15/20.
//

import UIKit
import Combine
class Rule30CollectionViewCell: UICollectionViewCell {
    
    var primaryColor : UIColor = .black
    var secondaryColor : UIColor = .white
    
    var cancellable = Set<AnyCancellable>()
    
    
    var colorIsActive: Bool {
        get {
            return colorIsActiveGet()
        }
        set {
            colorIsActiveSet(newV: newValue)
        }
    }
    
    func colorIsActiveGet() -> Bool {
        if backgroundColor != primaryColor {
            return true
        }else {
            return false
        }
    }
    
    func colorIsActiveSet(newV: Bool){
        if newV == true {
            backgroundColor = secondaryColor
        }else {
            backgroundColor = primaryColor
        }
    }
    
}
