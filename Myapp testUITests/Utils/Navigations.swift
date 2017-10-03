//
//  Navigations.swift
//  IOS Project Starter
//
//  Created by Oana Popescu on 05/09/2017.
//  Copyright © 2017 Valentina Iancu. All rights reserved.
//

import Foundation

func navigateToHomePage() -> HomePage {
    let homePage = HomePage()
    homePage.waitForPageLoaded()
    return homePage
}
