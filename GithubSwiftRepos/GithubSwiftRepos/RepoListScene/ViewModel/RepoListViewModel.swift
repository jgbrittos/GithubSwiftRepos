protocol RepoListViewModelDelegate: AnyObject {
    func set(repository: FetchListRepositoryProtocol)
    func set(view: RepoListViewDelegate)
    func fetchList()
}

final class RepoListViewModel {
    private var repository: FetchListRepositoryProtocol?
    private weak var view: RepoListViewDelegate?
}

extension RepoListViewModel: RepoListViewModelDelegate {
    func set(repository: FetchListRepositoryProtocol) {
        self.repository = repository
    }
    
    func set(view: RepoListViewDelegate) {
        self.view = view
    }
    
    func fetchList() {
        repository?.fetchRepoList(success: { list in
            self.view?.show(repos: list.items)
        }, failure: { error in
            print(error)
        })
    }
}
