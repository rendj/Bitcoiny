enum NetworkServiceError: Error {
    case malformedRequestUrl
    case transportError
    case backendError
    case clientError
    case unknownError
}
