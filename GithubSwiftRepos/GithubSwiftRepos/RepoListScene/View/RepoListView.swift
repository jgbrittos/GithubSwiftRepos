import UIKit
import UIScrollView_InfiniteScroll

protocol RepoListViewDelegate: AnyObject {
    func set(viewModel: RepoListViewModelDelegate)
    func show(repos: [Repo])
}

final class RepoListView: UIView {
    private weak var viewModel: RepoListViewModelDelegate?
    private var dataSource = RepoTableViewDataSource()
    
    private var pullToRefreshCalled: Bool = false
    private var infiniteRefreshCalled: Bool = false
    
    private var refreshControl: UIRefreshControl {
        let control = UIRefreshControl(frame: .zero)
        control.addTarget(self, action: #selector(pullToRefresh), for: .valueChanged)
        control.attributedTitle = NSAttributedString(string: "Fetching more repos")
        return control
    }
    
    private lazy var reposTableView: UITableView = {
        let table = UITableView(frame: .zero, style: .plain)
        table.rowHeight = UITableView.automaticDimension
        table.estimatedRowHeight = 300
        table.register(RepoItemTableViewCell.self, forCellReuseIdentifier: "RepoItemTableViewCell")
        table.delegate = dataSource
        table.dataSource = dataSource
        table.refreshControl = refreshControl
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        build()
        setupInfiniteScroll()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init?(coder:) has not been implemented!")
    }
}

private extension RepoListView {
    func setupInfiniteScroll() {
        reposTableView.addInfiniteScroll { [weak self] _ in
            guard let self = self else { return }
            self.infiniteRefreshCalled = true
            self.viewModel?.fetchNewRepos()
        }

        reposTableView.setShouldShowInfiniteScrollHandler { _ -> Bool in
            return true
        }
    }
    
    @objc
    func pullToRefresh() {
        viewModel?.fetchList()
        pullToRefreshCalled = true
    }
}

extension RepoListView: RepoListViewDelegate {
    func set(viewModel: RepoListViewModelDelegate) {
        self.viewModel = viewModel
    }
    
    func show(repos: [Repo]) {
        if pullToRefreshCalled {
            pullToRefreshCalled = false
            infiniteRefreshCalled = false
            dataSource.clear()
            reposTableView.refreshControl?.endRefreshing()
        }

        DispatchQueue.main.async {
            self.dataSource.set(repos)
            self.reposTableView.reloadData()
            self.reposTableView.finishInfiniteScroll()
            self.reposTableView.isHidden = false
        }
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
    
    func finalSetup() {
        backgroundColor = .white
    }
}
