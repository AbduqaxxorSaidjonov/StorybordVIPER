//
//  HomePresenter.swift
//  StorybordPost
//
//  Created by Abduqaxxor on 8/8/22.
//

import Foundation

protocol HomePresenterProtocol: HomeRequestProtocol{
    func apiPostList()
    func apiPostDelete(post: Post)
    
    func navigateCreateScreen()
    func navigateEditScreen()
}

class HomePresenter: HomePresenterProtocol{
    
    var interactor: HomeInteractorProtocol!
    var routing: HomeRoutingProtocol!
    
    var controller: BaseViewController!
    
    func apiPostList() {
        controller.showProgress()
        interactor.apiPostList()
    }
    
    func apiPostDelete(post: Post) {
        controller.showProgress()
        interactor.apiPostDelete(post: post)
    }
    
    func navigateCreateScreen() {
        routing.navigateCreateScreen()
    }
    
    func navigateEditScreen() {
        routing.navigateEditScreen()
    }
    
    
}
