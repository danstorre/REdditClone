//
//  reddit_cloneTests.swift
//  reddit-cloneTests
//
//  Created by Daniel Torres on 1/22/20.
//  Copyright © 2020 dansTeam. All rights reserved.
//

import XCTest
@testable import reddit_clone

class reddit_cloneTests: XCTestCase {
    
    var json: Data?
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        if let path = Bundle.main.path(forResource: "topsample", ofType: "json") {
            do {
                json = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
            } catch {
                fatalError("error reading topsample.json file")
            }
        }
    }
    
    override func tearDown() {
        json = nil
    }
    
    func testExample() {
        guard let json = json else { return XCTFail("no sameple posts json available ")}
        let jsondecoder = JSONDecoder()
        guard let listpost = try? jsondecoder.decode(ListPost.self, from: json) else {
            return
        }
        XCTAssertEqual(listpost.posts[0].title, "Man trying to return a dog's toy gets tricked into playing fetch")
    }
    
}
