import Foundation

@propertyWrapper
struct Key<T: Codable> {
    let key: String
    
    init(_ key: String) {
        self.key = key
    }
    
    var wrappedValue: T? {
        get {
            guard let data = UserDefaults.standard.value(forKey: key) as? Data else {
                return nil
            }
            do {
                let decoded = try JSONDecoder().decode(DecodableWrapper<T>.self, from: data)
                return decoded.value
            } catch {
                log.warning(error)
                return nil
            }
        }
        set {
            if let value = newValue {
                let wrapped = EncodableWrapper(value: value)
                do {
                    let data = try JSONEncoder().encode(wrapped)
                    UserDefaults.standard.set(data, forKey: key)
                } catch {
                    log.warning(error)
                }
            } else {
                UserDefaults.standard.removeObject(forKey: key)
            }
        }
    }
}

public struct Settings {
    
}
