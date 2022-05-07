//
//  FeedController.swift
//  Coffee App
//
//  Created by Richie Sun on 5/4/22.
//

import Foundation
import UIKit

var immy = UIImage()
var canpost = false

let factoids = ["-Starbucks was founded by two teachers and a writer!-", "-Starbucks was founded by two teachers and a writer!-", "-Only two U.S states produce coffee-", "-One cup of black coffee only has one calorie-", "-Coffee is a fruit-", "-Beethoven loved coffee-"]

let factoid2 = "-Starbucks was founded by two teachers and a writer!-"
class FeedController: UIViewController{
    
    var posts: [Post] = []
    
    let topbar: UILabel = {
        let label = UILabel()
        label.backgroundColor = factcolor
        return label
    }()
    
    let facts: UILabel = {
        let label = UILabel()
        label.text = factoids.randomElement() //REPLACE
        label.font = .systemFont(ofSize: 15)
        label.textColor = .black
        label.textAlignment = .center
        label.backgroundColor = factcolor
        return label
    }()
    
    
    let chatty: UITextField = {
        let text = UITextField()
        text.placeholder = "Join the coffee conversation..."
        text.textColor = .black
        text.font = .systemFont(ofSize: 15)
        text.layer.borderColor = UIColor.black.cgColor
        text.layer.borderWidth = 1
        return text
    }()
    
    let chatview: UITableView = {
        let table = UITableView()
        table.backgroundColor = .white
        return table
    }()
    
    lazy var cammy: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "camera.fill"), for: .normal)
        button.addTarget(self, action: #selector(pic), for: .touchUpInside)
        button.setTitleColor(.systemGreen, for: .normal)
        button.imageView?.contentMode = .scaleToFill
        button.imageView?.sizeToFit()
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 1
        return button
    }()
    
    lazy var sendy: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "arrow.right.circle.fill"), for: .normal)
        button.addTarget(self, action: #selector(posty), for: .touchUpInside)
        button.setTitleColor(.systemGreen, for: .normal)
        button.imageView?.contentMode = .scaleToFill
        button.imageView?.sizeToFit()
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 1
        return button
    }()
    
    let sendl: UILabel = {
        let label = UILabel()
        label.text = "SENT..."
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        label.alpha = 0
        return label
    }()
    
    let chatID = "CHATTY"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = backcolor
        [topbar, facts, chatview, chatty, cammy, sendy, sendl].forEach { subview in
            subview.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(subview)
        }
        chatview.delegate = self
        chatview.dataSource = self
        chatview.register(ChatCell.self, forCellReuseIdentifier: chatID)
        constrain()
        NetworkManager.getAllPosts { response in
            self.posts = response
        }
        chatview.reloadData()
        
        let refresh = UIRefreshControl()
        refresh.addTarget(self, action: #selector(reload), for: .valueChanged)
        chatview.refreshControl = refresh
        
    }
    
    func constrain(){
        NSLayoutConstraint.activate([
            topbar.topAnchor.constraint(equalTo: view.topAnchor),
            topbar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            topbar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            topbar.heightAnchor.constraint(equalToConstant: 40),
            
            facts.topAnchor.constraint(equalTo: view.topAnchor, constant: 40),
            facts.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            facts.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            facts.heightAnchor.constraint(equalToConstant: 100),
            
            chatty.topAnchor.constraint(equalTo: facts.bottomAnchor),
            chatty.heightAnchor.constraint(equalToConstant: 67),
            chatty.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            chatty.trailingAnchor.constraint(equalTo: cammy.leadingAnchor),
            
            sendy.topAnchor.constraint(equalTo: chatty.topAnchor),
            sendy.bottomAnchor.constraint(equalTo: chatty.bottomAnchor),
            sendy.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            sendy.widthAnchor.constraint(equalToConstant: 67),
            
            cammy.topAnchor.constraint(equalTo: chatty.topAnchor),
            cammy.bottomAnchor.constraint(equalTo: chatty.bottomAnchor),
            cammy.trailingAnchor.constraint(equalTo: sendy.leadingAnchor),
            cammy.widthAnchor.constraint(equalToConstant: 67),
            
            sendl.topAnchor.constraint(equalTo: chatty.topAnchor),
            sendl.leadingAnchor.constraint(equalTo: chatty.leadingAnchor),
            sendl.bottomAnchor.constraint(equalTo: chatty.bottomAnchor),
            
            chatview.topAnchor.constraint(equalTo: chatty.bottomAnchor),
            chatview.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            chatview.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            chatview.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
        ])
    }
    
    
    @objc func reload(){
        //GET ALL DATA REQUEST
        chatview.reloadData()
        facts.text = factoids.randomElement()
        NetworkManager.getAllPosts { response in
            self.posts = response
            self.chatview.reloadData()
            self.chatview.refreshControl?.endRefreshing()
        }
        print(posts)
        
    }
    
}

extension FeedController: UITableViewDelegate{
    
}
extension FeedController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = chatview.dequeueReusableCell(withIdentifier: chatID, for: indexPath) as? ChatCell{
            let post = posts[indexPath.row]
            cell.config(str: post)
            cell.selectionStyle = .none
            cell.layer.borderWidth = 1
            return cell
        } else{
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 400
    }
    @objc func pic(){
        showImagePickerCActions()
    }
    
    @objc func posty(){
        canpost = true
        if (immy == UIImage()){
            error(type: "Photo", message: "select a photo to share")
        }
        if (chatty.text == ""){
            error(type: "Message", message: "type a message")
        }
        if (canpost){
        let imagy = NetworkManager.convertImage(img: immy)
        cammy.setImage(UIImage(systemName: "camera.fill"), for: .normal)
        NetworkManager.createPost(id: sessionID, content: chatty.text!, image: imagy) { response in
            print("postyyyyy")
            
        }
            NetworkManager.getAllPosts { response in
                self.posts = response
            }
            chatview.reloadData()
            UIView.animate(withDuration: 4) {
                self.sendl.alpha = 1
                self.chatty.backgroundColor = greeny
                self.chatty.backgroundColor = backcolor
                self.sendl.alpha = 0
            }
            chatty.text = ""
        }
    }
    
    func error(type: String, message: String){
        let error = UIAlertController(title: "Invalid \(type)", message: "Make sure you \(message)!", preferredStyle: .alert)
        error.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { _ in
            print("Post Error")
        }))
        canpost = false
        present(error, animated: true, completion: nil)
    }
}

extension FeedController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func showImagePickerCActions(){
        let alert = UIAlertController(title: "Choose a Photo", message: "", preferredStyle: .actionSheet)
        let libary = UIAlertAction(title: "Choose from Camera Roll", style: .default) { (action) in
            self.showImagePickerC(sourceType: .photoLibrary)
            self.cammy.setImage(UIImage(systemName: "checkmark.circle.fill"), for: .normal)
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(libary)
        alert.addAction(cancel)
        present(alert, animated: true, completion: nil)
        //UIAlertController.addAction(libary)
    }
    func showImagePickerC(sourceType: UIImagePickerController.SourceType) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        picker.sourceType = sourceType
        present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let editedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            immy = editedImage
        }
//        } else if let originalImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
//            immy = originalImage
//        }
        
        
        dismiss(animated: true, completion: nil)
    }
}

