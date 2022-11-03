//
//  Date+.swift
//  CSTVApp
//
//  Created by Diego Benites Lopes on 02/11/22.
//

import Foundation

extension Optional where Wrapped == Date {
    var relativeDescription: String {
        guard let date = self else {
            return "NA"
        }
        
        if Date() > date {
            return "AGORA"
        }
        
        let formatter = DateFormatter()
        formatter.locale = Locale.current
        
        if formatter.calendar.isDateInToday(date) {
            formatter.dateFormat = "HH:mm"
            return "Hoje, \(formatter.string(from: date))"
        }
        
        if formatter.calendar.isDateInTomorrow(date) {
            formatter.dateFormat = "E, HH:mm"
        } else {
            formatter.dateFormat = "dd.MM HH:mm"
        }
        
        return formatter.string(from: date)
    }
}
