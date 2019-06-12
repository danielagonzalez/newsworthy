//
//  SecondViewController.swift
//  Newsworthy
//
//  Created by Daniela Gonzalez on 5/15/19.
//  Copyright © 2019 Daniela Gonzalez. All rights reserved.
//

import UIKit
//import Cocoa

class ArticleTableViewCell: UITableViewCell {
    @IBOutlet weak var headlineLabel: UILabel!
    @IBOutlet weak var sourceLabel: UILabel!
    @IBOutlet weak var imageLabel: UIImageView!
}

class BreakingNewsCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var headlineLabel: UILabel!
    @IBOutlet weak var breakingImage: UIImageView!
}

class SecondViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UICollectionViewDataSource, UICollectionViewDelegate {
    
    var words = [
        "Affirmative Action": ["affirmative action"],
        "Abortion" : ["abortion", "pro-life", "pro-choice", "reproductive rights", "roe v. wade"],
        "Border Wall" : ["wall", "border wall", "border", "the wall"],
        "Campaign Finance" : ["campaign finance", "super pac"],
        "Climate Change" : ["climate", "environment", "environmental", "global warming"],
        "Death Penalty" : ["death penalty", "capital punishment"],
        "Drugs" : ["drugs"],
        "Elections" : ["election", "campaigning"],
        "Equal Pay" : ["equal pay"],
        "First Ammendment" : ["first ammendment", "freedom of speech", "freedom of expression", "free speech"],
        "Gun Control" : ["gun", "firearm", "control", "second ammendment", "shooting"],
        "Healthcare" : ["healthcare", "health insurance", "obamacare", "affordable care act"],
        "Housing" : ["housing"],
        "Immigration" : ["immigration", "immigrant", "asylum", "family separation"],
        "Infrastructure" : ["infrastructure", "highways", "bridges"],
        "Israel" : ["israel", "netanyahu"],
        "Labor" : ["labor", "unions", "on strike", "striking"],
        "LGBTQ" : ["lgbt", "gay", "lesbian", "bisexual", "homosexual", "religious freedom restoration act", "queer", "transgender", "pride"],
        "Mental Health" : ["mental health", "therapy", "anxiety", "depression"],
        "Net Neutrality" : ["net", "neutrality"],
        "North Korea" : ["north korea", "kim jong un"],
        "Prisons" : ["prisons"],
        "Race" : ["race", "racism", "white supremacy", "black lives matter", "#blacklivesmatter"],
        "Refugees" : ["refugees"],
        "Sexual Assault" : ["sexual assault", "sexual harassment", "rape"],
        "Space Exploration" : ["space exploration"],
        "Taxes" : ["taxes"],
        "Tech" : ["facebook", "twitter", "google", "amazon", "tech", "data privacy", "social media", "silicon valley"],
        "Terrorism" : ["terrorism", "isis"]
    ]
    
    var headlines = [String]()
    var sources = [String]()
    var images = Dictionary<URL,UIImage>()
    var image_urls = [URL]()
    var urls = [String]()
    
    var breaking_headlines = [String]()
    var breaking_images = Dictionary<URL,UIImage>()
    var breaking_urls = [String]()
    var breaking_image_urls = [URL]()
    
    @IBOutlet var mainView: UIView!
    
    var bfArticles = Array<Dictionary<String,AnyObject>>()
    var hpArticles = Array<Dictionary<String,AnyObject>>()
    var nytArticles = Array<Dictionary<String,AnyObject>>()
    var wpArticles = Array<Dictionary<String,AnyObject>>()
    var nwArticles = Array<Dictionary<String,AnyObject>>()
    var poArticles = Array<Dictionary<String,AnyObject>>()
    var apArticles = Array<Dictionary<String,AnyObject>>()
    var reArticles = Array<Dictionary<String,AnyObject>>()
    var ftArticles = Array<Dictionary<String,AnyObject>>()
    var abcArticles = Array<Dictionary<String,AnyObject>>()
    var cbsArticles = Array<Dictionary<String,AnyObject>>()
    var wsjArticles = Array<Dictionary<String,AnyObject>>()
    var hillArticles = Array<Dictionary<String,AnyObject>>()
    var teArticles = Array<Dictionary<String,AnyObject>>()
    var nrArticles = Array<Dictionary<String,AnyObject>>()
    var foxArticles = Array<Dictionary<String,AnyObject>>()
    var topStories = Array<Dictionary<String,AnyObject>>()

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        collectionView.delegate = self
        collectionView.dataSource = self
        
