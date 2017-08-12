//
//  ToSMRTests.swift
//  ToSMRTests
//
//  Created by Alexey Averkin on 08/08/2017.
//  Copyright © 2017 Alexey Averkin. All rights reserved.
//

import XCTest
@testable import ToSMR

class GetFirstArrivalToStopTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testRequestFormedCorrectly() {
        
        guard let client = ClientStub() else {
            XCTFail()
            return
        }
    
        let parameters: [Service.Parameter] = [
            Service.Parameter(key: "KS_ID", value: 9, isSignatureComponent: true),
            Service.Parameter(key: "COUNT", value: 10, isSignatureComponent: true)
        ]
        
        guard let request = URLRequest.toSamaraRequest(method: "getFirstArrivalToStop", parameters: parameters, clientId: client.clientId, secret: client.secret) else {
                XCTFail()
                return
        }
        
        guard let url = request.url else {
            XCTFail()
            return
        }
        
        XCTAssertEqual(url.scheme, "http")
        XCTAssertEqual(url.host, "tosamara.ru")
        XCTAssertEqual(url.path, "/api/json")
        
        guard let queryItems = URLComponents(string: url.absoluteString)?.queryItems else {
            XCTFail()
            return
        }
        
        XCTAssertEqual(queryItems.count, 6)
        XCTAssertEqual(queryItems.filter({ $0.name == "os"}).first?.value, "ios")
        XCTAssertEqual(queryItems.filter({ $0.name == "KS_ID"}).first?.value, "9")
        XCTAssertEqual(queryItems.filter({ $0.name == "COUNT"}).first?.value, "10")
        XCTAssertEqual(queryItems.filter({ $0.name == "method"}).first?.value, "getFirstArrivalToStop")
        XCTAssertEqual(queryItems.filter({ $0.name == "clientid"}).first?.value, client.clientId)
        XCTAssertEqual(queryItems.filter({ $0.name == "authkey"}).first?.value, "d2d7459e66bbf2af780c9f33d13b61bf354a69d2")
    }
}
