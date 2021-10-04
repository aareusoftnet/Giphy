//
//  Date.swift
//  Giphy
//

import UIKit

let _serverFormatter: DateFormatter = {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
    dateFormatter.locale = Locale(identifier: "en_US_POSIX")
    return dateFormatter
}()

//MARK: -
extension Date {
    
    //Initialise date from server response
    static func dateFromServer(_ dateString: String, format: String = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'") -> Date? {
        _serverFormatter.dateFormat = format
        return _serverFormatter.date(from: dateString)
    }
    
    func timeAgoSinceDate(_ numericDates:Bool) -> String {
        let calendar = NSCalendar.current
        let unitFlags: Set<Calendar.Component> = [.minute, .hour, .day, .weekOfYear, .month, .year, .second]
        let now = NSDate()
        let earliest = now.earlierDate(self)
        let latest = (earliest == now as Date) ? self : now as Date
        let components = calendar.dateComponents(unitFlags, from: earliest as Date,  to: latest as Date)
        
        if (components.year! >= 2) {
            return components.year!.description + " " + "~Years ago".localized
        } else if (components.year! >= 1){
            if (numericDates){
                return components.year!.description + " " + "~Year ago".localized
            } else {
                return "~Last year".localized
            }
        } else if (components.month! >= 2) {
            return components.month!.description + " " + "~Months ago".localized
        } else if (components.month! >= 1){
            if (numericDates){
                return components.month!.description + " " + "~Month ago".localized
            } else {
                return "~Last month".localized
            }
        } else if (components.weekOfYear! >= 2) {
            return components.weekOfYear!.description + " " + "~Weeks ago".localized
        } else if (components.weekOfYear! >= 1){
            if (numericDates){
                return components.weekOfYear!.description + " " + "~Week ago".localized
            } else {
                return "~Last week".localized
            }
        } else if (components.day! >= 2) {
            return components.day!.description + " " + "~Days ago".localized
        } else if (components.day! >= 1){
            if (numericDates){
                return components.day!.description + " " + "~Day ago".localized
            } else {
                return "~Last day".localized
            }
        } else if (components.hour! >= 2) {
            return components.hour!.description + " " + "~Hours ago".localized
        } else if (components.hour! >= 1){
            if (numericDates){
                return components.hour!.description + " " + "~Hour ago".localized
            } else {
                return "~Last hour".localized
            }
        } else if (components.minute! >= 2) {
            return components.minute!.description + " " + "~Minutes ago".localized
        } else if (components.minute! >= 1){
            if (numericDates){
                return components.minute!.description + " " + "~Minute ago".localized
            } else {
                return "~Last minute".localized
            }
        } else if (components.second! >= 3) {
            return components.second!.description + " " + "~Seconds ago".localized
        } else {
            return "~Just now".localized
        }
    }
}
