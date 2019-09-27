struct Owner: Decodable {
    var name: String
    var photoUrl: String
    
    enum CodingKeys: String, CodingKey {
        case name = "login"
        case photoUrl = "avatar_url"
    }
    
    init(from decoder: Decoder) throws {
        let values = try? decoder.container(keyedBy: CodingKeys.self)
        name = try values?.decode(String.self, forKey: .name) ?? ""
        photoUrl = try values?.decode(String.self, forKey: .photoUrl) ?? ""
    }
    
    init() {
        name = ""
        photoUrl = ""
    }
}
