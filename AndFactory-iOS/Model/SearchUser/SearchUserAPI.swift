import APIKit

public class SearchUserAPI {
    struct Request: AppRequestType {

        typealias Response = SearchUserAPI.Response

        let userName: String

        init(userName: String) {
            self.userName = userName
        }

        var method: HTTPMethod {
            return APIRoutes.fetchUser.configurePath().method
        }

        var path: String {
            APIRoutes.fetchUser.configurePath().path
        }

        var parameters: Any? {
            return ["q": userName]
        }
    }
}
