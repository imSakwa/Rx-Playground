//
//  SearchBlogNetwork.swift
//  Rx Playground
//
//  Created by ChangMin on 2022/06/06.
//

import RxSwift
import Foundation

enum SearchNetworkError: Error {
    case invalidJSON
    case invalidURL
    case networkError
}

class SearchBlogNetwork {
    private let session: URLSession
    let api = SearchBlogAPI()
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func searchBlog(query: String, page: Int = 1) -> Single<Result<DKBlog, SearchNetworkError>> {
        guard let url = api.searchBlog(query: query, page: page).url else { return .just(.failure(.invalidURL))
        }
        
        let request = NSMutableURLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("KakaoAK cfa067fccf544de286a6b21b5676ab31", forHTTPHeaderField: "Authorization")
        
        return session.rx.data(request: request as URLRequest)
            .map { data in
                do {
                    let blogData = try JSONDecoder().decode(DKBlog.self, from: data)
                    return .success(blogData)
                } catch {
                    return .failure(.invalidJSON)
                }
            }
            .catch { _ in
                    .just(.failure(.networkError))
            }
            .asSingle()
    }
}
