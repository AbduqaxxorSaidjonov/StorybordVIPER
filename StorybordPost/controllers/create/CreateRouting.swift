//
//  CreateRouting.swift
//  StorybordPost
//
//  Created by Abduqaxxor on 9/8/22.
//

import Foundation

protocol CreateRoutingProtocol{
    func leftButton()
    func rightButton()
}

class CreateRouting: CreateRoutingProtocol{
    weak var viewController: CreateViewController!
    
    func leftButton() {
        viewController.leftTapped()
    }
    
    func rightButton() {
        viewController.rightTapped()
    }
    
    
}
