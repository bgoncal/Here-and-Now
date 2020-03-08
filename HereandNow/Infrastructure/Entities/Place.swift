struct RawPlaces: Codable {
  let results: [Place]
  let error_message: String?
}

struct Place: Codable, Equatable {
  let id: String
  let name: String
  let rating: Float?
  let opening_hours: RawOpeningHours?
  let photos: [Photo]?
  let geometry: Geometry

  var readableRating: String {
    if let rating = rating {
      return "\(String(describing: rating))/5.0 ⭐️"
    } else {
      return ""
    }
  }
}

struct RawOpeningHours: Codable, Equatable {
  let open_now: Bool

  var readableValue: String {
    return open_now ? "Open now" : "Closed"
  }
}

struct Photo: Codable, Equatable {
  let photo_reference: String
}

struct Geometry: Codable, Equatable {
  let location: Location
}

struct Location: Codable, Equatable {
  let lat: Double
  let lng: Double

  var coordinate: Coordinate {
    return Coordinate(lat: String(lat), lng: String(lng))
  }
}
