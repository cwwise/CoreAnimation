//
//  ViewController.swift
//  CoreAnimation
//
//  Created by chenwei on 2018/2/24.
//  Copyright © 2018年 chenwei. All rights reserved.
//

import UIKit

protocol DefaultControllerConfiguration {
    func setupDefaultConfiguration()
}

extension DefaultControllerConfiguration where Self: UIViewController {
    func setupDefaultConfiguration() {
        self.view.backgroundColor = UIColor.white
    }
}

class RootController: UITableViewController {
    
    struct Item {
        var title: String
        var controller: UIViewController.Type
    }
    
    var itemList: [Item] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "CoreAnimation"
        self.tableView.tableFooterView = UIView()

        setupData()
    }
    
    func setupData() {
        let item0 = Item(title: "PropertyAnimator", controller: PropertyAnimatorController.self)
        let item1 = Item(title: "ViewController1", controller: ViewController1.self)

        itemList.append(item0)
        itemList.append(item1)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: TabelViewDataSource
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let item = itemList[indexPath.row]
        cell.textLabel?.text = item.title
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let item = itemList[indexPath.row]
        let controller = item.controller.init()
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
}
