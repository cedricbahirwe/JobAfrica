//
//  Collections.swift
//  JobLess
//
//  Created by Cédric Bahirwe on 12/09/2022.
//

import Foundation

public enum FirebaseCollection: String {
    #if DEBUG
    case general = "all-jobs-test"
    #else
    case general = "all-jobs"
    #endif

    #if DEBUG
    case promo = "promotion-jobs-test"
    #else
    case promo = "promotion-jobs"
    #endif

//    #if DEBUG
//    case companies = "companies-test"
//    #else
    case companies
//    #endif


    case jobTags = "job-tags"
    case jobCategories = "job-categories"
    case jobTypes = "job-types"
    case users

}
