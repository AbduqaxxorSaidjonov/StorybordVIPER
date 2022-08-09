//
//  EditViewController.swift
//  StorybordPost
//
//  Created by Abduqaxxor on 18/7/22.
//

import UIKit

class EditViewController: BaseViewController {
    
    @IBOutlet weak var editTitle: UITextField!
    @IBOutlet weak var editBody: UITextField!
    
    var POSTID: String = "1"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initViews()
    }

    func initViews(){
            initNavigation()
       apiSinglePost(id: POSTID)
    }
    
    func initNavigation(){
        let back = UIImage(named: "ic_back")
        let add = UIImage(systemName: "square.and.arrow.down")
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: back, style: .plain, target: self, action: #selector(leftTapped))
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: add, style: .plain, target: self, action: #selector(rightTapped))
        title = "Edit Post"
    }

    @objc func leftTapped(){
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func rightTapped(){
        apiPostUpdate(id: POSTID)
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "edit"), object: nil)
    }
    
    func apiSinglePost(id: String){
        showProgress()
        AFHttp.get(url: AFHttp.API_POST_SINGLE + id, params: AFHttp.paramsEmpty(), handler: {response in
            self.hideProgress()
            switch response.result{
            case .success:
                let postTitle = try! JSONDecoder().decode(Post.self, from: response.data!).title
                let postBody = try! JSONDecoder().decode(Post.self, from: response.data!).body
                self.editTitle.text = postTitle
                self.editBody.text = postBody
            case let .failure(error):
                print(error)
            }
        })
    }
    
    func apiPostUpdate(id: String){
        showProgress()
        AFHttp.put(url: AFHttp.API_POST_UPDATE + id, params: AFHttp.paramsPostUpdate(post: Post(title: editTitle.text!, body: editBody.text!)), handler: {response in
            self.hideProgress()
            switch response.result{
            case .success:
                print(response.result)
                self.dismiss(animated: true, completion: nil)
            case let .failure(error):
                print(error)
            }
        })
    }
}
