import UIKit

class UserSearchViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    init() {
        super.init(nibName: UserSearchViewController.className, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Search User"
        configure(with: tableView)
    }

    func configure(with tableView: UITableView) {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: UserSearchCell.className, bundle: nil), forCellReuseIdentifier: UserSearchCell.className)
    }
}

extension UserSearchViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UserSearchCell.className, for: indexPath) as? UserSearchCell else { return UserSearchCell() }
        cell.configure()
        return cell
    }
}

extension UserSearchViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}
