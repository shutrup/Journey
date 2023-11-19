import Foundation

extension Date {
    var isoFormatt: String {
        return toString(format: "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ")
    }
    
    var isFormat: String {
        return toString(format: "yyyy.MM.dd")
    }
    
    var isRuFormat: String {
        return toString(format: "dd.MM.yy")
    }
    
    func isSameDay(date: Date?) -> Bool {
        if let date = date {
            return Calendar.current.isDate(self, inSameDayAs: date)
        } else {
            return false
        }
    }
    
    func toString(format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
    
    func toString(date style: DateFormatter.Style) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = style
        formatter.timeStyle = style
        return formatter.string(from: self)
    }
    
    func toString(time style: DateFormatter.Style) -> String {
        let formatter = DateFormatter()
        formatter.timeStyle = style
        return formatter.string(from: self)
    }
    
}

extension Date {
    init?(timeIntervalSince1970InMiliseconds: Int?) {
        if let timeIntervalSince1970 = timeIntervalSince1970InMiliseconds {
            self = Date(timeIntervalSince1970: Double(timeIntervalSince1970) / 1000)
        } else {
            return nil
        }
    }
    
    init?(iso date: String?) {
        if let date = Date(date: date, format: "yyyy-MM-dd HH:mm:ss") {
            self = date
        } else if let date = Date(date: date, format: "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ") {
            self = date
        } else if let date = Date(date: date, format: "yyyy-MM-dd'T'HH:mm:ss.SSXXXXX") {
            self = date
        } else if let date = Date(date: date, format: "yyyy-MM-dd'T'HH:mm:ss.SXXXXXX") {
            self = date
        } else {
            return nil
        }
    }
    
    init?(date: String?, format: String) {
        guard let date = date else {
            return nil
        }
        
        let formatter = DateFormatter()
        formatter.dateFormat = format
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        
        if let date = formatter.date(from: date) {
            self = date
        } else {
            return nil
        }
    }
    
    static var yesterday: Date { return Date().dayBefore }
    static var tomorrow:  Date { return Date().dayAfter }
    static var week: Date { return Date().week }
    
    var dayBefore: Date {
        return Calendar.current.date(byAdding: .day, value: -1, to: noon)!
    }
    var dayAfter: Date {
        return Calendar.current.date(byAdding: .day, value: 1, to: Date.now)!
    }
    var week: Date {
        return Calendar.current.date(byAdding: .day, value: 7, to: noon)!
    }
    var noon: Date {
        return Calendar.current.date(bySettingHour: 12, minute: 0, second: 0, of: self)!
    }
}

extension String {
    public enum DateFormatType {
        case localDateTimeSec
        case localDate
        case localTimeWithNoon
        case localPhotoSave
        case messageRTetriveFormat
        case emailTimePreview
        
        var stringFormat:String {
            switch self {
            case .localDateTimeSec: return "yyyy-MM-dd HH:mm:ss"
            case .localTimeWithNoon: return "hh:mm a"
            case .localDate: return "yyyy-MM-dd"
            case .localPhotoSave: return "yyyyMMddHHmmss"
            case .messageRTetriveFormat: return "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
            case .emailTimePreview: return "dd MMM yyyy, h:mm a"
            }
        }
    }
    
    func toDate(_ format: DateFormatType = .localDateTimeSec) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format.stringFormat
        let date = dateFormatter.date(from: self)
        return date
    }
}
