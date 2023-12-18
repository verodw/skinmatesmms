//
//  Model.swift
//  projectLab
//
//  Created by prk on 04/12/23.
//s

import Foundation

struct Person {
//    var id: UUID?
    var name: String?
    var email: String?
    var pass: String?
}

struct Makeup {
    var name: String?
    var brand: String?
    var price: String?
    var type:String?
    var img:String?
}

struct MakeupReview {
    var userEmail: String?
    var productName: String?
    var rating: String?
    var desc: String?
}
