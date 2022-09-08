//
//  String+Ext.swift
//  CoreDataProject
//
//  Created by Евгений Макулов on 26.08.2022.
//

import Foundation

extension String {
    func convertToDate() -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        return formatter.date(from: self)
    }
}
