//
//  HttpManager.swift
//  StorybordPost
//
//  Created by Abduqaxxor on 9/8/22.
//

import Foundation

protocol HttpManagerProtocol{
    func apiPostList(completion: @escaping ([Post]) -> Void)
    func apiPostDelete(post: Post,completion: @escaping (Bool) -> Void)
    func apiPostCreate(post: Post,completion: @escaping (Bool) -> Void)
}

class HttpManager: HttpManagerProtocol{
  
    func apiPostList(completion: @escaping ([Post]) -> Void) {
        AFHttp.get(url: AFHttp.API_POST_LIST, params: AFHttp.paramsEmpty(), handler: {response in
            switch response.result{
            case .success:
                let posts = try! JSONDecoder().decode([Post].self, from: response.data!)
                completion(posts)
            case let .failure(error):
                print(error)
                completion([Post]())
            }
        })
    }
    
    func apiPostDelete(post: Post, completion: @escaping (Bool) -> Void) {
        AFHttp.del(url: AFHttp.API_POST_DELETE + post.id!, params: AFHttp.paramsEmpty(), handler: {response in
            switch response.result{
            case .success:
                print(response.result)
                completion(true)
            case let .failure(error):
                print(error)
                completion(false)
            }
        })
    }
    
    
    func apiPostCreate(post: Post, completion: @escaping (Bool) -> Void) {
        AFHttp.post(url: AFHttp.API_POST_CREATE, params: AFHttp.paramsPostCreate(post: post), handler: {response in
            switch response.result{
            case .success:
                print(response.result)
                completion(true)
            case let .failure(error):
                print(error)
                completion(false)
            }
        })
    
    }
   
}
