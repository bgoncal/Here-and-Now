import UIKit

struct Coordinate {
  let lat: String
  let lng: String

  func fullValue() -> String {
    return "\(lat),\(lng)"
  }
}

enum PlaceType: String {
  case restaurant
  case bar
  case cafe

  var readableValue: String {
    switch self {
    case .bar:
      return "Bars"
    case .cafe:
      return "Cafes"
    case .restaurant:
      return "Restaurants"
    }
  }
}

protocol GoogleApiServiceProtocol {
  func getPlaces(for coordinates: Coordinate, type: PlaceType, completion: @escaping (Result<RawPlaces, NetworkError>) -> Void)
  func getPlaceImage(photoReference: String, completion: @escaping (Result<UIImage?, NetworkError>) -> Void)
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

  func photoUrl(photoReference: String) -> String {
    let photoPath = Configuration.values["photo"] as! String
    let photoUrl = baseUrl + photoPath + "photoreference=\(photoReference)&maxwidth=400"
    return urlWithKey(photoUrl)
  }

  func getPlaces(for coordinates: Coordinate, type: PlaceType, completion: @escaping (Result<RawPlaces, NetworkError>) -> Void) {
    guard let url = URL(string: nearbyUrl(with: coordinates, for: type)) else { return }
    URLSession.shared.dataTask(with: url) { (data, response, err) in
      DispatchQueue.main.async {

        guard let data = data else {
          completion(.failure(.emptyData))
          return
        }

        do {
          let rawPlaces = try JSONDecoder().decode(RawPlaces.self, from: data)

          if let errorMessage = rawPlaces.error_message {
            completion(.failure(.knownError(message: errorMessage)))
            return
          }

          completion(.success(rawPlaces))
        } catch let jsonErr {
          print(jsonErr)
          completion(.failure(.invalidResponse))
        }
      }
    }.resume()
  }

  func getPlaceImage(photoReference: String, completion: @escaping (Result<UIImage?, NetworkError>) -> Void) {
    guard let url = URL(string: photoUrl(photoReference: photoReference)) else { return }
    URLSession.shared.dataTask(with: url) { (data, response, err) in
      DispatchQueue.main.async {
        guard let data = data else {
          completion(.failure(.emptyData))
          return
        }

        let decodedData = Data(base64Encoded: data.base64EncodedString(), options: [])
        if let data = decodedData {
          completion(.success(UIImage(data: data)))
        } else {
          completion(.failure(.invalidResponse))
        }
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
  case knownError(message: String)
}
