//
//  DKBlog.swift
//  Rx Playground
//
//  Created by ChangMin on 2022/06/06.
//

import Foundation

struct DKBlog: Decodable {
    let documents: [DKDocument]
    let meta: DKMeta
}

struct DKDocument: Decodable {
    let title: String?
    let name: String?
    let thumbnail: String?
    let datetime: Date?
    
    enum CodingKeys: String, CodingKey {
        case title, thumbnail, datetime
        case name = "blogname"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        self.title = try? values.decode(String?.self, forKey: .title)
        self.name = try? values.decode(String?.self, forKey: .name)
        self.thumbnail = try? values.decode(String?.self, forKey: .thumbnail)
        self.datetime = Date.parse(values, key: .datetime)
    }
}

extension Date {
    static func parse<K: CodingKey>(_ values: KeyedDecodingContainer<K>, key: K) -> Date? {
        guard let dateString = try? values.decode(String.self, forKey: key),
              let date = from(dateString: dateString) else {
            return nil
        }
        return date
    }
    
    static func from(dateString: String) -> Date? {
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSXXXXX"
        dateformatter.locale = Locale(identifier: "ko_kr")
        
        if let date = dateformatter.date(from: dateString) {
            return date
        }
        
        return nil
    }
}

struct DKMeta: Decodable {
    let isEnd: Bool?
    let pageCnt: Int?
    let totalCnt: Int?

    enum CodingKeys: String, CodingKey {
        case isEnd = "is_end"
        case pageCnt = "pageable_count"
        case totalCnt = "total_count"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)

        self.isEnd = try? values.decode(Bool?.self, forKey: .isEnd)
        self.pageCnt = try? values.decode(Int?.self, forKey: .pageCnt)
        self.totalCnt = try? values.decode(Int?.self, forKey: .totalCnt)

    }
}
