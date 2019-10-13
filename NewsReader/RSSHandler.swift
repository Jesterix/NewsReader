//
//  RSSHandler.swift
//  NewsReader
//
//  Created by Georgy Khaydenko on 12/10/2019.
//  Copyright © 2019 Georgy Khaydenko. All rights reserved.
//

import Foundation


class RSSHandler {
    
    let url = "http://developer.apple.com/swift/blog/"
    //news.rss"
    
    func getData() {
        let request = URLRequest(url: URL(fileURLWithPath: url))
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let data = data {
                print(String(data: data, encoding: .utf8) ?? "no data")
            }
            if let response = response {
                print(response)
            }
            if let error = error {
                print(error)
            }
//            XMLParserDelegate
            
                
        }
        
        task.resume()
        
    }
    
}
