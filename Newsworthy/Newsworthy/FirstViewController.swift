//
//  FirstViewController.swift
//  Newsworthy
//
//  Created by Daniela Gonzalez on 5/15/19.
//  Copyright © 2019 Daniela Gonzalez. All rights reserved.
//

import UIKit

protocol TopicTableViewCellDelegate: class {
    func topicTableViewCellPressed()
}

class TopicTableViewCell: UITableViewCell {
    var buttonClicked = false
    weak var delegate: TopicTableViewCellDelegate?
    @IBOutlet weak var button: UIButton!
    
    @IBAction func likeButton(_ sender: UIButton) {
        buttonClicked = true
        delegate?.topicTableViewCellPressed()
    }
    
    override func prepareForReuse() {
        button.isSelected = false
    }
}

class FirstViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var topics = [
        "Affirmative Action",
        "Abortion",
        "Border Wall",
        "Campaign Finance",
        "Climate Change",
        "Death Penalty",
        "Drugs",
        "Elections",
        "Equal Pay",
        "First Ammendment",
        "Gun Control",
        "Healthcare",
        "Housing",
        "Immigration",
        "Infrastructure",
        "Israel",
        "Labor",
        "LGBTQ",
        "Mental Health",
        "Net Neutrality",
        "North Korea",
        "Prisons",
        "Race",
        "Refugees",
        "Sexual Assault",
        "Space Exploration",
        "Taxes",
        "Tech",
        "Terrorism"
    ]
    
    var buttons = Array(repeating: false, count: 29)
    
    @IBOutlet weak var tableView: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return topics.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "topicCell", for: indexPath) as! TopicTableViewCell
        cell.delegate = self
        let topic = topics[indexPath.item]
        cell.textLabel?.text = topic
        if let tbc = self.tabBarController as? CustomTabController {
            if cell.buttonClicked {
                if !tbc.selectedTopics.contains(topic) {
                    tbc.selectedTopics.append(topic)
                    print(tbc.selectedTopics)
                } else if tbc.selectedTopics.contains(topic) {
                    let index = tbc.selectedTopics.firstIndex(of: topic)!
                    tbc.selectedTopics.remove(at: index)
                    print(tbc.selectedTopics)
                }
                cell.buttonClicked = false
            }
            if tbc.selectedTopics.contains(topic) {
                cell.button.isSelected = true
            } else {
                cell.button.isSelected = false
            }
        }
        
//        cell.button.isSelected = buttons[indexPath.item]
        
//        print(buttons)
        return cell
    }
    
//    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: IndexPath) {
//        let cell = cell as! TopicTableViewCell
//        if buttons[indexPath.item] == true {
//            cell.button.isSelected = true
//        } else {
//            cell.button.isSelected = false
//        }
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
                
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
}

extension FirstViewController: TopicTableViewCellDelegate {
    func topicTableViewCellPressed() {
        tableView.reloadData()
    }
}
