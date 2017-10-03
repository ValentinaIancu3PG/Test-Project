//
//  Helpers.swift
//  IOS Project Starter
//
//  Created by Oana Popescu on 05/09/2017.
//  Copyright © 2017 Valentina Iancu. All rights reserved.
//

import XCTest
import Foundation

class Helpers: XCTest {
    public func waintUntilIsDisplayed(element: XCUIElement, timeout: TimeInterval) {
        let expect = XCTestExpectation(description: (element.label))
        XCTWaiter.wait(for: [expect], timeout: timeout)
        expect.fulfill()
    }

    public func goToBackground() {
        XCUIDevice.shared().press(XCUIDeviceButton.home)
    }

    func restartApp() {
        XCUIApplication().launch()
    }
    // MARK: Wait untill element disappear from screen
    public func waitUntilIsHidden(element: XCUIElement, timeout: TimeInterval) {
        if element.exists {
            let expect = XCTestExpectation(description: (element.label))
            expect.isInverted = true
            XCTWaiter.wait(for: [expect], timeout: timeout)
            expect.fulfill()
        }
    }

    // MARK: Make a text to be all lower case
    func makeItLowerCase(text: String) -> String {
        return text.lowercased()
    }

    // MARK: Verifies if padding to all devicesmargins are correct
    func checkPositionOfElement(element: XCUIElement, bottomPadding: CGFloat? = nil, topPadding: CGFloat? = nil,
                                leftPadding: CGFloat? = nil, rightPadding: CGFloat? = nil) -> Bool {
        let app = XCUIApplication()
        let windowSize = app.windows.element(boundBy: 0).frame.size
        let windowWidth = windowSize.width
        let windowHeight = windowSize.height
        let getElementPosX = element.frame.origin.x
        let getElementPosY = element.frame.origin.y
        let elementHeight = element.frame.size.height
        let elementWidth = element.frame.size.width

        if let bottomPadding = bottomPadding, bottomPadding != windowHeight - (getElementPosY + elementHeight) {
            return false
        }

        if let topPadding = topPadding, topPadding != windowHeight - getElementPosY {
            return false
        }

        if let leftPadding = leftPadding, leftPadding != getElementPosX {
            return false
        }

        if let rightPadding = rightPadding, rightPadding != windowWidth - (getElementPosX + elementWidth) {
            return false
        }
        return true
    }

    // MARK: Verifies if a character is a leter; used when More Options from device keybourd is required
    func isLetter(_ character: String) -> Bool {
        guard let scalar = UnicodeScalar(character) else { return false }
        return CharacterSet.letters.contains(scalar)
    }

    // MARK: insert a string using Device Keyboard
    func typeText(_ text: String) {
        var isAlphaKeyBoard = true
        let newText = text.characters.flatMap {(String($0))}
        for character in newText {
            if character == " " {
                XCUIApplication().keys[Keyboard.spaseBtn.rawValue].tap()
            } else {
                if isLetter(character) {
                    if !isAlphaKeyBoard {
                        XCUIApplication().keys[Keyboard.moreBtn.rawValue].tap()
                        isAlphaKeyBoard = true
                    }
                } else {
                    if isAlphaKeyBoard {
                        XCUIApplication().keys[Keyboard.moreBtn.rawValue].tap()
                        isAlphaKeyBoard = false
                    }
                }
                XCUIApplication().keys[character].tap()
            }
        }
    }
    // MARK: - will be use when an alert is displayed
    func retakeAppFocus(app: XCUIApplication) {
        RunLoop.current.run(until: Date(timeInterval: 2, since: Date()))
        app.tap()
    }
}
