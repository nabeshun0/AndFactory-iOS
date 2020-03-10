import UIKit
import WebKit

final class UserDetailViewController: UIViewController {

    @IBOutlet private weak var webView: WKWebView!

    private let userDetailModel: UserDetailModel

    init(userDetailModel: UserDetailModel) {
        self.userDetailModel = userDetailModel
        super.init(nibName: UserDetailViewController.className, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = userDetailModel.user.login
        openUrl(urlString: userDetailModel.user.htmlUrl)
    }

    private func openUrl(urlString: String) {
        guard let url = URL(string: urlString) else { return }
        let urlRequest = URLRequest(url: url)
        webView.load(urlRequest)
    }
}
