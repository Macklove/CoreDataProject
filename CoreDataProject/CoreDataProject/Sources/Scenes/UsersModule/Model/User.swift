//
//  User.swift
//  CoreDataProject
//
//  Created by Евгений Макулов on 26.08.2022.
//
//

import CoreData

@objc(User)
class User: NSManagedObject {
    @NSManaged public var avatar: Data?
    @NSManaged public var birthDate: Date?
    @NSManaged public var gender: String?
    @NSManaged public var name: String?
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }
}
