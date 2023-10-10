import Foundation
import CryptoKit

class URLConstructor {
   
    func getMasterUrl(name: String?, value: String?) -> String {
        var components = URLComponents()
        components.scheme = "https"
        print(components)
        components.host = "gateway.marvel.com"
        components.port = 443
        components.path = "/v1/public/comics"
        components.queryItems = [URLQueryItem(name: "format", value: "comic"),
                                 URLQueryItem(name: "hasDigitalIssue", value: "true"),
                                 URLQueryItem(name: "orderBy", value: "focDate"),
                                 URLQueryItem(name: name ?? "", value: value),
                                 URLQueryItem(name: "limit", value: "50"),
                                 URLQueryItem(name: "ts", value: "1"),
                                 URLQueryItem(name: "apikey", value: "16596237e1bf6fc297f8eab4120eea12"),
                                 URLQueryItem(name: "hash", value: "58608cdd5bdd4b223d76a977914c032e")]
        let url = components.url?.absoluteString ?? ""
        print(url)
        return url
    }

 func getImageUrl(path: String?, size: ImageSize, extention: String?) -> String? {

        if let path = path, let extention = extention {
            let url = path.makeHttps + size.set + extention
            print(url)
            return url
        }
       return nil
    }
}
