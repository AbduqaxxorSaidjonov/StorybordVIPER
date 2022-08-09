//
//  CreatePresenter.swift
//  StorybordPost
//
//  Created by Abduqaxxor on 9/8/22.
//

import Foundation

protocol CreatePresenterProtocol: CreateRequestProtocol{
    func apiPostCreate(post: Post)
    
    func leftButton()
    func rightButton()
    
}

class CreatePresenter: CreatePresenterProtocol{
    
    var interactor: CreateInteractorProtocol!
    var routing: CreateRoutingProtocol!

    var controller: BaseViewController!

    func apiPostCreate(post: Post) {
        controller.showProgress()
        interactor.apiPostCreate(post: post)
    }

    func leftButton() {
        routing.leftButton()
    }

    func rightButton() {
        routing.rightButton()
    }
    
    
}
