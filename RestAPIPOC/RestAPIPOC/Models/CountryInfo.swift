//
//  CountryInfo.swift
//  RestAPIPOC
//
//  Created by Siddharth Kumar on 07/10/20.
//  Copyright © 2020 MyOrganisation. All rights reserved.
//

import Foundation

struct CountryInfo : Codable, Equatable {
    
    let title : String?
    private let rows : [CountryInfoRow]?
    
    enum CodingKeys: String, CodingKey {
        case title = "title"
        case rows = "rows"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        rows = try values.decodeIfPresent([CountryInfoRow].self, forKey: .rows)
    }
    
    func filteredRows() -> [CountryInfoRow]? {
        rows?.filter {
            $0.imageUrl != nil || $0.description != nil || $0.title != nil
        }
    }
    
    //MARK:- Used for Unit testing
    static func == (lhs: CountryInfo, rhs: CountryInfo) -> Bool {
        return lhs.title == rhs.title && lhs.rows == rhs.rows
    }
    
    init(title: String?, rows: [CountryInfoRow]?) {
        self.title = title
        self.rows = rows
    }
    
}
