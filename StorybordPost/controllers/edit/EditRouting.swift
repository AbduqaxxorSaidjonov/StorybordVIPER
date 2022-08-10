//
//  EditRouting.swift
//  StorybordPost
//
//  Created by Abduqaxxor on 9/8/22.
//

import Foundation

protocol EditRoutingProtocol{
    func leftTapped()
    func rightTapped()
}

class EditRouting: EditRoutingProtocol{
    
    var viewController: EditViewController!
    
    func leftTapped() {
        viewController.leftTapped()
    }
    
    func rightTapped() {
        viewController.rightTapped()
    }
    
}
