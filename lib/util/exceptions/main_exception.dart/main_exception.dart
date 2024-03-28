class MainException{
  final String message;
  final int statusCode;
  MainException({required this.message, required this.statusCode});
}
class VpnException extends MainException{
  VpnException({required super.message, required super.statusCode});
}
class ServerException extends MainException{
  ServerException({required super.message, required super.statusCode});
}
class UnknownException extends MainException{
  UnknownException({required super.message, required super.statusCode});
}
class ConnectivityException extends MainException{
  ConnectivityException({required super.message, required super.statusCode});
}