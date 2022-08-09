//
//  HomeViewController.swift
//  StorybordPost
//
//  Created by Abduqaxxor on 18/7/22.
//

import UIKit

protocol HomeRequestProtocol{
    func apiPostList()
    func apiPostDelete(post: Post)
    
    func navigateCreateScreen()
    func navigateEditScreen()
}

protocol HomeResponseProtocol{
    func onPostList(posts: [Post])
    func onPostDelete(isDeleted: Bool)
}


class HomeViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource, HomeResponseProtocol {

    var presenter: HomeRequestProtocol!
    
    @IBOutlet weak var TableView: UITableView!
    var items : Array<Post> = Array()
    var postId: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initViews()
    }
    
    
    
    func refreshTableView(posts: [Post]){
        self.items = posts
        self.TableView.reloadData()
    }

    func onPostList(posts: [Post]) {
        self.hideProgress()
        self.refreshTableView(posts: posts)
    }
    
    func onPostDelete(isDeleted: Bool) {
        self.hideProgress()
        presenter.apiPostList()
    }
    
    func initViews(){
        TableView.dataSource = self
        TableView.delegate = self
        initNavigation()
        configureViper()
        presenter?.apiPostList()
        refreshView()
    }

    func initNavigation(){
        let refresh = UIImage(named: "ic_refresh")
        let add = UIImage(named: "ic_add")
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: refresh, style: .plain, target: self, action: #selector(leftTapped))
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: add, style: .plain, target: self, action: #selector(rightTapped))
        title = "Storyboard MVC"
    }
    
    func configureViper(){
        let manager = HttpManager()
        let presenter = HomePresenter()
        let interactor = HomeInteractor()
        let routing = HomeRouting()
        
        presenter.controller = self
        
        self.presenter = presenter
        presenter.interactor = interactor
        presenter.routing = routing
        routing.viewController = self
        interactor.manager = manager
        interactor.response = self
    }
    
    func callCreateViewController(){
    let vc = CreateViewController(nibName: "CreateViewController", bundle: nil)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func callEditViewController(id: String){
        let vc = EditViewController(nibName: "EditViewController", bundle: nil)
        vc.POSTID = id
        let navigationController = UINavigationController(rootViewController: vc)
        self.present(navigationController, animated: true, completion: nil)
    }
    
    func refreshView(){
        NotificationCenter.default.addObserver(self, selector: #selector(doThisWhenNotifyLoad(notification: )), name: NSNotification.Name(rawValue: "load"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(doThisWhenNotifyEdit(notification: )), name: NSNotification.Name(rawValue: "edit"), object: nil)
    }
    
    // MARK: - Action
    
    @objc func leftTapped(){
        presenter.apiPostList()
    }
    
    @objc func rightTapped(){
        callCreateViewController()
    }
    
    @objc func doThisWhenNotifyLoad(notification : NSNotification) {
            //update tableview
        presenter.apiPostList()
    }
    
    @objc func doThisWhenNotifyEdit(notification : NSNotification) {
            //update tableview
        presenter.apiPostList()
    }
    
    // MARK: - Table View
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let item = items[indexPath.row]
        
        let cell = Bundle.main.loadNibNamed("PostTableViewCell", owner: self,options: nil)?.first as! PostTableViewCell
        cell.titleLabel.text = item.title
        cell.bodylabel.text = item.body
        return cell
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        return UISwipeActionsConfiguration(actions: [makeCompleteContextualAction(forRowAt: indexPath, post: items[indexPath.row])
        ])
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        return UISwipeActionsConfiguration(actions: [makeDeleteContextualAction(forRowAt: indexPath, post: items[indexPath.row])
        ])
    }
    
    func makeDeleteContextualAction(forRowAt indexPath: IndexPath, post: Post) -> UIContextualAction{
        return UIContextualAction(style: .destructive, title: "Delete"){ (action, swipeButtonView, completion) in
            print("Delete Here")
            completion(true)
            self.presenter.apiPostDelete(post: post)
        }
    }
    
    func makeCompleteContextualAction(forRowAt indexPath: IndexPath, post: Post) -> UIContextualAction{
        return UIContextualAction(style: .normal, title: "Edit"){ (action, swipeButtonView, completion) in
            print("Complete Here")
            completion(true)
            self.callEditViewController(id: post.id!)
        }
    }
}
