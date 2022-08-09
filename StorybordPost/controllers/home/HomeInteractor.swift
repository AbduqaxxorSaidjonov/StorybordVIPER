//
//  HomeInteractor.swift
//  StorybordPost
//
//  Created by Abduqaxxor on 8/8/22.
//

import Foundation

protocol HomeInteractorProtocol{
    func apiPostList()
    func apiPostDelete(post: Post)
}

class HomeInteractor: HomeInteractorProtocol{

    var manager: HttpManagerProtocol!
    var response: HomeResponseProtocol!
    
    func apiPostList() {
        manager.apiPostList(completion: {(result) in
            self.response.onPostList(posts: result)
        })
    }
    
    func apiPostDelete(post: Post) {
        manager.apiPostDelete(post: post, completion: {(result) in
            self.response.onPostDelete(isDeleted: result)
        })
    }
    
}
