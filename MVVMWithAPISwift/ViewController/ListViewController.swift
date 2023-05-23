//
//  ListViewController.swift
//  MVVMWithAPISwift
//
//  Created by Adil on 23.05.2023.
//  Copyright © 2023 Adil Zhabaginov. All rights reserved.
//
import UIKit

class ListViewController: UIViewController  {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var viewModel = ListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pageSetup()
    }
    
    func pageSetup()  {
        activityIndicator.startAnimating()
        tableViewSetup()
        viewModel.getListData()
        closureSetUp()
    }
    
    func closureSetUp()  {
        viewModel.reload = { [weak self] ()  in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
                self?.activityIndicator.stopAnimating()
            }
        }
        viewModel.errorM = { [weak self] (message)  in
            DispatchQueue.main.async {
                print(message)
                self?.activityIndicator.stopAnimating()
            }
        }
    }
}

extension ListViewController : UITableViewDelegate, UITableViewDataSource{
    func tableViewSetup()  {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 63
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ListTableViewCell.self)) as! ListTableViewCell
        
        let listObj = viewModel.list[indexPath.row]
        cell.labelTitle.text = "Fact \(indexPath.row + 1)"
        cell.labelDescription.text = listObj.fact ?? ""
        
        if ((indexPath.row % 2) != 0) {
            cell.contentView.backgroundColor = UIColor.lightGray
        } else {
            cell.contentView.backgroundColor = UIColor.clear
        }
        
        return cell
    }
}

