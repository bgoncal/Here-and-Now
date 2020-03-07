struct RawPlaces: Codable {
  let results: [Places]
}

struct Places: Codable {
  let id: String
  let name: String
  let rating: Float?
  let opening_hours: RawOpeningHours?
  let photos: [Photo]?
}

struct RawOpeningHours: Codable {
  let open_now: Bool
}

struct Photo: Codable {
  let photo_reference: String
}
