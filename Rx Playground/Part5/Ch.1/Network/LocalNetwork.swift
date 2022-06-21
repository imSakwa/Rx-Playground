//
//  LocalNetwork.swift
//  Rx Playground
//
//  Created by ChangMin on 2022/06/21.
//

import RxSwift

class LocalNetwork {
    private let session: URLSession
    let api = LocalAPI()
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func getLocation(by mapPoint: MTMapPoint) -> Single<Result<LocationData, URLError>> {
        guard let url = api.getLocation(by: mapPoint).url else {
            return .just(.failure(URLError(.badURL)))
        }
        
        let request = NSMutableURLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("KakaoAK cfa067fccf544de286a6b21b5676ab31", forHTTPHeaderField: "Authorization")
        
        return session.rx.data(request: request as URLRequest)
            .map { data in
                do {
                    let locationData = try JSONDecoder().decode(LocationData.self, from: data)
                    return .success(locationData)
                    
                } catch {
                    return .failure(URLError(.cannotParseResponse))
                }
            }
            .catch { _ in .just(Result.failure(URLError(.cannotLoadFromNetwork)))}
            .asSingle()
    }
}
