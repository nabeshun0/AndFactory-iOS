import APIKit
import Foundation

protocol SearchUserModelDelegate: AnyObject {
    func searchModel(_ searchModel: SearchUserModel, didRecieve errorMessage: ErrorMessage)
    func searchModel(_ searchModel: SearchUserModel, didChange isFetchingUsers: Bool)
    func searchModel(_ searchModel: SearchUserModel, didChange users: [SearchUserAPI.User])
}

struct ErrorMessage {
    let title: String
    let message: String
}

final class SearchUserModel {

    weak var delegate: SearchUserModelDelegate?

    private(set) var query: String = ""

    private(set) var users: [SearchUserAPI.User] = [] {
        didSet {
            delegate?.searchModel(self, didChange: users)
        }
    }

    private(set) var isFetchingUsers = false {
        didSet {
            delegate?.searchModel(self, didChange: isFetchingUsers)
        }
    }

    private let debounce: (_ action: @escaping () -> Void) -> Void = {
        var lastFireTime: DispatchTime = .now()
        let delay: DispatchTimeInterval = .milliseconds(500)
        return { [delay] action in
            let deadline: DispatchTime = .now() + delay
            lastFireTime = .now()
            DispatchQueue.global().asyncAfter(deadline: deadline) { [delay] in
                let now: DispatchTime = .now()
                let when: DispatchTime = lastFireTime + delay
                if now < when { return }
                lastFireTime = .now()
                DispatchQueue.main.async {
                    action()
                }
            }
        }
    }()

    func fetchUsers() {
        if query.isEmpty { return }
        isFetchingUsers = true

        Session.send(SearchUserAPI.Request(userName: query), callbackQueue: nil) { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                response.items.forEach { [weak self] in
                    self?.users.append($0)
                }
            case .failure(let error):
                print(error.localizedDescription)
                let errorMessage = ErrorMessage(title: "Error", message: "APIレート制限により通信できません。1分後に再度利用できます。")
                self.delegate?.searchModel(self, didRecieve: errorMessage)
            }
            self.isFetchingUsers = false
        }
    }

    func fetchUsers(withQuery query: String) {
        debounce { [weak self] in
            guard let self = self else { return }
            let oldValue = self.query
            self.query = query

            if query != oldValue {
                self.users.removeAll()
            }
            self.fetchUsers()
        }
    }
}
