//
//  MTTransaction+CoreDataProperties.swift
//  CalendarDemo
//
//  Created by taro.hiraishi on 2023/04/06.
//
//

import Foundation
import CoreData


extension MTTransaction {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<MTTransaction> {
        return NSFetchRequest<MTTransaction>(entityName: "MTTransaction")
    }

    @NSManaged public var amount: Int32
    @NSManaged public var category: String?
    @NSManaged public var currency: String?
    @NSManaged public var date: Date?
    @NSManaged public var id: String?
    @NSManaged public var memo: String?
    @NSManaged public var receipt: String?
    @NSManaged public var usage: String?

}

extension MTTransaction : Identifiable {
}
