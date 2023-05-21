part of 'connection_cubit.dart';

@immutable
class ConnectionStates {
  final UIMessagingState messagingState;
  final String message;
  final Device? connectedDevice;
  final List<Device>? availableDevices;
  final bool isLoading;
  final bool isConnected;
  final bool isIdle;

  const ConnectionStates._({
    required this.messagingState,
    required this.message,
    required this.connectedDevice,
    required this.availableDevices,
    required this.isLoading,
    required this.isConnected,
    required this.isIdle,
  });

  const ConnectionStates.initial()
      : messagingState = UIMessagingState.idle,
        message = '',
        connectedDevice = null,
        availableDevices = null,
        isLoading = false,
        isConnected = false,
        isIdle = true;

  ConnectionStates _copyWith({
    required UIMessagingState messagingState,
    String? message,
    Device? connectedDevice,
    List<Device>? availableDevices,
    bool? isLoading,
    bool? isConnected,
    bool? isIdle,
  }) =>
      ConnectionStates._(
        messagingState: messagingState,
        message: message ?? this.message,
        connectedDevice: connectedDevice ?? this.connectedDevice,
        availableDevices: availableDevices ?? this.availableDevices,
        isLoading: isLoading ?? this.isLoading,
        isConnected: isConnected ?? this.isConnected,
        isIdle: isIdle ?? this.isIdle,
      );

  ConnectionStates _toLoading() => _copyWith(
        isIdle: false,
        isLoading: true,
        messagingState: UIMessagingState.idle,
      );

  ConnectionStates _toStopLoading() => _copyWith(
        isLoading: false,
        messagingState: UIMessagingState.idle,
      );


  ConnectionStates _toConnected(Device device) => _copyWith(
        isIdle: false,
        isConnected: true,
        connectedDevice: device,
        isLoading: false,
        messagingState: UIMessagingState.success,
        message: 'Connected Successfully',
      );

  ConnectionStates _toDisconnected() => _copyWith(
        isIdle: true,
        isConnected: false,
        isLoading: true,
        connectedDevice: null,
        messagingState: UIMessagingState.success,
        message: 'Disconnected Successfully',
      );

  ConnectionStates _toError(String message) => _copyWith(
        messagingState: UIMessagingState.error,
        message: message,
        isLoading: false,
      );

  ConnectionStates _toDataSent() => _copyWith(
        messagingState: UIMessagingState.success,
        message: 'Data Sent Successfully',
        isLoading: false,
      );

  ConnectionStates _toGotDevices(List<Device> devices) => _copyWith(
        isIdle: false,
        isLoading: false,
        messagingState: UIMessagingState.idle,
        availableDevices: devices,
      );

  ConnectionStates _toIdle() {
    return _copyWith(messagingState: UIMessagingState.idle, isIdle: true);
  }
}

enum UIMessagingState { idle, success, error }