        let bfURL = "https://newsapi.org/v2/everything?sources=buzzfeed&pageSize=100&apiKey=ae68ec6ff339405d9c2f7843ab786cbf"
        loadData(url: bfURL, dataCompletionHandler: { articles, error in
            if let articles = articles {
                self.abcArticles = articles
            }
        })
        
        let hpURL = "https://newsapi.org/v2/everything?sources=the-huffington-post&pageSize=100&apiKey=ae68ec6ff339405d9c2f7843ab786cbf"
        loadData(url: bfURL, dataCompletionHandler: { articles, error in
            if let articles = articles {
                self.hpArticles = articles
            }
        })
        
        let abcURL = "https://newsapi.org/v2/everything?sources=abc-news&pageSize=100&apiKey=ae68ec6ff339405d9c2f7843ab786cbf"
        loadData(url: abcURL, dataCompletionHandler: { articles, error in
            if let articles = articles {
                self.abcArticles = articles
            }
        })
        
        let cbsURL = "https://newsapi.org/v2/everything?sources=cbs-news&pageSize=100&apiKey=ae68ec6ff339405d9c2f7843ab786cbf"
        loadData(url: cbsURL, dataCompletionHandler: { articles, error in
            if let articles = articles {
                self.cbsArticles = articles
            }
        })
        
        let nytURL = "https://newsapi.org/v2/everything?sources=the-new-york-times&pageSize=100&apiKey=ae68ec6ff339405d9c2f7843ab786cbf"
        loadData(url: nytURL, dataCompletionHandler: { articles, error in
            if let articles = articles {
                self.nytArticles = articles
            }
        })
        
        let wpURL = "https://newsapi.org/v2/everything?sources=the-washington-post&pageSize=100&apiKey=ae68ec6ff339405d9c2f7843ab786cbf"
        loadData(url: wpURL, dataCompletionHandler: { articles, error in
            if let articles = articles {
                self.wpArticles = articles
            }
        })
        
        let nwURL = "https://newsapi.org/v2/everything?sources=newsweek&pageSize=100&apiKey=ae68ec6ff339405d9c2f7843ab786cbf"
        loadData(url: nwURL, dataCompletionHandler: { articles, error in
            if let articles = articles {
                self.nwArticles = articles
            }
        })
        
        let poURL = "https://newsapi.org/v2/everything?sources=politico&pageSize=100&apiKey=ae68ec6ff339405d9c2f7843ab786cbf"
        loadData(url: poURL, dataCompletionHandler: { articles, error in
            if let articles = articles {
                self.poArticles = articles
            }
        })
        
        let apURL = "https://newsapi.org/v2/everything?sources=associated-press&pageSize=100&apiKey=ae68ec6ff339405d9c2f7843ab786cbf"
        loadData(url: apURL, dataCompletionHandler: { articles, error in
            if let articles = articles {
                self.apArticles = articles
            }
        })
        
        let teURL = "https://newsapi.org/v2/everything?sources=the-economist&pageSize=100&apiKey=ae68ec6ff339405d9c2f7843ab786cbf"
        loadData(url: teURL, dataCompletionHandler: { articles, error in
            if let articles = articles {
                self.teArticles = articles
            }
        })
        
        let reURL = "https://newsapi.org/v2/everything?sources=reuters&pageSize=100&apiKey=ae68ec6ff339405d9c2f7843ab786cbf"
        loadData(url: reURL, dataCompletionHandler: { articles, error in
            if let articles = articles {
                self.reArticles = articles
            }
        })
        
        let ftURL = "https://newsapi.org/v2/everything?sources=financial-times&pageSize=100&apiKey=ae68ec6ff339405d9c2f7843ab786cbf"
        loadData(url: ftURL, dataCompletionHandler: { articles, error in
            if let articles = articles {
                self.ftArticles = articles
            }
        })
        
        let wsjURL = "https://newsapi.org/v2/everything?sources=the-wall-street-journal&pageSize=100&apiKey=ae68ec6ff339405d9c2f7843ab786cbf"
        loadData(url: wsjURL, dataCompletionHandler: { articles, error in
            if let articles = articles {
                self.wsjArticles = articles
            }
        })
        
