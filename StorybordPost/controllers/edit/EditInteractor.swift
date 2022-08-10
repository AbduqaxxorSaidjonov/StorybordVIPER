//
//  EditInteractor.swift
//  StorybordPost
//
//  Created by Abduqaxxor on 9/8/22.
//

import Foundation

protocol EditInteractorProtocol{
    func apiSinglePost(id: Int)
    func apiPostUpdate(id: Int,post: Post)
}

class EditInteractor: EditInteractorProtocol{
    
    var manager: HttpManager!
    var response: EditResponseProtocol!
    
    func apiSinglePost(id: Int) {
        manager.apiSinglePost(id: id){post in
            self.response.onCallPost(post: post)
        }
    }
    
    func apiPostUpdate(id: Int, post: Post) {
        manager.apiPostUpdate(id: id, post: post) { result in
            self.response.onEditPost(status: result)
        }
    }
    
}
