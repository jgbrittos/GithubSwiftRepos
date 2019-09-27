struct Repo: Decodable {
    var name: String
    var owner: Owner
    var stars: Int
    
    enum CodingKeys: String, CodingKey {
        case name
        case owner
        case stars = "stargazers_count"
    }

    init(from decoder: Decoder) throws {
        let values = try? decoder.container(keyedBy: CodingKeys.self)
        name = try values?.decode(String.self, forKey: .name) ?? ""
        owner = try values?.decode(Owner.self, forKey: .owner) ?? Owner()
        stars = try values?.decode(Int.self, forKey: .stars) ?? -1
    }
}
