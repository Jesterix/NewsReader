//
//  NewsListViewController.swift
//  NewsReader
//
//  Created by Georgy Khaydenko on 12/10/2019.
//  Copyright © 2019 Georgy Khaydenko. All rights reserved.
//

import UIKit
import FeedKit
import CoreData

final class NewsListViewController: UIViewController, NSFetchedResultsControllerDelegate {
    
    var fetchResultController = NSFetchedResultsController<FeedItem>()
    
    let feedURL = URL(string: "https://rss.nytimes.com/services/xml/rss/nyt/HomePage.xml")!
    // rss for testing1   https://rss.nytimes.com/services/xml/rss/nyt/HomePage.xml
    // rss for testing2   https://developer.apple.com/swift/blog/news.rss
    
    var news: [FeedItem] = []
    
    var indexToTransite = 0
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        CoreDataManager.instance.deleteAll()
        fetchData()
        
    }
    
    func parseData() {
        let parser = FeedParser(URL: feedURL)
        
        parser.parseAsync(queue: DispatchQueue.global(qos: .userInitiated)) { (result) in
            switch result {
            case .success(let feed):
                if let parsedFeed = feed.rssFeed {
                    if let items = parsedFeed.items {
                        for item in items {
                            if self.news.contains(where: {$0.title == item.title}) {
//                                print("\(String(describing: item.title)) exists")
                            } else {
                                let feedItem = FeedItem()
                                guard let title = item.title else { return }
                                feedItem.title = title
                                feedItem.link = item.link
                                feedItem.content = item.description
                                feedItem.pubDate = item.pubDate
                                
                                self.news.append(feedItem)
                                CoreDataManager.instance.saveContext()
                            }
                        }
                    }
                }
                
            case .failure(let error):
                print(error)
            }
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            
            
        }
    }
    
    func fetchData() {
        //        Fetch data from data storage
        let fetchRequest: NSFetchRequest<FeedItem> = FeedItem.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "pubDate", ascending: false)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        let context = CoreDataManager.instance.persistentContainer.viewContext
        fetchResultController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        fetchResultController.delegate = self
        
        do {
            try fetchResultController.performFetch()
            if let fetchedObjects = fetchResultController.fetchedObjects {
                news = fetchedObjects
            }
        } catch {
            print(error)
        }
        
        DispatchQueue.main.async {
            self.parseData()
        }
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showText" {
            if var vc = segue.destination as? ContentPresenter {
                vc.contentItemToShow = news[indexToTransite]
            }
        }
    }
    
}


extension NewsListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return news.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "")
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.text =  news[indexPath.row].title
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        indexToTransite = indexPath.row
        performSegue(withIdentifier: "showText", sender: self)
    }
}
