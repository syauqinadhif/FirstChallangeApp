//
//  Transaction+CoreDataProperties.swift
//  FirstChallange
//
//  Created by Syauqi Ikhlasun Nadhif on 20/03/25.
//
//

import Foundation
import CoreData


extension Transaction {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Transaction> {
        return NSFetchRequest<Transaction>(entityName: "Transaction")
    }

    @NSManaged public var amount: Double
    @NSManaged public var category: String?
    @NSManaged public var date: Date?
    @NSManaged public var id: UUID?
    @NSManaged public var isExpense: Bool

}

extension Transaction : Identifiable {

}
