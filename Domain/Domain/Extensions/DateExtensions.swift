import Foundation

public extension Date {
    mutating func add(value: Int, component: Calendar.Component, timeZone: TimeZone = .current) {
        self = Calendar.with(timeZone: timeZone).date(byAdding: component, value: value, to: self) ?? self
    }
    
    func byAdding(value: Int, component: Calendar.Component, timeZone: TimeZone = .current) -> Date {
        var date = self
        date.add(value: value, component: component, timeZone: timeZone)
        return date
    }
    
    func date(withComponents components: Set<Calendar.Component>, timeZone: TimeZone = .current) -> Date {
        let calendar = Calendar.with(timeZone: timeZone)
        let dateComponents = calendar.dateComponents(components, from: self)
        return calendar.date(from: dateComponents) ?? self
    }
    
    func day(inTimeZone timeZone: TimeZone = .current) -> Date {
        date(withComponents: [.year, .month, .day], timeZone: timeZone)
    }
}

public extension TimeZone {
    
    static var utc: TimeZone {
        TimeZone(abbreviation: "UTC")!
    }
}

public extension Calendar {
    
    static func with(timeZone: TimeZone) -> Calendar {
        var calendar = Calendar.current
        calendar.timeZone = timeZone
        return calendar
    }
}
