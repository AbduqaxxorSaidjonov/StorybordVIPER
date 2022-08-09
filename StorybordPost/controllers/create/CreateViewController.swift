//
//  CreateViewController.swift
//  StorybordPost
//
//  Created by Abduqaxxor on 18/7/22.
//

import UIKit

protocol CreateRequestProtocol{
    func apiPostCreate(post: Post)
    
    func leftButton()
    func rightButton()
}

protocol CreateResponseProtocol{
    func onPostCreate(isCreated: Bool)
}

class CreateViewController: BaseViewController, CreateResponseProtocol{
   
    var presenter: CreateRequestProtocol!
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var bodyTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initViews()
    }

    func initViews(){
        initNavigation()
        configureViper()
    }
    
    func initNavigation(){
        let back = UIImage(named: "ic_back")
        let add = UIImage(systemName: "square.and.arrow.up")
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: back, style: .plain, target: self, action: #selector(leftTapped))
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: add, style: .plain, target: self, action: #selector(rightTapped))
        title = "Create Post"
    }

    func onPostCreate(isCreated: Bool) {
        if isCreated {
            self.hideProgress()
            navigationController?.popViewController(animated: true)
        }
    }
    func configureViper(){
        let manager = HttpManager()
        let presenter = CreatePresenter()
        let interactor = CreateInteractor()
        let routing = CreateRouting()
        
        presenter.controller = self
        
        self.presenter = presenter
        presenter.interactor = interactor
        presenter.routing = routing
        routing.viewController = self
        interactor.manager = manager
        interactor.response = self
    }
    
    @objc func leftTapped(){
        navigationController?.popViewController(animated: true)
    }
    
    @objc func rightTapped(){
        presenter.apiPostCreate(post: Post(title: titleTextField.text!, body: bodyTextField.text!))
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "load"), object: nil)
    }
    
}
