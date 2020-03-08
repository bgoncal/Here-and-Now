import UIKit

class MockGoogleApiService: GoogleApiServiceProtocol {

  var mockShouldFail = false
  var mockErrorResponse: NetworkError = .invalidResponse
  var mockErrorMessage = "API Exceeded limit"
  var mockPlaces = [Place(id: "1",
                          name: "Place 1",
                          rating: 5.0,
                          opening_hours: .init(open_now: true),
                          photos: nil,
                          geometry: .init(location: .init(lat: 100, lng: 200))),
                    Place(id: "2",
                          name: "Place 2",
                          rating: 3.0,
                          opening_hours: .init(open_now: true),
                          photos: nil,
                          geometry: .init(location: .init(lat: 300, lng: 200))),
                    Place(id: "3",
                          name: "Place 3",
                          rating: 4.0,
                          opening_hours: .init(open_now: true),
                          photos: nil,
                          geometry: .init(location: .init(lat: 200, lng: 200)))]

  var mockPlacesRatingDescending = [Place(id: "1",
                                          name: "Place 1",
                                          rating: 5.0,
                                          opening_hours: .init(open_now: true),
                                          photos: nil,
                                          geometry: .init(location: .init(lat: 100, lng: 200))),
                                    Place(id: "3",
                                          name: "Place 3",
                                          rating: 4.0,
                                          opening_hours: .init(open_now: true),
                                          photos: nil,
                                          geometry: .init(location: .init(lat: 200, lng: 200))),

                                    Place(id: "2",
                                          name: "Place 2",
                                          rating: 3.0,
                                          opening_hours: .init(open_now: true),
                                          photos: nil,
                                          geometry: .init(location: .init(lat: 300, lng: 200)))]

  var mockPlacesRatingAscending = [Place(id: "2",
                                         name: "Place 2",
                                         rating: 3.0,
                                         opening_hours: .init(open_now: true),
                                         photos: nil,
                                         geometry: .init(location: .init(lat: 300, lng: 200))),
                                   Place(id: "3",
                                         name: "Place 3",
                                         rating: 4.0,
                                         opening_hours: .init(open_now: true),
                                         photos: nil,
                                         geometry: .init(location: .init(lat: 200, lng: 200))),
                                   Place(id: "1",
                                         name: "Place 1",
                                         rating: 5.0,
                                         opening_hours: .init(open_now: true),
                                         photos: nil,
                                         geometry: .init(location: .init(lat: 100, lng: 200))),]

  var mockRawPlaces: RawPlaces!

  func getPlaces(for coordinates: Coordinate, type: PlaceType, completion: @escaping (Result<RawPlaces, NetworkError>) -> Void) {
    if mockShouldFail {
      completion(.failure(mockErrorResponse))
    } else {
      completion(.success(mockRawPlaces))
    }
  }

  func getPlaceImage(photoReference: String, completion: @escaping (Result<UIImage?, NetworkError>) -> Void) {
    if mockShouldFail {
      completion(.failure(mockErrorResponse))
    } else {
      completion(.success(UIImage()))
    }
  }
}
