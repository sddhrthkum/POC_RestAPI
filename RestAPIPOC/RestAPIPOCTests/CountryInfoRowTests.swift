//
//  CountryInfoRowTests.swift
//  RestAPIPOCTests
//
//  Created by Siddharth Kumar on 08/10/20.
//  Copyright © 2020 MyOrganisation. All rights reserved.
//

import XCTest
@testable import RestAPIPOC

class CountryInfoRowTests: XCTestCase {
    
    var countryInfoRow: CountryInfoRow!
    
    override func setUp() {
        super.setUp()
        let param = [
            "title":"Beavers",
            "description":"Beavers are second only to humans in their ability to manipulate and change their environment. They can measure up to 1.3 metres long. A group of beavers is called a colony",
            "imageHref":"http://upload.wikimedia.org/wikipedia/commons/thumb/6/6b/American_Beaver.jpg/220px-American_Beaver.jpg"
        ]
        countryInfoRow = CountryInfoRow(title: param["title"] , description: param["description"], imageUrl: param["imageHref"])
    }
    
    override func tearDown() {
        countryInfoRow = nil
        super.tearDown()
    }
    
    //MARK:- Used for Unit testing
    func testCountryInfoRowModel() throws {
        let encoder = JSONEncoder()
        let data = try encoder.encode(countryInfoRow)
        let decoder = JSONDecoder()
        let countryInfoRow = try decoder.decode(CountryInfoRow.self, from: data)
        XCTAssertEqual(countryInfoRow, self.countryInfoRow)
    }
    
    
}
