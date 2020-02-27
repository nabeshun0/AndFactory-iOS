import APIKit

public enum APIRoutes {
    case fetchUser

    public func configurePath() -> (method: HTTPMethod, path: String) {
        switch self {
        case .fetchUser:
            return (.get, "search/users")
        }
    }
}
