//
//  SlackCoreTests.swift
//  
//
//  Created by Jinwoo Kim on 3/19/24.
//

import XCTest
@_spi(ForToolsIntegrationOnly) import Testing
@testable import SlackCore

final class SlackCoreTests: XCTestCase {
    func testAll() async {
        var configuration: Testing.Configuration = .init()
        configuration.testFilter = Testing.Configuration.TestFilter(includingAnyOf: [.init(kind: .stringLiteral("testGetUserProfileDictionary"))])
        let runner: Testing.Runner = await .init(configuration: configuration)
        await runner.run()
        
//        await XCTestScaffold.runAllTests(hostedBy: self)
    }
}
