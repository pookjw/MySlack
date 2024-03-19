//
//  SlackCoreTests.swift
//  
//
//  Created by Jinwoo Kim on 3/19/24.
//

import XCTest
import Testing
@testable import SlackCore

final class SlackCoreTests: XCTestCase {
    func testAll() async {
        await XCTestScaffold.runAllTests(hostedBy: self)
    }
}
