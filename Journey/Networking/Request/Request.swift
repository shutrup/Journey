import Foundation

class Request {
    private var boundaryString: String {
        return "Boundary-\(NSUUID().uuidString)"
    }
    
    func sendRequest<T: Decodable> (endpoint: Endpoint, responseModel: T.Type, urlEncoded: Bool = false) async ->  Result<T, RequestError> {
        guard let url = URL(string: API.baseURL + endpoint.path) else {
            return .failure(.invalidURL)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        request.allHTTPHeaderFields = endpoint.header
        
        if let body = endpoint.parameters {
            switch endpoint.method {
            case.get:
                var urlComponents = URLComponents(string: API.baseURL + endpoint.path)
                urlComponents?.queryItems = body.map({ URLQueryItem(name: $0.key, value: "\($0.value)")})
                request.url = body.count > 0 ? urlComponents?.url : URL(string: API.baseURL + endpoint.path)
            case.post, .put, .delete, .patch:
                if urlEncoded {
                    request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
                    let postData = body.percentEncoded()
                    request.httpBody = postData
                } else {
                    request.httpBody = RequestEncoder.json(parameters: body)
                    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
                    request.addValue("application/json", forHTTPHeaderField: "Accept")
                }
            }
        }
        
        do {
            print(request.url)
            let (data, response) = try await URLSession.shared.data(from: request)
            guard let httpResponse = response as? HTTPURLResponse else {
                return .failure(.noResponse)
            }
            
            switch httpResponse.statusCode {
            case 200...299:
                guard let decodedResponse = try? JSONDecoder().decode(responseModel, from: data) else {
                    return .failure(.decode)
                }
                return .success(decodedResponse)
            default:
                guard let decodedError = try? JSONDecoder().decode(ErrorResponse.self, from: data) else {
                    return .failure(.unexpectedStatusCode)
                }
                return .failure(.serverError(decodedError.error))
            }
        } catch {
            return .failure(.unknown)
        }
    }
}
