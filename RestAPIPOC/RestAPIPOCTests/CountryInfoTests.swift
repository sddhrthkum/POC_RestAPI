//
//  CountryInfoTests.swift
//  RestAPIPOCTests
//
//  Created by Siddharth Kumar on 08/10/20.
//  Copyright © 2020 MyOrganisation. All rights reserved.
//

import XCTest
@testable import RestAPIPOC

class CountryInfoTests: XCTestCase {

    var countryInfo: CountryInfo!
    
    override func setUp(){
        super.setUp()
        countryInfo = CountryInfo(title: "About Canada", rows: nil)
    }

    override func tearDown() {
        countryInfo = nil
        super.tearDown()
    }
    
    func testModelCountryInfo() throws {
        let encoder = JSONEncoder()
        let data = try encoder.encode(countryInfo)
        let decoder = JSONDecoder()
        let countryInfo = try decoder.decode(CountryInfo.self, from: data)
        XCTAssertEqual(countryInfo, self.countryInfo)
    }
    
    func testFilteredRows() {
        var rows = [CountryInfoRow]()
        let countryInforRow = CountryInfoRow(title: "Title", description: "Description", imageUrl: "https://www.google.com.png")
        rows.append(countryInforRow)
        let anotherRow = CountryInfoRow(title: nil, description: nil, imageUrl: nil)
        rows.append(anotherRow)
        countryInfo = CountryInfo(title: "About Canada", rows: rows)
        XCTAssertEqual(countryInfo.filteredRows(), rows.filter {$0.imageUrl != nil || $0.description != nil || $0.title != nil} )
    }

}
