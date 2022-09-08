//
//  Date+Ext.swift
//  CoreDataProject
//
//  Created by Евгений Макулов on 26.08.2022.
//

import Foundation

extension Date {
    func convertToString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        return formatter.string(from: self)
    }
}
