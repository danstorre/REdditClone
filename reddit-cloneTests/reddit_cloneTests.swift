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
        XCTAssertEqual(listpost.posts[0].entryDate.timeIntervalSince1970, 1411946514)
        XCTAssertEqual(listpost.posts[0].author, "washedupwornout")
        XCTAssertEqual(listpost.posts[0].comments, 958)
        XCTAssertEqual(listpost.posts[0].postImageURL, URL(string: "http://b.thumbs.redditmedia.com/9N1f7UGKM5fPZydrsgbb4_SUyyLW7A27um1VOygY3LM.jpg"))
        XCTAssertEqual(listpost.posts[0].identifier, "t5_2qh33")
    }
    
}
