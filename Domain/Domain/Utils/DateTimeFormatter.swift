import Foundation

public final class DateTimeFormatter {
    
    private var formatters = [String: DateFormatter]()
    
    private let timeZone: TimeZone
    private let locale: Locale
    
    public static let current = DateTimeFormatter(timeZone: .current, locale: .current)
    
    public init(timeZone: TimeZone, locale: Locale) {
        self.timeZone = timeZone
        self.locale = locale
    }
    
    private func formatter(for dateFormat: String) -> DateFormatter {
        if let formatter = formatters[dateFormat] {
            return formatter
        }
        
        let formatter = DateFormatter()
        formatter.timeZone = timeZone
        formatter.dateFormat = dateFormat
        formatter.locale = locale
        formatters[dateFormat] = formatter
        return formatter
    }
    
    public func string(from date: Date, dateFormat: String) -> String {
        formatter(for: dateFormat).string(from: date)
    }
    
    public func date(from string: String, dateFormat: String) -> Date? {
        formatter(for: dateFormat).date(from: string)
    }
}
