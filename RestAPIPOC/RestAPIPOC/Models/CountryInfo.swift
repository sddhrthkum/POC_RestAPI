//
//  CountryInfo.swift
//  RestAPIPOC
//
//  Created by Siddharth Kumar on 07/10/20.
//  Copyright © 2020 MyOrganisation. All rights reserved.
//

import Foundation

struct CountryInfo : Codable {
    
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

}
