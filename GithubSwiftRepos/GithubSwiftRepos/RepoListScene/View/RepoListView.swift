import UIKit
import UIScrollView_InfiniteScroll

protocol RepoListViewDelegate: AnyObject {
    func set(viewModel: RepoListViewModelDelegate)
    func show(repos: [Repo])
    func refreshList(with repos: [Repo])
}

final class RepoListView: UIView {
    private weak var viewModel: RepoListViewModelDelegate?
    private var dataSource = RepoTableViewDataSource()

    private lazy var refreshControl: UIRefreshControl = {
        let control = UIRefreshControl(frame: .zero)
        control.addTarget(self, action: #selector(pullToRefresh), for: .valueChanged)
        control.attributedTitle = NSAttributedString(string: "Refreshing repo list")
        return control
    }()
    private lazy var reposTableView: UITableView = {
        let table = UITableView(frame: .zero, style: .plain)
        table.register(RepoItemTableViewCell.self, forCellReuseIdentifier: "RepoItemTableViewCell")
        table.delegate = dataSource
        table.dataSource = dataSource
        table.refreshControl = refreshControl
        table.tableFooterView = UIView(frame: .zero)
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        build()
        setupInfiniteScroll()
    }
    
    required init?(coder aDecoder: NSCoder) { return nil }
}

extension RepoListView: RepoListViewDelegate {
    func set(viewModel: RepoListViewModelDelegate) {
        self.viewModel = viewModel
    }
    
    func show(repos: [Repo]) {
        self.dataSource.set(repos)
        self.reposTableView.reloadData()
        self.reposTableView.finishInfiniteScroll()
    }
    
    func refreshList(with repos: [Repo]) {
        dataSource.clear()
        reposTableView.refreshControl?.endRefreshing()
        show(repos: repos)
    }
}

private extension RepoListView {
    func setupInfiniteScroll() {
        reposTableView.addInfiniteScroll { [weak self] _ in
            guard let self = self else { return }
            self.viewModel?.fetchNewRepos()
        }

        reposTableView.setShouldShowInfiniteScrollHandler { _ -> Bool in
            return true
        }
    }
    
    @objc
    func pullToRefresh() {
        viewModel?.fetchList()
    }
}

extension RepoListView: ViewCode {
    func buildViewHierarchy() {
        addSubview(reposTableView)
    }
    
    func buildConstraints() {
        NSLayoutConstraint.activate([
            reposTableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            reposTableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            reposTableView.topAnchor.constraint(equalTo: topAnchor),
            reposTableView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