        let hillURL = "https://newsapi.org/v2/everything?sources=the-hill&pageSize=100&apiKey=ae68ec6ff339405d9c2f7843ab786cbf"
        loadData(url: hillURL, dataCompletionHandler: { articles, error in
            if let articles = articles {
                self.hillArticles = articles
            }
        })
        
        let nrURL = "https://newsapi.org/v2/everything?sources=national-review&pageSize=100&apiKey=ae68ec6ff339405d9c2f7843ab786cbf"
        loadData(url: nrURL, dataCompletionHandler: { articles, error in
            if let articles = articles {
                self.nrArticles = articles
            }
        })
        
        let foxURL = "https://newsapi.org/v2/everything?sources=fox-news&pageSize=100&apiKey=ae68ec6ff339405d9c2f7843ab786cbf"
        loadData(url: foxURL, dataCompletionHandler: { articles, error in
            if let articles = articles {
                self.foxArticles = articles
            }
        })
        
        let topStoriesURL = "https://newsapi.org/v2/top-headlines?country=us&pageSize=10&apiKey=ae68ec6ff339405d9c2f7843ab786cbf"
        loadData(url: topStoriesURL, dataCompletionHandler: { articles, error in
            if let articles = articles {
                self.topStories = articles
            }
        })
        
        let defaults = UserDefaults.standard
        let previous = defaults.float(forKey: "Preference")
        if previous != 0.0 {
            if let tbc = self.tabBarController as? CustomTabController {
                tbc.preference = previous
            }
        }
        
        if let previous = defaults.object(forKey: "Topics") as? Array<String> {
            if let tbc = self.tabBarController as? CustomTabController {
                tbc.selectedTopics = previous
            }
        }
        
