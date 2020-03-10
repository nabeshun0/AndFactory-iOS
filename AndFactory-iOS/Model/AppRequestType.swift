import APIKit

final class DecodableDataParser: DataParser {
    public var contentType: String? {
        return "application/json"
    }

    public func parse(data: Data) throws -> Any {
        return data
    }
}

public protocol AppRequestType: Request {}

extension AppRequestType {

    public var baseURL: URL {
        return URL(string: "https://api.github.com")!
    }

    public var headerFields: [String: String] {
        return  ["Content-Type": "application/json",
                 "charset": "utf-8"]
    }
}

extension AppRequestType where Response: Decodable {
    public var dataParser: DataParser {
        return DecodableDataParser()
    }

    public func response(from object: Any, urlResponse: HTTPURLResponse) throws -> Response {
        guard let data = object as? Data else {
            throw ResponseError.unexpectedObject(object)
        }
        let jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        return try jsonDecoder.decode(Response.self, from: data)
    }
}
