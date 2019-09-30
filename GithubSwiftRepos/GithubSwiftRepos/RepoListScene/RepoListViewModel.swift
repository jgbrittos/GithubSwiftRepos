protocol RepoListViewModelDelegate: AnyObject {
    func set(repository: FetchListRepositoryProtocol)
    
    func fetchList()
}

final class RepoListViewModel {
    // Não precisa ser weak, pois referência cíclica só funciona com classes e não com structs
    private var repository: FetchListRepositoryProtocol?
    
}

extension RepoListViewModel: RepoListViewModelDelegate {
    func set(repository: FetchListRepositoryProtocol) {
        self.repository = repository
    }
    
    func fetchList() {
        repository?.fetchRepoList(success: { [weak self] list in
            
        }, failure: { [weak self] error in
                
        })
    }
}
