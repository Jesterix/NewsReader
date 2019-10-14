//
//  NewsTextViewController.swift
//  NewsReader
//
//  Created by Georgy Khaydenko on 12/10/2019.
//  Copyright © 2019 Georgy Khaydenko. All rights reserved.
//

import UIKit
import WebKit

protocol ContentPresenter {
    var contentItemToShow: FeedItem? { get set }
}

final class NewsTextViewController: UIViewController, ContentPresenter {

    var contentItemToShow: FeedItem? {
        didSet {
                configureView()
        }
    }
    
    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    func configureView() {
        // Update the user interface for the detail item.
        guard webView != nil, let contentItem = contentItemToShow, let link = contentItem.link, let url = URL(string: link) else { return }
        
        if let data = contentItem.data {
            webView.load(data, mimeType: "", characterEncodingName: "", baseURL: url)
        } else {
            do {
                let newData = try Data(contentsOf: url)
                contentItem.data = newData
                CoreDataManager.instance.saveContext()
                
                DispatchQueue.main.async {
                    self.webView.load(newData, mimeType: "", characterEncodingName: "", baseURL: url)
                }
                
            } catch {
                print("error in data")
            }
        }
    }
}
