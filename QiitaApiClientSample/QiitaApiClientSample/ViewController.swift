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
    
    private var items: [QiitaItem] = []
    private var stockCounts: [String : Int] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        imageView.layer.cornerRadius = 8
        imageView.clipsToBounds = true
        let identifier = ItemTableViewCell.reuseIdentifier
        tableView.registerNib(UINib(nibName: identifier, bundle: nil), forCellReuseIdentifier: identifier)
        tableView.estimatedRowHeight = 70
        tableView.dataSource = self
        tableView.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func fetchAuthenticatedUser() {
        let method: QiitaHttpMethod = .Get(.AuthenticatedUser)
        QiitaApiClient.sharedClient.request(method, success: { (response, model: QiitaAuthenticatedUser) in
            dispatch_async(dispatch_get_main_queue()) {
                self.nameLabel.text = model.name
                self.userNameLabel.text = "@" + model.id
                self.indicator.startAnimating()
                self.loadAuthorizedUserButton.setTitle("Load", forState: .Normal)
            }
            self.fetchUserIcon(model.profileImageUrl)
            self.fetchAuthenticatedUserItems()
        }, failure: { print($0) })
    }
    
    private func fetchAuthenticatedUserItems() {
        let method: QiitaHttpMethod = .Get(.AuthenticatedUserItems(page: 1, perPage: 100))
        QiitaApiClient.sharedClient.request(method, success: { (response, models: [QiitaItem]) in
            self.items = models
            dispatch_async(dispatch_get_main_queue()) {
                self.tableView.reloadData()
            }
        }, failure: { print($0) })
    }
    
    private func fetchUserIcon(url: NSURL) {
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithURL(url) { data, response, error in
            dispatch_async(dispatch_get_main_queue()) {
                if let data = data {
                    self.imageView.image = UIImage(data: data)
                }
                self.indicator.stopAnimating()
            }
        }
        task.resume()
    }
    
    @IBAction func didTapLoadAuthorizedUser(sender: UIButton) {
        fetchAuthenticatedUser()
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(ItemTableViewCell.reuseIdentifier) as! ItemTableViewCell
        let item = items[indexPath.row]
        cell.titleLabel.text = item.title
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: false)
        let url = items[indexPath.row].url
        let vc = SFSafariViewController(URL: url)
        presentViewController(vc, animated: true, completion: nil)
    }
}
