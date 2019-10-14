//
//  FeedItem+CoreDataProperties.swift
//  NewsReader
//
//  Created by Georgy Khaydenko on 14/10/2019.
//  Copyright © 2019 Georgy Khaydenko. All rights reserved.
//
//

import Foundation
import CoreData


extension FeedItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FeedItem> {
        return NSFetchRequest<FeedItem>(entityName: "FeedItem")
    }

    @NSManaged public var content: String?
    @NSManaged public var data: Data?
    @NSManaged public var link: String?
    @NSManaged public var pubDate: Date?
    @NSManaged public var title: String?

}
