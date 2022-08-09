//
//  CreateInteractor.swift
//  StorybordPost
//
//  Created by Abduqaxxor on 9/8/22.
//

import Foundation

protocol CreateInteractorProtocol{
    func apiPostCreate(post: Post)
}

class CreateInteractor: CreateInteractorProtocol{
   
    var manager: HttpManagerProtocol!
    var response: CreateResponseProtocol!
    
    func apiPostCreate(post: Post) {
        manager.apiPostCreate(post: post, completion: {(result) in
            self.response.onPostCreate(isCreated: result)
        })
    }
    
}
