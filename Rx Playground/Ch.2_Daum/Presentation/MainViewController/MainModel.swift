//
//  MainModel.swift
//  Rx Playground
//
//  Created by ChangMin on 2022/06/12.
//

import RxSwift

struct MainModel {
    let network = SearchBlogNetwork()
    
    func searchBlog(_ query: String) -> Single<Result<DKBlog, SearchNetworkError>> {
        return network.searchBlog(query: query)
    }
    
    func getBlogValue(_ result: Result<DKBlog, SearchNetworkError>) -> DKBlog? {
        guard case .success(let value) = result else { return nil }
        
        return value
    }
    
    func getBlogError(_ result: Result<DKBlog, SearchNetworkError>) -> String? {
        guard case .failure(let error) = result else { return nil }
        return error.localizedDescription
    }
    
    func getBlogListCellData(_ value: DKBlog) -> [BlogListCellData] {
        return value.documents
            .map { doc in
                let thumbnailURL = URL(string: doc.thumbnail ?? "")
                return BlogListCellData(thumnailURL: thumbnailURL, name: doc.name, title: doc.title, datetime: doc.datetime)
            }
    }
    
    func sort(by type: DaumMainViewController.AlertAction, of data: [BlogListCellData]) -> [BlogListCellData] {
        switch type {
        case .title:
            return data.sorted { $0.title ?? "" < $1.title ?? "" }
        case .datetime:
            return data.sorted { $0.datetime ?? Date() > $1.datetime ?? Date() }
        default:
            return data
        }
    }
}
