//
//  GitTrendingModelTests.swift
//  GitTrendsTests
//
//  Created by Ravikumar, Gowtham.
//

import XCTest
@testable import GitTrends

class GitTrendingModelTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    func testModel() {
        if let repos = Utils.readJSONFromFile(fileName: "repositories", type: Repos.self) {
            for aRepo in repos.items {
                XCTAssertNotNil(aRepo.name)

                XCTAssertNotNil(aRepo.forks_count)
                XCTAssertNotNil(aRepo.description)
                XCTAssertNotNil(aRepo.forks_count)
                XCTAssertNotNil(aRepo.html_url)

                XCTAssertNotNil(aRepo.owner.url)
                XCTAssertNotNil(aRepo.owner.login)
                XCTAssertNotNil(aRepo.owner.avatar_url)
            }
        }
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.

    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
