protocol RepoListViewModelDelegate: AnyObject {
    func set(repository: FetchListRepositoryProtocol)
    func set(view: RepoListViewDelegate)
    func fetchList()
    func fetchNewRepos()
}

final class RepoListViewModel {
    private var repository: FetchListRepositoryProtocol?
    private weak var view: RepoListViewDelegate?
    private var page = 2
}

extension RepoListViewModel: RepoListViewModelDelegate {
    func set(repository: FetchListRepositoryProtocol) {
        self.repository = repository
    }
    
    func set(view: RepoListViewDelegate) {
        self.view = view
        self.view?.set(viewModel: self)
    }
    
    func fetchList() {
        self.page = 2
        repository?.fetchRepoList(page: 1, success: { [weak self] list in
            guard let self = self else { return }
            
            self.view?.show(repos: list.items)
        }, failure: { error in
            print(error!)
        })
    }
    
    func fetchNewRepos() {
        repository?.fetchRepoList(page: page, success: { list in
            self.view?.show(repos: list.items)
            self.page += 1
        }, failure: { error in
            print(error!)
        })
    }
}
