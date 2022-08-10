//
//  EditPresenter.swift
//  StorybordPost
//
//  Created by Abduqaxxor on 9/8/22.
//

import Foundation

protocol EditPresenterProtocol: EditRequestProtocol{
    func apiSinglePost(id: Int)
    func apiPostUpdate(id: Int, post: Post)
    
    func leftTapped()
    func rightTapped()
    
}

class EditPresenter: EditPresenterProtocol{
    
    var interactor: EditInteractorProtocol!
    var routing: EditRoutingProtocol!

    var controller: BaseViewController!
    var viewController: EditViewController!
    
    func apiSinglePost(id: Int){
        controller.showProgress()
        interactor.apiSinglePost(id: id)
    }
    
    func apiPostUpdate(id: Int, post: Post) {
        controller.showProgress()
        interactor.apiPostUpdate(id: id, post: post)
    }

    func leftTapped() {
        routing.leftTapped()
    }

    func rightTapped() {
        routing.rightTapped()
    }
    
    
}
