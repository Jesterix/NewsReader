//
//  FeedItem+CoreDataClass.swift
//  NewsReader
//
//  Created by Georgy Khaydenko on 14/10/2019.
//  Copyright © 2019 Georgy Khaydenko. All rights reserved.
//
//

import Foundation
import CoreData

@objc(FeedItem)
public class FeedItem: NSManagedObject {

    convenience init() {
        self.init(entity: CoreDataManager.instance.entityForName(entityName: "FeedItem"), insertInto: CoreDataManager.instance.persistentContainer.viewContext)
    }
    
}
