protocol FetchListRepositoryProtocol {
    var endpoint: String { get }
    func fetchRepoList(success: @escaping (RepoList) -> Void, failure: @escaping (Error?) -> Void)
}

struct FetchListRepository: FetchListRepositoryProtocol {
    var endpoint: String {
        return "https://api.github.com/search/repositories?q=language:swift&sort=stars"
    }
    
    private let requestManager: RequestManagerProtocol
    
    init(with manager: RequestManagerProtocol) {
        self.requestManager = manager
    }
    
    func fetchRepoList(success: @escaping (RepoList) -> Void, failure: @escaping (Error?) -> Void) {
        requestManager.fetch(from: endpoint, success: { list in
            success(list)
        }) { error in
            failure(error)
        }
    }
}
