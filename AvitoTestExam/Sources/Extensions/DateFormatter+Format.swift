//
//  DateFormatter+Format.swift
//  AvitoTestExam
//
//  Created by Степан Потапов on 31.08.2023.
//

import Foundation

fileprivate enum Constants {
    static let dayOfWeek = "E"
    static let dayOfMonth = "d"
    static let fullMonthYear = "LLLL yyyy"
    static let yearMonthDayISO = "yyyy-MM-dd"
    static let shortHoursMinutes = "H:mm"
    static let dayMonthDisplay = "d MMMM"
    static let dayMonthYearDisplay = "d MMMM yyyy"
}

extension DateFormatter {
    static let dayOfWeek = dateFormatter(format: Constants.dayOfWeek)
    static let dayOfMonth = dateFormatter(format: Constants.dayOfMonth)
    static let fullMonthYear = dateFormatter(format: Constants.fullMonthYear)
    static let yearMonthDayISO = dateFormatter(format: Constants.yearMonthDayISO)
    static let shortHoursMinutes = dateFormatter(format: Constants.shortHoursMinutes)
    static let dayMonthDisplay = dateFormatter(format: Constants.dayMonthDisplay)
    static let dayMonthYearDisplay = dateFormatter(format: Constants.dayMonthYearDisplay)
    static let yearMonthDayGMT0 = dateFormatter(format: Constants.yearMonthDayISO,
                                                timeZone: TimeZone(secondsFromGMT: 0))
    
    private static func dateFormatter(format: String, timeZone: TimeZone? = .current) -> DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.locale = .current
        dateFormatter.timeZone = timeZone
        return dateFormatter
    }
}
