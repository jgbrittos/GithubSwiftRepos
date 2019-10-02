import Foundation

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

        repository?.fetchRepoList(page: 1, success: { [weak view = self.view] list in
            view?.show(repos: list.items)
        }, failure: { _ in })
    }
    
    func fetchNewRepos() {
        repository?.fetchRepoList(page: page, success: { [weak view = self.view] list in
            view?.show(repos: list.items)
            self.page += 1
        }, failure: { _ in })
    }
}
