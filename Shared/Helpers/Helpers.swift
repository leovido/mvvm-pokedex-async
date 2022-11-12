import Foundation

func validateResponse(urlResponse: URLResponse) throws -> Bool {
	guard let response = urlResponse as? HTTPURLResponse,
	      (200 ... 399) ~= response.statusCode
	else {
		throw NSError(domain: "Invalid response", code: 0001)
	}
	return true
}
