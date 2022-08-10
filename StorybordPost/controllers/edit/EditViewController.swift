//
//  EditViewController.swift
//  StorybordPost
//
//  Created by Abduqaxxor on 18/7/22.
//

import UIKit
protocol EditRequestProtocol {
    func apiSinglePost(id: Int)
    func apiPostUpdate(id: Int, post: Post)
}

protocol EditResponseProtocol{
        func onCallPost(post: Post)
        func onEditPost(status: Bool)
    
    func leftTapped()
    func rightTapped()
}


class EditViewController: BaseViewController, EditResponseProtocol {
    
    var presenter: EditRequestProtocol!
    @IBOutlet weak var editTitle: UITextField!
    @IBOutlet weak var editBody: UITextField!
    var post : Post = Post()
    var POSTID: String = "1"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initNavigation()
    presenter?.apiSinglePost(id: Int(POSTID)!)
    configureViper()
    }
    
    func initNavigation(){
        let back = UIImage(named: "ic_back")
        let add = UIImage(systemName: "square.and.arrow.down")
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: back, style: .plain, target: self, action: #selector(leftTapped))
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: add, style: .plain, target: self, action: #selector(rightTapped))
        title = "Edit Post"
    }
    
    func initViews() {
        DispatchQueue.main.async {
            self.editBody.text = self.post.body!
            self.editTitle.text = self.post.title!
        }
    }
    
    func configureViper(){
        let manager = HttpManager()
        let presenter = EditPresenter()
        let interactor = EditInteractor()
        let routing = EditRouting()
        
        presenter.controller = self
        
        self.presenter = presenter
        presenter.interactor = interactor
        presenter.routing = routing
        routing.viewController = self
        interactor.manager = manager
        interactor.response = self
    }
    
    func onCallPost(post: Post) {
        self.hideProgress()
        if post != nil {
            self.post = post
            initViews()
        }else{
            // error message
        }
    }
    
    func onEditPost(status: Bool) {
        self.hideProgress()
        if status{
            self.dismiss(animated: false, completion: nil)
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "load"), object: nil)
        }else{
            // error message
        }
    }

    
    @objc func leftTapped(){
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func rightTapped(){
        presenter?.apiPostUpdate(id: Int(POSTID)!, post: Post(title: editTitle.text!, body: editBody.text!))
    }
}
