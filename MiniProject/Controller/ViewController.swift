//
//  ViewController.swift
//  MiniProject
//
//  Created by user199474 on 7/1/21.
//

import UIKit
import SafariServices

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    var indicatorView : UIView?
    private var items = [Item]()
    var listOfItems = [Item]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.navigationItem.title = "\(self.listOfItems.count) Item found"
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Github Repositories"
        searchBar.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        
    }

}
 
extension ViewController: UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listOfItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "itemTableViewCell", for: indexPath) as! itemTableViewCell
        let item = listOfItems[indexPath.row]
        cell.nameLbl.text = item.full_name
        cell.loginLbl.text = item.owner?.login
        cell.descriptionLbl.text = item.description
        cell.imgView.layer.cornerRadius = 10

        if let url = URL(string: (item.owner?.avatar_url)!) {
            if let image = try? Data(contentsOf: url) {
                cell.imgView.image = UIImage(data: image)
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
//        tableView.deselectRow(at: indexPath, animated: true)
        if let url = URL(string: listOfItems[indexPath.row].html_url!) {
            let vc = SFSafariViewController(url: url)
            present(vc, animated: true, completion: nil)
        }
//        guard let url = URL(string: Item!) else {
//            return
//        }
       
    }
    func showSpinner() {
        indicatorView = UIView(frame: self.view.bounds)
        indicatorView?.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        let activity = UIActivityIndicatorView(style: .large)
        activity.center = indicatorView!.center
        activity.startAnimating()
        indicatorView?.addSubview(activity)
        self.view.addSubview(indicatorView!)
    }
    func removeSpinner() {
        indicatorView?.removeFromSuperview()
        indicatorView = nil
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        Timer.scheduledTimer(withTimeInterval: 0, repeats: false) { (t) in
            self.showSpinner()
            print("spinner done")
        
        }
        guard let searchBarText = searchBar.text else {
            return
        }
        Timer.scheduledTimer(withTimeInterval: 0.7, repeats: false) { (t) in
            print("spinner done")
            self.removeSpinner()
        }
        let itemRequest = Parser(gitSearch: searchBarText)
        itemRequest.getparser { [weak self] result in
            switch result {
            case.failure(let error):
                print(error)
                case .success(let items):
                    self?.listOfItems = items
            }
        }
    }

}


