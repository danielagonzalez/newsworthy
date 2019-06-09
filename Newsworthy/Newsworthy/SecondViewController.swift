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
}

class SecondViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UICollectionViewDataSource, UICollectionViewDelegate {
    
    var words = [
        "Affirmative Action": ["affirmative action"],
        "Abortion" : ["abortion", "pro-life", "pro-choice", "reproductive rights", "roe v. wade"],
        "Border Wall" : ["wall", "border wall", "border", "the wall"],
        "Campaign Finance" : ["campaign finance"],
        "Climate Change" : ["climate", "environment", "environmental", "global warming"],
        "Death Penalty" : ["death penalty", "capital punishment"],
        "Drugs" : ["drugs"],
        "Elections" : ["elections"],
        "Equal Pay" : ["equal pay"],
        "First Ammendment" : ["first ammendment", "freedom of speech", "freedom of expression", "free speech"],
        "Gun Control" : ["gun", "firearm", "control", "second ammendment", "shooting"],
        "Healthcare" : ["healthcare", "health insurance", "obamacare", "affordable care act"],
        "Housing" : ["housing"],
        "Immigration" : ["immigration", "immigrant", "asylum", "family separation"],
        "Infrastructure" : ["infrastructure"],
        "Israel" : ["israel"],
        "Labor" : ["labor"],
        "LGBTQ" : ["lgbt", "gay", "lesbian", "bisexual", "homosexual", "religious freedom restoration act", "queer", "transgender", "pride"],
        "Mental Health" : ["mental health", "therapy", "anxiety", "depression"],
        "Net Neutrality" : ["net", "neutrality"],
        "North Korea" : ["north korea"],
        "Prisons" : ["prisons"],
        "Race" : ["race"],
        "Refugees" : ["refugees"],
        "Sexual Assault" : ["sexual assault", "sexual harassment", "rape"],
        "Space Exploration" : ["space exploration"],
        "Taxes" : ["taxes"],
        "Tech" : ["facebook", "twitter", "google", "amazon", "tech", "data privacy", "social media", "silicon valley"],
        "Terrorism" : ["terrorism"]
    ]
    
    var headlines = [String]()
    var sources = [String]()
    var images = [UIImage]()
    
    var breaking = [String]()
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet var mainView: UIView!
    
    var preference = 0.5
    
    var nytArticles = Array<Dictionary<String,AnyObject>>()
    var apArticles = Array<Dictionary<String,AnyObject>>()
    var foxArticles = Array<Dictionary<String,AnyObject>>()
    var topStories = Array<Dictionary<String,AnyObject>>()
    
    var nytImages = [UIImage]()
    var apImages = [UIImage]()
    var foxImages = [UIImage]()
    
    @IBOutlet weak var preferenceSlider: UISlider!
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
//                for i in self.nytArticles.indices {
//                    self.nytImages.append(UIImage(named: "milo")!)
//                    if self.nytArticles[i]["urlToImage"] != nil {
//                        let imageURL = URL(string: self.nytArticles[i]["urlToImage"] as! String)!
//                        self.loadImage(imageURL: imageURL, imageCompletionHandler: { img, error in
//                            self.nytImages[i] = img
//                        })
//                    }
//                }
            }
        })
        
        let apURL = "https://newsapi.org/v2/everything?sources=associated-press&pageSize=100&apiKey=5694075ebf3948a7b12095c01d95c2f4"
        loadData(url: apURL, dataCompletionHandler: { articles, error in
            if let articles = articles {
                self.apArticles = articles
//                for i in self.apArticles.indices {
//                    self.apImages.append(UIImage(named: "milo")!)
//                    if self.apArticles[i]["urlToImage"] != nil {
//                        let imageURL = URL(string: self.apArticles[i]["urlToImage"] as! String)!
//                        self.loadImage(imageURL: imageURL, imageCompletionHandler: { img, error in
//                            self.apImages[i] = img
//                        })
//                    }
//                }
            }
        })
        
        let foxURL = "https://newsapi.org/v2/everything?sources=fox-news&pageSize=100&apiKey=5694075ebf3948a7b12095c01d95c2f4"
        loadData(url: foxURL, dataCompletionHandler: { articles, error in
            if let articles = articles {
                self.foxArticles = articles
//                for i in self.foxArticles.indices {
//                    self.foxImages.append(UIImage(named: "milo")!)
//                    if self.foxArticles[i]["urlToImage"] != nil {
//                        let imageURL = URL(string: self.foxArticles[i]["urlToImage"] as! String)!
//                        self.loadImage(imageURL: imageURL, imageCompletionHandler: { img, error in
//                            self.foxImages[i] = img
//                        })
//                    }
//                }
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
//        cell.imageLabel?.image = images[indexPath.item]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let url = URL(string: "https://google.com")!
        UIApplication.shared.openURL(url)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       return breaking.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "breakingNewsCell", for: indexPath) as! BreakingNewsCollectionViewCell
        cell.headlineLabel?.text = breaking[indexPath.item]
        return cell
    }
    
    @IBAction func submitButton(_ sender: Any) {
        headlines = [String]()
        sources = [String]()
        images = [UIImage]()
        preference = Double(preferenceSlider.value)
        if let tbc = self.tabBarController as? CustomTabController {
            print(tbc.selectedTopics)
            for article in self.nytArticles {
                for topic in tbc.selectedTopics {
                    for word in words[topic]! {
                        let headline = article["title"]!
                        if headline.lowercased(with: nil).contains(word) {
                            headlines.append(article["title"] as! String)
                            sources.append("The New York Times")
                        }
                    }
                }
            }
            //        for image in self.nytImages {
            //            images.append(image)
            //        }
            for article in self.apArticles {
                for topic in tbc.selectedTopics {
                    for word in words[topic]! {
                        let headline = article["title"]!
                        if headline.lowercased(with: nil).contains(word) {
                            headlines.append(article["title"] as! String)
                            sources.append("The Associated Press")
                        }
                    }
                }
            }
            //        for image in self.apImages {
            //            images.append(image)
            //        }
            for article in self.foxArticles {
                for topic in tbc.selectedTopics {
                    for word in words[topic]! {
                        let headline = article["title"]!
                        if headline.lowercased(with: nil).contains(word) {
                            headlines.append(article["title"] as! String)
                            sources.append("Fox News")
                        }
                    }
                }
            }
            //        for image in self.foxImages {
            //            images.append(image)
            //        }
            for article in self.topStories {
                breaking.append(article["title"] as! String)
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

