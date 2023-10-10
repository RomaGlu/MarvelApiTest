import Foundation
import Alamofire

class NetworkManager {
    static let shared = NetworkManager()
    let urlConstructor = URLConstructor()
    
    func fetchData(from url: String, handler: @escaping (Result<[Comics], AFError>) -> Void) {
        let url = urlConstructor.getMasterUrl(name: nil, value: nil)
        AF.request(url).responseDecodable(of: DataMarvel.self) { data in
            guard let dataValue = data.value else {
                if let error = data.error {
                    handler(.failure(error))
                }
                return
            }
            let comics = dataValue.data.results
            handler(.success(comics))
            print(comics)
        }
    }
    
    func getImages(from urlString: String, onComplete: @escaping (Result<Data?, Error>) -> Void) {
        guard let url = URL(string: urlString) else { return }
        let urlRequest = URLRequest(url: url, cachePolicy: .returnCacheDataElseLoad, timeoutInterval: 30)
        let task = URLSession.shared.dataTask(with: urlRequest) { data, _, error in
            if let error {
                onComplete(.failure(error))
            }
            onComplete(.success(data))
        }
        task.resume()
    }
}
