//
//  Network.swift
//  StorybordPost
//
//  Created by Abduqaxxor on 19/7/22.
//

import Foundation
import Alamofire

private let IS_TESTER = true
private let DEP_SERVER = "https://62d6709015ad24cbf2d751c1.mockapi.io/"
private let DEV_SERVER = "https://62d6709015ad24cbf2d751c1.mockapi.io/"

let headers: HTTPHeaders = [
    "Accept": "application/json",
]

class AFHttp{
    
    class func get(url: String, params: Parameters, handler: @escaping (AFDataResponse<Any>) -> Void){
        AF.request(server(url: url), method: .get, parameters: params, headers: headers).validate().responseJSON(completionHandler: handler)
        
    }
    
    class func post(url: String, params: Parameters, handler: @escaping (AFDataResponse<Any>) -> Void){
        AF.request(server(url: url), method: .post, parameters: params, headers: headers).validate().responseJSON(completionHandler: handler)
        
    }
    
    class func put(url: String, params: Parameters, handler: @escaping (AFDataResponse<Any>) -> Void){
        AF.request(server(url: url), method: .put, parameters: params, headers: headers).validate().responseJSON(completionHandler: handler)
        
    }
    
    class func del(url: String, params: Parameters, handler: @escaping (AFDataResponse<Any>) -> Void){
        AF.request(server(url: url), method: .delete, parameters: params, headers: headers).validate().responseJSON(completionHandler: handler)
        
    }


    class func server(url: String) -> URL{
        if(IS_TESTER){
            return URL(string: DEV_SERVER + url)!
        }
        return URL(string: DEP_SERVER + url)!
    }
    
    static let API_POST_LIST = "api/posts"
    static let API_POST_SINGLE = "api/posts/" //id
    static let API_POST_CREATE = "api/posts"
    static let API_POST_UPDATE = "api/posts/" //id
    static let API_POST_DELETE = "api/posts/" //id

    class func paramsEmpty() -> Parameters{
        let parameters: Parameters = [
            :]
        return parameters
    }
    
    class func paramsPostCreate (post: Post) -> Parameters{
        let parameters: Parameters = [
            "title": post.title!,
            "body": post.body!,
        ]
        return parameters
    }
    
    class func paramsPostWith(id: Int) -> Parameters {
        let parameters: Parameters = [
            "id" : id
        ]
        return parameters
    }
    
    class func paramsPostUpdate (post: Post) -> Parameters{
        let parameters: Parameters = [
            "id": post.id!,
            "title": post.title!,
            "body": post.body!,
        ]
        return parameters
    }
}
