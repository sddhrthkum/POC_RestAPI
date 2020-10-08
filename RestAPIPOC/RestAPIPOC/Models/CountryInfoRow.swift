//
//  CountryInfoRow.swift
//  RestAPIPOC
//
//  Created by Siddharth Kumar on 07/10/20.
//  Copyright © 2020 MyOrganisation. All rights reserved.
//

import Foundation

struct CountryInfoRow : Codable, Equatable {
    
    let title : String?
    let description : String?
    let imageUrl : String?
    
    enum CodingKeys: String, CodingKey {
        case title = "title"
        case description = "description"
        case imageUrl = "imageHref"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        description = try values.decodeIfPresent(String.self, forKey: .description)
        imageUrl = try values.decodeIfPresent(String.self, forKey: .imageUrl)
    }
    
    //MARK:- Used for Unit testing 
    init(title: String?, description: String?, imageUrl: String?) {
        self.title = title
        self.description = description
        self.imageUrl = imageUrl
    }
    
    static func == (lhs: CountryInfoRow, rhs: CountryInfoRow) -> Bool {
        return lhs.title == rhs.title && lhs.description == rhs.description && lhs.imageUrl == rhs.imageUrl
    }
    
}
