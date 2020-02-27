import UIKit
import WebKit

class UserDetailViewController: UIViewController {

    @IBOutlet weak var webView: WKWebView!

    let userDetailModel: UserDetailModel

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

    func openUrl(urlString: String) {
        guard let url = URL(string: urlString) else { return }
        let urlRequest = URLRequest(url: url)
        webView.load(urlRequest)
    }
}
