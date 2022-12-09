abstract class AppStrings {
  static const appName = 'Ergonomic Office Chair Manager App';
  static const yes = 'Yes';
  static const no = 'No';
  static const didNotFindDevices = 'Did not find any devices';
  static const home = 'Home';
  static const connectedSuccessfully = 'Connected Successfully';
  static const couldNotConnect = 'Could not connect';
  static const couldNotDisconnect = 'Could not disconnect';
  static const alreadyConnected = 'Already connected';
  static const alreadyNotConnected = 'Already not connected';
  static const couldNotGetDevices = 'Could not get devices';
  static const sentSuccessfully = 'Sent Successfully';
  static const couldNotSend = 'Could not send';
  static const connected = 'Connected';
  static const notConnected = 'Not Connected';
  static const disconnect = 'Disconnect';
  static const selectDevice = 'Select Device';
  static const send = 'Send';
  static const heightFieldHintMessage = 'Enter your height in English Letters';
  static const couldNotCheckBluetoothStatus =
      'Could not check bluetooth status';
  static const heightNotInRange = 'Height is not in range';
  static const couldNotSaveSession = 'could not save session';

  static String getLastSessionMessage(int height) {
    return 'Last height was $height, do you want to send it now?';
  }
}