        tableView.reloadData()
        collectionView.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return headlines.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "articleCell", for: indexPath) as! ArticleTableViewCell
        cell.headlineLabel?.text = headlines[indexPath.item]
        cell.sourceLabel?.text = sources[indexPath.item]
        cell.imageLabel?.image = images[image_urls[indexPath.item]]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let url = URL(string: urls[indexPath.item])!
        UIApplication.shared.openURL(url)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       return breaking_headlines.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "breakingNewsCell", for: indexPath) as! BreakingNewsCollectionViewCell
        cell.headlineLabel?.text = breaking_headlines[indexPath.item]
        cell.breakingImage?.image = breaking_images[breaking_image_urls[indexPath.item]]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let url = URL(string: breaking_urls[indexPath.item])!
        UIApplication.shared.openURL(url)
    }
    
    @IBAction func submitButton(_ sender: Any) {
        refreshDigest()
    }
    
    func refreshDigest() {
        headlines = [String]()
        sources = [String]()
        images = Dictionary<URL,UIImage>()
        image_urls = [URL]()
        urls = [String]()
        breaking_headlines = [String]()
        breaking_images = Dictionary<URL,UIImage>()
        breaking_urls = [String]()
        breaking_image_urls = [URL]()
        if let tbc = self.tabBarController as? CustomTabController {
            if tbc.preference <= 0.4 {
                for article in self.bfArticles {
                    for topic in tbc.selectedTopics {
                        for word in words[topic]! {
                            let headline = article["title"]!
                            if headline.lowercased(with: nil).contains(word) {
                                headlines.append(article["title"] as! String)
                                sources.append("Buzzfeed")
                                urls.append(article["url"] as! String)
                                if !(article["urlToImage"] is NSNull) {
                                    if let imageURL = URL(string:article["urlToImage"] as! String) {
                                        image_urls.append(imageURL)
                                        images[imageURL] = UIImage(named: "newspaper")!
                                        self.loadImage(imageURL: imageURL, imageCompletionHandler: { img, error in
                                            self.images[imageURL] = img
                                            DispatchQueue.main.async {
                                                self.tableView.reloadData()
                                            }
                                        })
                                    } else {
                                        let imageURL = URL(string:"stanford.edu")!
                                        breaking_image_urls.append(imageURL)
                                        breaking_images[imageURL] = UIImage(named: "newspaper")!
                                    }
                                } else {
                                    let imageURL = URL(string:"stanford.edu")!
                                    image_urls.append(imageURL)
                                    images[imageURL] = UIImage(named: "newspaper")!
                                }
                            }
                        }
                    }
                }
                for article in self.hpArticles {
                    for topic in tbc.selectedTopics {
                        for word in words[topic]! {
                            let headline = article["title"]!
                            if headline.lowercased(with: nil).contains(word) {
                                headlines.append(article["title"] as! String)
                                sources.append("The Huffington Post")
                                urls.append(article["url"] as! String)
                                if !(article["urlToImage"] is NSNull) {
                                    if let imageURL = URL(string:article["urlToImage"] as! String) {
                                        image_urls.append(imageURL)
                                        images[imageURL] = UIImage(named: "newspaper")!
                                        self.loadImage(imageURL: imageURL, imageCompletionHandler: { img, error in
                                            self.images[imageURL] = img
                                            DispatchQueue.main.async {
                                                self.tableView.reloadData()
                                            }
                                        })
                                    } else {
                                        let imageURL = URL(string:"stanford.edu")!
                                        breaking_image_urls.append(imageURL)
                                        breaking_images[imageURL] = UIImage(named: "newspaper")!
                                    }
                                } else {
                                    let imageURL = URL(string:"stanford.edu")!
                                    image_urls.append(imageURL)
                                    images[imageURL] = UIImage(named: "newspaper")!
                                }
                            }
                        }
                    }
                }
            }
            if tbc.preference <= 0.6 {
                for article in self.nytArticles {
                    for topic in tbc.selectedTopics {
                        for word in words[topic]! {
                            let headline = article["title"]!
                            if headline.lowercased(with: nil).contains(word) {
                                headlines.append(article["title"] as! String)
                                sources.append("The New York Times")
                                urls.append(article["url"] as! String)
                                if !(article["urlToImage"] is NSNull) {
                                    if let imageURL = URL(string:article["urlToImage"] as! String) {
                                        image_urls.append(imageURL)
                                        images[imageURL] = UIImage(named: "newspaper")!
                                        self.loadImage(imageURL: imageURL, imageCompletionHandler: { img, error in
                                            self.images[imageURL] = img
                                            DispatchQueue.main.async {
                                                self.tableView.reloadData()
                                            }
                                        })
                                    } else {
                                        let imageURL = URL(string:"stanford.edu")!
                                        breaking_image_urls.append(imageURL)
                                        breaking_images[imageURL] = UIImage(named: "newspaper")!
                                    }
                                } else {
                                    let imageURL = URL(string:"stanford.edu")!
                                    image_urls.append(imageURL)
                                    images[imageURL] = UIImage(named: "newspaper")!
                                }
                            }
                        }
                    }
                }
                for article in self.wpArticles {
                    for topic in tbc.selectedTopics {
                        for word in words[topic]! {
                            let headline = article["title"]!
                            if headline.lowercased(with: nil).contains(word) {
                                headlines.append(article["title"] as! String)
                                sources.append("The Washington Post")
                                urls.append(article["url"] as! String)
                                if !(article["urlToImage"] is NSNull) {
                                    if let imageURL = URL(string:article["urlToImage"] as! String) {
                                        image_urls.append(imageURL)
                                        images[imageURL] = UIImage(named: "newspaper")!
                                        self.loadImage(imageURL: imageURL, imageCompletionHandler: { img, error in
                                            self.images[imageURL] = img
                                            DispatchQueue.main.async {
                                                self.tableView.reloadData()
                                            }
                                        })
                                    } else {
                                        let imageURL = URL(string:"stanford.edu")!
                                        breaking_image_urls.append(imageURL)
                                        breaking_images[imageURL] = UIImage(named: "newspaper")!
                                    }
                                } else {
                                    let imageURL = URL(string:"stanford.edu")!
                                    image_urls.append(imageURL)
                                    images[imageURL] = UIImage(named: "newspaper")!
                                }
                            }
                        }
                    }
                }
                for article in self.nwArticles {
                    for topic in tbc.selectedTopics {
                        for word in words[topic]! {
                            let headline = article["title"]!
                            if headline.lowercased(with: nil).contains(word) {
                                headlines.append(article["title"] as! String)
                                sources.append("Newsweek")
                                urls.append(article["url"] as! String)
                                if !(article["urlToImage"] is NSNull) {
                                    if let imageURL = URL(string:article["urlToImage"] as! String) {
                                        image_urls.append(imageURL)
                                        images[imageURL] = UIImage(named: "newspaper")!
                                        self.loadImage(imageURL: imageURL, imageCompletionHandler: { img, error in
                                            self.images[imageURL] = img
                                            DispatchQueue.main.async {
                                                self.tableView.reloadData()
                                            }
                                        })
                                    } else {
                                        let imageURL = URL(string:"stanford.edu")!
                                        breaking_image_urls.append(imageURL)
                                        breaking_images[imageURL] = UIImage(named: "newspaper")!
                                    }
                                } else {
                                    let imageURL = URL(string:"stanford.edu")!
                                    image_urls.append(imageURL)
                                    images[imageURL] = UIImage(named: "newspaper")!
                                }
                            }
                        }
                    }
                }
                for article in self.poArticles {
                    for topic in tbc.selectedTopics {
                        for word in words[topic]! {
                            let headline = article["title"]!
                            if headline.lowercased(with: nil).contains(word) {
                                headlines.append(article["title"] as! String)
                                sources.append("Politico")
                                urls.append(article["url"] as! String)
                                if !(article["urlToImage"] is NSNull) {
                                    if let imageURL = URL(string:article["urlToImage"] as! String) {
                                        image_urls.append(imageURL)
                                        images[imageURL] = UIImage(named: "newspaper")!
                                        self.loadImage(imageURL: imageURL, imageCompletionHandler: { img, error in
                                            self.images[imageURL] = img
                                            DispatchQueue.main.async {
                                                self.tableView.reloadData()
                                            }
                                        })
                                    } else {
                                        let imageURL = URL(string:"stanford.edu")!
                                        breaking_image_urls.append(imageURL)
                                        breaking_images[imageURL] = UIImage(named: "newspaper")!
                                    }
                                } else {
                                    let imageURL = URL(string:"stanford.edu")!
                                    image_urls.append(imageURL)
                                    images[imageURL] = UIImage(named: "newspaper")!
                                }
                            }
                        }
                    }
                }
            }
            if tbc.preference <= 0.8 && tbc.preference > 0.2 {
                for article in self.abcArticles {
                    for topic in tbc.selectedTopics {
                        for word in words[topic]! {
                            let headline = article["title"]!
                            if headline.lowercased(with: nil).contains(word) {
                                headlines.append(article["title"] as! String)
                                sources.append("ABC News")
                                urls.append(article["url"] as! String)
                                if !(article["urlToImage"] is NSNull) {
                                    if let imageURL = URL(string:article["urlToImage"] as! String) {
                                        image_urls.append(imageURL)
                                        images[imageURL] = UIImage(named: "newspaper")!
                                        self.loadImage(imageURL: imageURL, imageCompletionHandler: { img, error in
                                            self.images[imageURL] = img
                                            DispatchQueue.main.async {
                                                self.tableView.reloadData()
                                            }
                                        })
                                    } else {
                                        let imageURL = URL(string:"stanford.edu")!
                                        breaking_image_urls.append(imageURL)
                                        breaking_images[imageURL] = UIImage(named: "newspaper")!
                                    }
                                } else {
                                    let imageURL = URL(string:"stanford.edu")!
                                    image_urls.append(imageURL)
                                    images[imageURL] = UIImage(named: "newspaper")!
                                }
                            }
                        }
                    }
                }
                for article in self.apArticles {
                    for topic in tbc.selectedTopics {
                        for word in words[topic]! {
                            let headline = article["title"]!
                            if headline.lowercased(with: nil).contains(word) {
                                headlines.append(article["title"] as! String)
                                sources.append("The Associated Press")
                                urls.append(article["url"] as! String)
                                if !(article["urlToImage"] is NSNull) {
                                    if let imageURL = URL(string:article["urlToImage"] as! String) {
                                        image_urls.append(imageURL)
                                        images[imageURL] = UIImage(named: "newspaper")!
                                        self.loadImage(imageURL: imageURL, imageCompletionHandler: { img, error in
                                            self.images[imageURL] = img
                                            DispatchQueue.main.async {
                                                self.tableView.reloadData()
                                            }
                                        })
                                    } else {
                                        let imageURL = URL(string:"stanford.edu")!
                                        breaking_image_urls.append(imageURL)
                                        breaking_images[imageURL] = UIImage(named: "newspaper")!
                                    }
                                } else {
                                    let imageURL = URL(string:"stanford.edu")!
                                    image_urls.append(imageURL)
                                    images[imageURL] = UIImage(named: "newspaper")!
                                }
                            }
                        }
                    }
                }
                for article in self.reArticles {
                    for topic in tbc.selectedTopics {
                        for word in words[topic]! {
                            let headline = article["title"]!
                            if headline.lowercased(with: nil).contains(word) {
                                headlines.append(article["title"] as! String)
                                sources.append("Reuters")
                                urls.append(article["url"] as! String)
                                if !(article["urlToImage"] is NSNull) {
                                    if let imageURL = URL(string:article["urlToImage"] as! String) {
                                        image_urls.append(imageURL)
                                        images[imageURL] = UIImage(named: "newspaper")!
                                        self.loadImage(imageURL: imageURL, imageCompletionHandler: { img, error in
                                            self.images[imageURL] = img
                                            DispatchQueue.main.async {
                                                self.tableView.reloadData()
                                            }
                                        })
                                    } else {
                                        let imageURL = URL(string:"stanford.edu")!
                                        breaking_image_urls.append(imageURL)
                                        breaking_images[imageURL] = UIImage(named: "newspaper")!
                                    }
                                } else {
                                    let imageURL = URL(string:"stanford.edu")!
                                    image_urls.append(imageURL)
                                    images[imageURL] = UIImage(named: "newspaper")!
                                }
                            }
                        }
                    }
                }
                for article in self.ftArticles {
                    for topic in tbc.selectedTopics {
                        for word in words[topic]! {
                            let headline = article["title"]!
                            if headline.lowercased(with: nil).contains(word) {
                                headlines.append(article["title"] as! String)
                                sources.append("Financial Times")
                                urls.append(article["url"] as! String)
                                if !(article["urlToImage"] is NSNull) {
                                    if let imageURL = URL(string:article["urlToImage"] as! String) {
                                        image_urls.append(imageURL)
                                        images[imageURL] = UIImage(named: "newspaper")!
                                        self.loadImage(imageURL: imageURL, imageCompletionHandler: { img, error in
                                            self.images[imageURL] = img
                                            DispatchQueue.main.async {
                                                self.tableView.reloadData()
                                            }
                                        })
                                    } else {
                                        let imageURL = URL(string:"stanford.edu")!
                                        breaking_image_urls.append(imageURL)
                                        breaking_images[imageURL] = UIImage(named: "newspaper")!
                                    }
                                } else {
                                    let imageURL = URL(string:"stanford.edu")!
                                    image_urls.append(imageURL)
                                    images[imageURL] = UIImage(named: "newspaper")!
                                }
                            }
                        }
                    }
                }
            }
            if tbc.preference <= 1.0 && tbc.preference > 0.4 {
                for article in self.teArticles {
                    for topic in tbc.selectedTopics {
                        for word in words[topic]! {
                            let headline = article["title"]!
                            if headline.lowercased(with: nil).contains(word) {
                                headlines.append(article["title"] as! String)
                                sources.append("The Economist")
                                urls.append(article["url"] as! String)
                                if !(article["urlToImage"] is NSNull) {
                                    if let imageURL = URL(string:article["urlToImage"] as! String) {
                                        image_urls.append(imageURL)
                                        images[imageURL] = UIImage(named: "newspaper")!
                                        self.loadImage(imageURL: imageURL, imageCompletionHandler: { img, error in
                                            self.images[imageURL] = img
                                            DispatchQueue.main.async {
                                                self.tableView.reloadData()
                                            }
                                        })
                                    } else {
                                        let imageURL = URL(string:"stanford.edu")!
                                        breaking_image_urls.append(imageURL)
                                        breaking_images[imageURL] = UIImage(named: "newspaper")!
                                    }
                                } else {
                                    let imageURL = URL(string:"stanford.edu")!
                                    image_urls.append(imageURL)
                                    images[imageURL] = UIImage(named: "newspaper")!
                                }
                            }
                        }
                    }
                }
                for article in self.cbsArticles {
                    for topic in tbc.selectedTopics {
                        for word in words[topic]! {
                            let headline = article["title"]!
                            if headline.lowercased(with: nil).contains(word) {
                                headlines.append(article["title"] as! String)
                                sources.append("CBS News")
                                urls.append(article["url"] as! String)
                                if !(article["urlToImage"] is NSNull) {
                                    if let imageURL = URL(string:article["urlToImage"] as! String) {
                                        image_urls.append(imageURL)
                                        images[imageURL] = UIImage(named: "newspaper")!
                                        self.loadImage(imageURL: imageURL, imageCompletionHandler: { img, error in
                                            self.images[imageURL] = img
                                            DispatchQueue.main.async {
                                                self.tableView.reloadData()
                                            }
                                        })
                                    } else {
                                        let imageURL = URL(string:"stanford.edu")!
                                        breaking_image_urls.append(imageURL)
                                        breaking_images[imageURL] = UIImage(named: "newspaper")!
                                    }
                                } else {
                                    let imageURL = URL(string:"stanford.edu")!
                                    image_urls.append(imageURL)
                                    images[imageURL] = UIImage(named: "newspaper")!
                                }
                            }
                        }
                    }
                }
                for article in self.wsjArticles {
                    for topic in tbc.selectedTopics {
                        for word in words[topic]! {
                            let headline = article["title"]!
                            if headline.lowercased(with: nil).contains(word) {
                                headlines.append(article["title"] as! String)
                                sources.append("The Wall Street Journal")
                                urls.append(article["url"] as! String)
                                if !(article["urlToImage"] is NSNull) {
                                    if let imageURL = URL(string:article["urlToImage"] as! String) {
                                        image_urls.append(imageURL)
                                        images[imageURL] = UIImage(named: "newspaper")!
                                        self.loadImage(imageURL: imageURL, imageCompletionHandler: { img, error in
                                            self.images[imageURL] = img
                                            DispatchQueue.main.async {
                                                self.tableView.reloadData()
                                            }
                                        })
                                    } else {
                                        let imageURL = URL(string:"stanford.edu")!
                                        breaking_image_urls.append(imageURL)
                                        breaking_images[imageURL] = UIImage(named: "newspaper")!
                                    }
                                } else {
                                    let imageURL = URL(string:"stanford.edu")!
                                    image_urls.append(imageURL)
                                    images[imageURL] = UIImage(named: "newspaper")!
                                }
                            }
                        }
                    }
                }
                for article in self.hillArticles {
                    for topic in tbc.selectedTopics {
                        for word in words[topic]! {
                            let headline = article["title"]!
                            if headline.lowercased(with: nil).contains(word) {
                                headlines.append(article["title"] as! String)
                                sources.append("The Hill")
                                urls.append(article["url"] as! String)
                                if !(article["urlToImage"] is NSNull) {
                                    if let imageURL = URL(string:article["urlToImage"] as! String) {
                                        image_urls.append(imageURL)
                                        images[imageURL] = UIImage(named: "newspaper")!
                                        self.loadImage(imageURL: imageURL, imageCompletionHandler: { img, error in
                                            self.images[imageURL] = img
                                            DispatchQueue.main.async {
                                                self.tableView.reloadData()
                                            }
                                        })
                                    } else {
                                        let imageURL = URL(string:"stanford.edu")!
                                        breaking_image_urls.append(imageURL)
                                        breaking_images[imageURL] = UIImage(named: "newspaper")!
                                    }
                                } else {
                                    let imageURL = URL(string:"stanford.edu")!
                                    image_urls.append(imageURL)
                                    images[imageURL] = UIImage(named: "newspaper")!
                                }
                            }
                        }
                    }
                }
            }
            if tbc.preference > 0.6 {
                for article in self.foxArticles {
                    for topic in tbc.selectedTopics {
                        for word in words[topic]! {
                            let headline = article["title"]!
                            if headline.lowercased(with: nil).contains(word) {
                                headlines.append(article["title"] as! String)
                                sources.append("Fox News")
                                urls.append(article["url"] as! String)
                                if !(article["urlToImage"] is NSNull) {
                                    if let imageURL = URL(string:article["urlToImage"] as! String) {
                                        image_urls.append(imageURL)
                                        images[imageURL] = UIImage(named: "newspaper")!
                                        self.loadImage(imageURL: imageURL, imageCompletionHandler: { img, error in
                                            self.images[imageURL] = img
                                            DispatchQueue.main.async {
                                                self.tableView.reloadData()
                                            }
                                        })
                                    } else {
                                        let imageURL = URL(string:"stanford.edu")!
                                        breaking_image_urls.append(imageURL)
                                        breaking_images[imageURL] = UIImage(named: "newspaper")!
                                    }
                                } else {
                                    let imageURL = URL(string:"stanford.edu")!
                                    image_urls.append(imageURL)
                                    images[imageURL] = UIImage(named: "newspaper")!
                                }
                            }
                        }
                    }
                }
                for article in self.nrArticles {
                    for topic in tbc.selectedTopics {
                        for word in words[topic]! {
                            let headline = article["title"]!
                            if headline.lowercased(with: nil).contains(word) {
                                headlines.append(article["title"] as! String)
                                sources.append("National Review")
                                urls.append(article["url"] as! String)
                                if !(article["urlToImage"] is NSNull) {
                                    if let imageURL = URL(string:article["urlToImage"] as! String) {
                                        image_urls.append(imageURL)
                                        images[imageURL] = UIImage(named: "newspaper")!
                                        self.loadImage(imageURL: imageURL, imageCompletionHandler: { img, error in
                                            self.images[imageURL] = img
                                            DispatchQueue.main.async {
                                                self.tableView.reloadData()
                                            }
                                        })
                                    } else {
                                        let imageURL = URL(string:"stanford.edu")!
                                        breaking_image_urls.append(imageURL)
                                        breaking_images[imageURL] = UIImage(named: "newspaper")!
                                    }
                                } else {
                                    let imageURL = URL(string:"stanford.edu")!
                                    image_urls.append(imageURL)
                                    images[imageURL] = UIImage(named: "newspaper")!
                                }
                            }
                        }
                    }
                }
            }
            
            for article in self.topStories {
                breaking_headlines.append(article["title"] as! String)
                breaking_urls.append(article["url"] as! String)
                if !(article["urlToImage"] is NSNull) {
                    if let imageURL = URL(string:article["urlToImage"] as! String) {
                        breaking_image_urls.append(imageURL)
                        breaking_images[imageURL] = UIImage(named: "newspaper")!
                        self.loadImage(imageURL: imageURL, imageCompletionHandler: { img, error in
                            self.breaking_images[imageURL] = img
                            DispatchQueue.main.async {
                                self.collectionView.reloadData()
                            }
                        })
                    } else {
                        let imageURL = URL(string:"stanford.edu")!
                        breaking_image_urls.append(imageURL)
                        breaking_images[imageURL] = UIImage(named: "newspaper")!
                    }
                } else {
                    let imageURL = URL(string:"stanford.edu")!
                    breaking_image_urls.append(imageURL)
                    breaking_images[imageURL] = UIImage(named: "newspaper")!
                }
            }
            tableView.reloadData()
            collectionView.reloadData()
        }
    }
    
    func loadData(url: String, dataCompletionHandler: @escaping (Array<Dictionary<String,AnyObject>>?, Error?) -> Void) {
        var request = URLRequest(url: URL(string:url)!)
        request.httpMethod = "GET"
        let session = URLSession.shared
        let task = session.dataTask(with: request, completionHandler: { (data: Data?, response: URLResponse?, error: Error?) in
            do {
                let json = try JSONSerialization.jsonObject(with: data!) as! [String : AnyObject]
                var articles = Array<Dictionary<String,AnyObject>>()
                for a in json {
                    if a.key == "articles" {
                        articles = a.value as! Array<Dictionary<String,AnyObject>>
                    }
                }
                dataCompletionHandler(articles, nil)
            } catch {
                dataCompletionHandler(nil, error)
            }
        })
        
        task.resume()
    }
    
    func loadImage(imageURL: URL, imageCompletionHandler: @escaping (UIImage, Error?) -> Void) {
        let session = URLSession.shared
        let downloadTask = session.dataTask(with: imageURL, completionHandler: { (data: Data?, response: URLResponse?, error: Error?) in
            if let res = response as? HTTPURLResponse {
                if let imageData = data {
                    let image = UIImage(data: imageData)!
                    imageCompletionHandler(image, nil)
                } else {
                    imageCompletionHandler(UIImage(named: "newspaper")!, nil)
                }
            } else {
                imageCompletionHandler(UIImage(named: "newspaper")!, nil)
            }
        })
        downloadTask.resume()
    }
}

