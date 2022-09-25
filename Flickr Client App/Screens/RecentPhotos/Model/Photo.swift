//
//  Photo.swift
//  Flickr Client App
//
//  Created by Ali Berkay BERBER on 1.09.2022.
//

import Foundation


// MARK: - Welcome
struct Photo: Codable {
    let id, owner, secret, server: String?
    let farm: Int?
    let title: String?
    let ispublic, isfriend, isfamily: Int?
    let license: String?
    let welcomeDescription: Description?
    let dateupload, lastupdate, datetaken: String?
    let datetakengranularity: Int?
    let datetakenunknown, ownername, iconserver: String?
    let iconfarm: Int?
    let views, tags, machineTags, originalsecret: String?
    let originalformat: String?
    let latitude, longitude, accuracy, context: Int?
    let media, mediaStatus: String?
    let urlSq: String?
    let heightSq, widthSq: Int?
    let urlT: String?
    let heightT, widthT: Int?
    let urlS: String?
    let heightS, widthS: Int?
    let urlQ: String?
    let heightQ, widthQ: Int?
    let urlM: String?
    let heightM, widthM: Int?
    let urlN: String?
    let heightN, widthN: Int?
    let urlZ: String?
    let heightZ, widthZ: Int?
    let urlC: String?
    let heightC, widthC: Int?
    let urlL: String?
    let heightL, widthL: Int?
    let urlO: String?
    let heightO, widthO: Int?
    let pathalias: JSONNull?

    enum CodingKeys: String, CodingKey {
        case id, owner, secret, server, farm, title, ispublic, isfriend, isfamily, license
        case welcomeDescription = "description"
        case dateupload, lastupdate, datetaken, datetakengranularity, datetakenunknown, ownername, iconserver, iconfarm, views, tags
        case machineTags = "machine_tags"
        case originalsecret, originalformat, latitude, longitude, accuracy, context, media
        case mediaStatus = "media_status"
        case urlSq = "url_sq"
        case heightSq = "height_sq"
        case widthSq = "width_sq"
        case urlT = "url_t"
        case heightT = "height_t"
        case widthT = "width_t"
        case urlS = "url_s"
        case heightS = "height_s"
        case widthS = "width_s"
        case urlQ = "url_q"
        case heightQ = "height_q"
        case widthQ = "width_q"
        case urlM = "url_m"
        case heightM = "height_m"
        case widthM = "width_m"
        case urlN = "url_n"
        case heightN = "height_n"
        case widthN = "width_n"
        case urlZ = "url_z"
        case heightZ = "height_z"
        case widthZ = "width_z"
        case urlC = "url_c"
        case heightC = "height_c"
        case widthC = "width_c"
        case urlL = "url_l"
        case heightL = "height_l"
        case widthL = "width_l"
        case urlO = "url_o"
        case heightO = "height_o"
        case widthO = "width_o"
        case pathalias
    }
}

// MARK: - Description
struct Description: Codable {
    let content: String

    enum CodingKeys: String, CodingKey {
        case content = "_content"
    }
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}
