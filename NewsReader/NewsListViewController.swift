//
//  NewsListViewController.swift
//  NewsReader
//
//  Created by Georgy Khaydenko on 12/10/2019.
//  Copyright © 2019 Georgy Khaydenko. All rights reserved.
//

import UIKit

class NewsListViewController: UIViewController {

    let rssHandler = RSSHandler()
    var news: [(String,String)] = [("First News","It's start."),
                                   ("Second news","In the middle."),
                                    ("Third news","The end is near.")]
    var indexToTransite = 0
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        rssHandler.getData()

    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showText" {
            if var vc = segue.destination as? TextPresenter {
                vc.textToShow = news[indexToTransite].1
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
        cell.textLabel?.text =  news[indexPath.row].0
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        indexToTransite = indexPath.row
        performSegue(withIdentifier: "showText", sender: self)
    }
}
