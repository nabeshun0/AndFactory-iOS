import Foundation

extension SearchUserAPI {
    public struct Response: Decodable {
        var items: [User]
    }

    public struct User: Decodable {
        public var login: String
        public var type: String
        public var avatarUrl: String
        public var htmlUrl: String

        enum CodingKeys: String, CodingKey {
            case login
            case type
            case avatarUrl
            case htmlUrl
        }
    }
}
