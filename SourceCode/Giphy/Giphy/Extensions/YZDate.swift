//
//  YZDate.swift
//  YZClasses
//
//  Created by Vipul Patel on 19/02/21.
//

let _serverFormatter: DateFormatter = {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
    dateFormatter.locale = Locale(identifier: "en_US_POSIX")
    return dateFormatter
}()

let _localFormatter: DateFormatter = {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "EEE, dd-MMM-yyyy, hh:mm a"
    return dateFormatter
}()

//MARK: -
extension Date {
    
    var weekDay: String {
        return dayNameFrom(Calendar.current.component(.weekday, from: self))
    }
    
    func isLessThanDate(dateToCompare: Date) -> Bool {
        return compare(dateToCompare) == .orderedAscending
    }
}

//MARK: -
extension Date {
    
    //Initialise date from server response
    static func dateFromServer(_ dateString: String, format: String = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'") -> Date? {
        _serverFormatter.dateFormat = format
        return _serverFormatter.date(from: dateString)
    }
    
    func stringFromLocal(_ format: String = "dd.MM.yyyy") -> String {
        _localFormatter.dateFormat = format
        return _localFormatter.string(from: self)
    }

    func dayNameFrom(_ int : Int ) -> String {
        switch int {
        case 1:
            return YZApp.shared.getLocalizedText("sunday")
        case 2:
            return YZApp.shared.getLocalizedText("monday")
        case 3:
            return YZApp.shared.getLocalizedText("tuesday")
        case 4:
            return YZApp.shared.getLocalizedText("wednesday")
        case 5:
            return YZApp.shared.getLocalizedText("thursday")
        case 6:
            return YZApp.shared.getLocalizedText("friday")
        case 7:
            return YZApp.shared.getLocalizedText("saturday")
        default:
            fatalError("NO MORE WEEKDAYs IN WORLD.")
        }
    }
    
    func timeAgoSinceDate(_ numericDates:Bool) -> String {
        let calendar = NSCalendar.current
        let unitFlags: Set<Calendar.Component> = [.minute, .hour, .day, .weekOfYear, .month, .year, .second]
        let now = NSDate()
        let earliest = now.earlierDate(self)
        let latest = (earliest == now as Date) ? self : now as Date
        let components = calendar.dateComponents(unitFlags, from: earliest as Date,  to: latest as Date)
        
        if (components.year! >= 2) {
            return components.year!.description + " " + YZApp.shared.getLocalizedText("years_ago")
        } else if (components.year! >= 1){
            if (numericDates){
                return components.year!.description + " " + YZApp.shared.getLocalizedText("year_ago")
            } else {
                return YZApp.shared.getLocalizedText("last_year")
            }
        } else if (components.month! >= 2) {
            return components.month!.description + " " + YZApp.shared.getLocalizedText("months_ago")
        } else if (components.month! >= 1){
            if (numericDates){
                return components.month!.description + " " + YZApp.shared.getLocalizedText("month_ago")
            } else {
                return YZApp.shared.getLocalizedText("last_month")
            }
        } else if (components.weekOfYear! >= 2) {
            return components.weekOfYear!.description + " " + YZApp.shared.getLocalizedText("weeks_ago")
        } else if (components.weekOfYear! >= 1){
            if (numericDates){
                return components.weekOfYear!.description + " " + YZApp.shared.getLocalizedText("week_ago")
            } else {
                return YZApp.shared.getLocalizedText("last_week")
            }
        } else if (components.day! >= 2) {
            return components.day!.description + " " + YZApp.shared.getLocalizedText("days_ago")
        } else if (components.day! >= 1){
            if (numericDates){
                return components.day!.description + " " + YZApp.shared.getLocalizedText("day_ago")
            } else {
                return YZApp.shared.getLocalizedText("last_day")
            }
        } else if (components.hour! >= 2) {
            return components.hour!.description + " " + YZApp.shared.getLocalizedText("hours_ago")
        } else if (components.hour! >= 1){
            if (numericDates){
                return components.hour!.description + " " + YZApp.shared.getLocalizedText("hour_ago")
            } else {
                return YZApp.shared.getLocalizedText("last_hour")
            }
        } else if (components.minute! >= 2) {
            return components.minute!.description + " " + YZApp.shared.getLocalizedText("minutes_ago")
        } else if (components.minute! >= 1){
            if (numericDates){
                return components.minute!.description + " " + YZApp.shared.getLocalizedText("minute_ago")
            } else {
                return YZApp.shared.getLocalizedText("last_minute")
            }
        } else if (components.second! >= 3) {
            return components.second!.description + " " + YZApp.shared.getLocalizedText("seconds_ago")
        } else {
            return YZApp.shared.getLocalizedText("just_now")
        }
    }
}

//MARK: -
extension Date {
    
    var millisecondsSince1970:Int64 {
        return Int64((self.timeIntervalSince1970 * 1000.0).rounded())
    }
    
    init(milliseconds:Int) {
        self = Date(timeIntervalSince1970: TimeInterval(milliseconds / 1000))
    }
}
