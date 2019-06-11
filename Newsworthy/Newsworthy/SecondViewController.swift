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
    var images = [UIImage]()
    var urls = [String]()
    
    var breaking_headlines = [String]()
    var breaking_images = [UIImage]()
    var breaking_urls = [String]()
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet var mainView: UIView!
    
    var nytArticles = Array<Dictionary<String,AnyObject>>()
    var apArticles = Array<Dictionary<String,AnyObject>>()
    var foxArticles = Array<Dictionary<String,AnyObject>>()
    var topStories = Array<Dictionary<String,AnyObject>>()
    
    var nytImages = [UIImage]()
    var apImages = [UIImage]()
    var foxImages = [UIImage]()

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        collectionView.delegate = self
        collectionView.dataSource = self
        
        activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()
        let nytURL = "https://newsapi.org/v2/everything?sources=the-new-york-times&pageSize=100&apiKey=5694075ebf3948a7b12095c01d95c2f4"
        loadData(url: nytURL, dataCompletionHandler: { articles, error in
            if let articles = articles {
                self.nytArticles = articles
            }
        })
        
        let apURL = "https://newsapi.org/v2/everything?sources=associated-press&pageSize=100&apiKey=5694075ebf3948a7b12095c01d95c2f4"
        loadData(url: apURL, dataCompletionHandler: { articles, error in
            if let articles = articles {
                self.apArticles = articles
            }
        })
        
        let foxURL = "https://newsapi.org/v2/everything?sources=fox-news&pageSize=100&apiKey=5694075ebf3948a7b12095c01d95c2f4"
        loadData(url: foxURL, dataCompletionHandler: { articles, error in
            if let articles = articles {
                self.foxArticles = articles
            }
            DispatchQueue.main.async {
                self.activityIndicator.stopAnimating()
            }
        })
        
        let topStoriesURL = "https://newsapi.org/v2/top-headlines?country=us&pageSize=10&apiKey=5694075ebf3948a7b12095c01d95c2f4"
        loadData(url: topStoriesURL, dataCompletionHandler: { articles, error in
            if let articles = articles {
                self.topStories = articles
            }
            DispatchQueue.main.async {
                self.activityIndicator.stopAnimating()
            }
        })
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tableView.reloadData()
        collectionView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return headlines.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "articleCell", for: indexPath) as! ArticleTableViewCell
        cell.headlineLabel?.text = headlines[indexPath.item]
        cell.sourceLabel?.text = sources[indexPath.item]
        cell.imageLabel?.image = images[indexPath.item]
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
        cell.breakingImage?.image = breaking_images[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let url = URL(string: breaking_urls[indexPath.item])!
        UIApplication.shared.openURL(url)
    }
    
    @IBAction func submitButton(_ sender: Any) {
        headlines = [String]()
        sources = [String]()
        images = [UIImage]()
        urls = [String]()
        breaking_headlines = [String]()
        breaking_images = [UIImage]()
        breaking_urls = [String]()
        if let tbc = self.tabBarController as? CustomTabController {
            print(tbc.selectedTopics)
            var index = 0
            if tbc.preference <= 0.33 {
                for article in self.nytArticles {
                    for topic in tbc.selectedTopics {
                        for word in words[topic]! {
                            let headline = article["title"]!
                            if headline.lowercased(with: nil).contains(word) {
                                headlines.append(article["title"] as! String)
                                sources.append("The New York Times")
                                urls.append(article["url"] as! String)
                                images.append(UIImage(named: "milo")!)
                                let imageURL = URL(string:article["urlToImage"] as! String)!
                                self.loadImage(imageURL: imageURL, imageCompletionHandler: { img, error in
                                    self.images[index] = img
                                    index += 1
                                    DispatchQueue.main.async {
                                        self.tableView.reloadData()
                                    }
                                })
                            }
                        }
                    }
                }
            }
            if tbc.preference > 0.33 && tbc.preference <= 0.66 {
                for article in self.apArticles {
                    for topic in tbc.selectedTopics {
                        for word in words[topic]! {
                            let headline = article["title"]!
                            if headline.lowercased(with: nil).contains(word) {
                                headlines.append(article["title"] as! String)
                                sources.append("The Associated Press")
                                urls.append(article["url"] as! String)
                                images.append(UIImage(named: "milo")!)
                                let imageURL = URL(string:article["urlToImage"] as! String)!
                                self.loadImage(imageURL: imageURL, imageCompletionHandler: { img, error in
                                    self.images[index] = img
                                    index += 1
                                    DispatchQueue.main.async {
                                        self.tableView.reloadData()
                                    }
                                })                            }
                        }
                    }
                }
            }
            if tbc.preference > 0.66 {
                for article in self.foxArticles {
                    for topic in tbc.selectedTopics {
                        for word in words[topic]! {
                            let headline = article["title"]!
                            if headline.lowercased(with: nil).contains(word) {
                                headlines.append(article["title"] as! String)
                                sources.append("Fox News")
                                urls.append(article["url"] as! String)
                                images.append(UIImage(named: "milo")!)
                                let imageURL = URL(string:article["urlToImage"] as! String)!
                                self.loadImage(imageURL: imageURL, imageCompletionHandler: { img, error in
                                    self.images[index] = img
                                    index += 1
                                    DispatchQueue.main.async {
                                        self.tableView.reloadData()
                                    }
                                })
                            }
                        }
                    }
                }
            }
            var i = 0
            for article in self.topStories {
                breaking_headlines.append(article["title"] as! String)
                breaking_urls.append(article["url"] as! String)
                breaking_images.append(UIImage(named: "milo")!)
                let imageURL = URL(string:article["urlToImage"] as! String)!
                self.loadImage(imageURL: imageURL, imageCompletionHandler: { img, error in
                    self.breaking_images[i] = img
                    i += 1
                    DispatchQueue.main.async {
                        self.collectionView.reloadData()
                    }
                })
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
                    print("Downloaded image with response code \(res.statusCode)")
                    let image = UIImage(data: imageData)!
                    imageCompletionHandler(image, nil)
                } else {
                    imageCompletionHandler(UIImage(named: "milo")!, nil)
                }
            } else {
                print("Couldn't get response code")
                imageCompletionHandler(UIImage(named: "milo")!, nil)
            }
        })
        downloadTask.resume()
    }
}

