import UIKit

protocol FetchListRepositoryProtocol {
    func fetchRepoList(page: Int, success: @escaping (RepoList) -> Void, failure: @escaping (Error?) -> Void)
}

struct FetchListRepository: FetchListRepositoryProtocol {
    private let endpoint = "https://api.github.com/search/repositories?q=language:swift&sort=stars"
    
    func fetchRepoList(page: Int = 1, success: @escaping (RepoList) -> Void, failure: @escaping (Error?) -> Void) {
        guard let url = URL(string: endpoint + "&page=\(page)") else { return }

        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse,
                httpURLResponse.statusCode == 200,
                let data = data,
                error == nil
                else {
                    failure(error)
                    return
            }
            
            do {
                let result = try JSONDecoder().decode(RepoList.self, from: data)
                
                success(result)
            } catch let error {
                failure(error)
            }

        }.resume()
    }
}
