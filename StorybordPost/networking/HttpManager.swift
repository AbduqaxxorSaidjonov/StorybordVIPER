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
    func apiSinglePost(id: Int, completion: @escaping (Post) -> Void)
    func apiPostUpdate(id: Int, post: Post, completion: @escaping (Bool) -> Void)
}

class HttpManager: HttpManagerProtocol{
   
    var viewController: EditViewController!
    
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
    func apiSinglePost(id: Int, completion: @escaping (Post) -> Void){
        
        AFHttp.get(url: AFHttp.API_POST_SINGLE + String(id), params: AFHttp.paramsPostWith(id: id), handler: { response in
            switch response.result {
            case .success:
                let decode = try! JSONDecoder().decode(Post.self, from: response.data!)
                completion(decode)
            case let .failure(error):
                print(error)
                completion(Post())
            }
        })
    }
    
    func apiPostUpdate(id: Int, post: Post, completion: @escaping (Bool) -> Void) {
        AFHttp.put(url: AFHttp.API_POST_UPDATE + String(id), params: AFHttp.paramsPostUpdate(post: post)) { response in
            switch response.result {
            case .success:
                print("SUCCESS")
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "load"), object: nil)
                completion(true)
            case let .failure(error):
                print(error)
                completion(false)
            }
        }
    }
}
