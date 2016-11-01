//
//  ViewController.swift
//  QiitaApiClientSample
//
//  Created by 鈴木大貴 on 2016/08/17.
//  Copyright © 2016年 szk-atmosphere. All rights reserved.
//

import UIKit
import QiitaApiClient
import SafariServices

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var loadAuthorizedUserButton: UIButton!
    
    fileprivate var items: [QiitaItem] = []
    fileprivate var stockCounts: [String : Int] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        imageView.layer.cornerRadius = 8
        imageView.clipsToBounds = true
        let identifier = ItemTableViewCell.reuseIdentifier
        tableView.register(UINib(nibName: identifier, bundle: nil), forCellReuseIdentifier: identifier)
        tableView.estimatedRowHeight = 70
        tableView.dataSource = self
        tableView.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    fileprivate func fetchAuthenticatedUser() {
        let method: QiitaHttpMethod = .get(.authenticatedUser)
        QiitaApiClient.default.request(method) { (response: QiitaResponse<QiitaAuthenticatedUser>) in
            switch response.result {
            case .success(let model):
                DispatchQueue.main.async {
                    self.nameLabel.text = model.name
                    self.userNameLabel.text = "@" + model.id
                    self.indicator.startAnimating()
                    self.loadAuthorizedUserButton.setTitle("Load", for: UIControlState())
                }
                self.fetchUserIcon(model.profileImageUrl)
                self.fetchAuthenticatedUserItems()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    fileprivate func fetchAuthenticatedUserItems() {
        let method: QiitaHttpMethod = .get(.authenticatedUserItems(page: 1, perPage: 100))
        QiitaApiClient.default.request(method) { (response: QiitaResponse<[QiitaItem]>) in
            switch response.result {
            case .success(let models):
                self.items = models
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    fileprivate func fetchUserIcon(_ url: URL) {
        let session = URLSession.shared
        let task = session.dataTask(with: url, completionHandler: { data, response, error in
            DispatchQueue.main.async {
                if let data = data {
                    self.imageView.image = UIImage(data: data)
                }
                self.indicator.stopAnimating()
            }
        }) 
        task.resume()
    }
    
    @IBAction func didTapLoadAuthorizedUser(_ sender: UIButton) {
        fetchAuthenticatedUser()
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ItemTableViewCell.reuseIdentifier) as! ItemTableViewCell
        let item = items[indexPath.row]
        cell.titleLabel.text = item.title
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        let url = items[indexPath.row].url
        let vc = SFSafariViewController(url: url)
        present(vc, animated: true, completion: nil)
    }
}
