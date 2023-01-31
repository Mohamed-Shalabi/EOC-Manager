class ConnectionStateEntity {
  final bool isConnected;

  ConnectionStateEntity.connected() : isConnected = true;

  ConnectionStateEntity.disconnected() : isConnected = false;
}
