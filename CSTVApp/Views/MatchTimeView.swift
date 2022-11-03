//
//  MatchTimeView.swift
//  CSTVApp
//
//  Created by Diego Benites Lopes on 02/11/22.
//

import SwiftUI

struct MatchTimeView: View {
    let date: Date?
    
    private var bgColor: Color {
        guard let date = date else {
            return .gray
        }
        
        let red = Color(red: 0.957, green: 0.165, blue: 0.208, opacity: 1)
        let gray = Color(red: 0.979, green: 0.979, blue: 0.979, opacity: 0.2)
        
        return Date() > date ? red : gray
    }
    
    var body: some View {
        Text(scheduleDescription(date))
            .foregroundColor(.white)
            .font(.custom("Roboto", size: 8))
            .frame(height: 25)
            .padding(.horizontal, 8)
            .background(
                CustomRoundedRectangle(corners: [.topRight, .bottomLeft], cornerRadius: 16)
                    .fill(bgColor)
            )
    }
    
    private func scheduleDescription(_ time: Date?) -> String {
        guard let date = time else {
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
