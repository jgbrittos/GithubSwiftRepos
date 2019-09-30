import UIKit

protocol RequestManagerProtocol {
    func fetch<T: Decodable>(from url: String, success: @escaping (T) -> Void, failure: @escaping (Error?) -> Void)
}

struct RequestManager: RequestManagerProtocol {
    func fetch<T: Decodable>(from url: String, success: @escaping (T) -> Void, failure: @escaping (Error?) -> Void) {

        guard let url = URL(string: url) else { return }
        
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
                let result = try JSONDecoder().decode(T.self, from: data)
                success(result)
            } catch let error {
                failure(error)
            }

        }.resume()
    }
}
