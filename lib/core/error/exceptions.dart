// Exceptions for error handling in the application
class ServerException implements Exception {}

// This exception will be thrown when there is no data in the cache
class EmptyCacheException implements Exception {}

// This exception will be thrown when there is no internet connection
class OfflineException implements Exception {}
