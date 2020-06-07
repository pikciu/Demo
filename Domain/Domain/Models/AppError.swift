import Foundation

public enum AppError: Error {
    case mappingError(Error)
    case networkError(Error)
    case httpError(status: Int, data: Data)
    case descriptive(String)
}
