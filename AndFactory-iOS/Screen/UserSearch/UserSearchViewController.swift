import UIKit

final class UserSearchViewController: UIViewController {

    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var searchBar: UISearchBar!

    private let searchUserModel: SearchUserModel

    init(searchUserModel: SearchUserModel) {
        self.searchUserModel = searchUserModel
        super.init(nibName: UserSearchViewController.className, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Search User"

        searchBar.delegate = self
        searchBar.placeholder = "Input user name"

        configure(with: tableView)
        searchUserModel.delegate = self
    }

    override func viewWillDisappear(_ animated: Bool) {
        if searchBar.isFirstResponder {
            searchBar.resignFirstResponder()
        }
    }

    private func configure(with tableView: UITableView) {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: UserSearchCell.className, bundle: nil), forCellReuseIdentifier: UserSearchCell.className)
    }

    private func showUserDetailVC(with user: SearchUserAPI.User) {
        let userDetailModel = UserDetailModel(user: user)
        let userDetailVC = UserDetailViewController(userDetailModel: userDetailModel)
        navigationController?.pushViewController(userDetailVC, animated: true)
    }
}

extension UserSearchViewController: SearchUserModelDelegate {

    func searchModel(_ searchModel: SearchUserModel, didRecieve errorMessage: ErrorMessage) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: errorMessage.title, message: errorMessage.message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(alert, animated: false, completion: nil)
        }
    }

    func searchModel(_ searchModel: SearchUserModel, didChange isFetchingUsers: Bool) {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }

    func searchModel(_ searchModel: SearchUserModel, didChange users: [SearchUserAPI.User]) {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

extension UserSearchViewController: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        searchBar.showsCancelButton = false
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        searchBar.showsCancelButton = false
    }

    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchUserModel.fetchUsers(withQuery: searchText)
    }
}

extension UserSearchViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchUserModel.users.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UserSearchCell.className, for: indexPath) as? UserSearchCell else { return UserSearchCell() }
        cell.configure(with: searchUserModel.users[indexPath.row])
        return cell
    }
}

extension UserSearchViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        let user = searchUserModel.users[indexPath.row]
        showUserDetailVC(with: user)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}
