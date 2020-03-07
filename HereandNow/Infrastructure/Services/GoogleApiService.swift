import Foundation

struct Coordinate {
  let lat: String
  let long: String

  func fullValue() -> String {
    return "\(lat),\(long)"
  }
}

enum PlaceType: String {
  case restaurant
  case bar
  case cafe
}

protocol GoogleApiServiceProtocol {
  func getPlaces(for coordinates: Coordinate, type: PlaceType, completion: @escaping (Result<RawPlaces, NetworkError>) -> Void)
}

class GoogleApiService: GoogleApiServiceProtocol {

  let baseUrl: String = {
    return Configuration.values["baseUrl"] as! String
  }()

  func nearbyUrl(with coordinates: Coordinate, for type: PlaceType) -> String {
    let nearbyPath = Configuration.values["nearbyPath"] as! String
    let nearbyUrl = baseUrl + nearbyPath + "json?location=\(coordinates.fullValue())&type=\(type.rawValue)&radius=1500"
    return urlWithKey(nearbyUrl)
  }

  func getPlaces(for coordinates: Coordinate, type: PlaceType, completion: @escaping (Result<RawPlaces, NetworkError>) -> Void) {
    guard let url = URL(string: nearbyUrl(with: coordinates, for: type)) else { return }
    URLSession.shared.dataTask(with: url) { (data, response, err) in

      guard let data = data else {
        completion(.failure(.emptyData))
        return
      }

      do {
        let places = try JSONDecoder().decode(RawPlaces.self, from: data)
        completion(.success(places))
      } catch let jsonErr {
        print(jsonErr)
        completion(.failure(.invalidResponse))
      }

    }.resume()
  }

  private func urlWithKey(_ url: String) -> String {
    let key = Configuration.values["apiKey"] as! String
    return "\(url)&key=\(key)"
  }
}

enum NetworkError: Error {
  case invalidResponse
  case emptyData
}
