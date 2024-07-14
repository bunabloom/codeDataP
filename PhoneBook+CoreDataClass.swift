//
//  PhoneBook+CoreDataClass.swift
//  codeDataP
//
//  Created by bloom on 7/13/24.
//
//

import Foundation
import CoreData

@objc(PhoneBook)
public class PhoneBook: NSManagedObject {
    public static let className = "PhoneBook"
    public enum Key {
        static let name = "name"
        static let phoneNumber = "phoneNumber"
    }

}
