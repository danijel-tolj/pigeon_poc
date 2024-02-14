// Autogenerated from Pigeon (v16.0.5), do not edit directly.
// See also: https://pub.dev/packages/pigeon

import Foundation

#if os(iOS)
  import Flutter
#elseif os(macOS)
  import FlutterMacOS
#else
  #error("Unsupported platform.")
#endif

private func wrapResult(_ result: Any?) -> [Any?] {
  return [result]
}

private func wrapError(_ error: Any) -> [Any?] {
  if let flutterError = error as? FlutterError {
    return [
      flutterError.code,
      flutterError.message,
      flutterError.details,
    ]
  }
  return [
    "\(error)",
    "\(type(of: error))",
    "Stacktrace: \(Thread.callStackSymbols)",
  ]
}

private func createConnectionError(withChannelName channelName: String) -> FlutterError {
  return FlutterError(code: "channel-error", message: "Unable to establish connection on channel: '\(channelName)'.", details: "")
}

private func isNullish(_ value: Any?) -> Bool {
  return value is NSNull || value == nil
}

private func nilOrValue<T>(_ value: Any?) -> T? {
  if value is NSNull { return nil }
  return value as! T?
}

enum BluetoothStatus: Int {
  case poweredOn = 0
  case poweredOff = 1
  case resetting = 2
  case unauthorized = 3
  case notSupported = 4
}

/// Generated class from Pigeon that represents data sent in messages.
struct TimeSeriesData {
  var timestamp: Int64
  var data: Int64

  static func fromList(_ list: [Any?]) -> TimeSeriesData? {
    let timestamp = list[0] is Int64 ? list[0] as! Int64 : Int64(list[0] as! Int32)
    let data = list[1] is Int64 ? list[1] as! Int64 : Int64(list[1] as! Int32)

    return TimeSeriesData(
      timestamp: timestamp,
      data: data
    )
  }
  func toList() -> [Any?] {
    return [
      timestamp,
      data,
    ]
  }
}

/// Generated class from Pigeon that represents data sent in messages.
struct StepsData {
  var timestamp: Int64
  var data: Int64

  static func fromList(_ list: [Any?]) -> StepsData? {
    let timestamp = list[0] is Int64 ? list[0] as! Int64 : Int64(list[0] as! Int32)
    let data = list[1] is Int64 ? list[1] as! Int64 : Int64(list[1] as! Int32)

    return StepsData(
      timestamp: timestamp,
      data: data
    )
  }
  func toList() -> [Any?] {
    return [
      timestamp,
      data,
    ]
  }
}

private class HealthDataHostApiCodecReader: FlutterStandardReader {
  override func readValue(ofType type: UInt8) -> Any? {
    switch type {
    case 128:
      return StepsData.fromList(self.readValue() as! [Any?])
    case 129:
      return TimeSeriesData.fromList(self.readValue() as! [Any?])
    default:
      return super.readValue(ofType: type)
    }
  }
}

private class HealthDataHostApiCodecWriter: FlutterStandardWriter {
  override func writeValue(_ value: Any) {
    if let value = value as? StepsData {
      super.writeByte(128)
      super.writeValue(value.toList())
    } else if let value = value as? TimeSeriesData {
      super.writeByte(129)
      super.writeValue(value.toList())
    } else {
      super.writeValue(value)
    }
  }
}

private class HealthDataHostApiCodecReaderWriter: FlutterStandardReaderWriter {
  override func reader(with data: Data) -> FlutterStandardReader {
    return HealthDataHostApiCodecReader(data: data)
  }

  override func writer(with data: NSMutableData) -> FlutterStandardWriter {
    return HealthDataHostApiCodecWriter(data: data)
  }
}

class HealthDataHostApiCodec: FlutterStandardMessageCodec {
  static let shared = HealthDataHostApiCodec(readerWriter: HealthDataHostApiCodecReaderWriter())
}

/// Generated protocol from Pigeon that represents a handler of messages from Flutter.
protocol HealthDataHostApi {
  func getHeartRate(from: Int64, to: Int64, completion: @escaping (Result<[TimeSeriesData], Error>) -> Void)
  func getSteps(timestampFrom: Int64, timestampTo: Int64, completion: @escaping (Result<[StepsData], Error>) -> Void)
}

/// Generated setup class from Pigeon to handle messages through the `binaryMessenger`.
class HealthDataHostApiSetup {
  /// The codec used by HealthDataHostApi.
  static var codec: FlutterStandardMessageCodec { HealthDataHostApiCodec.shared }
  /// Sets up an instance of `HealthDataHostApi` to handle messages through the `binaryMessenger`.
  static func setUp(binaryMessenger: FlutterBinaryMessenger, api: HealthDataHostApi?) {
    let getHeartRateChannel = FlutterBasicMessageChannel(name: "dev.flutter.pigeon.pigeon_poc.HealthDataHostApi.getHeartRate", binaryMessenger: binaryMessenger, codec: codec)
    if let api = api {
      getHeartRateChannel.setMessageHandler { message, reply in
        let args = message as! [Any?]
        let fromArg = args[0] is Int64 ? args[0] as! Int64 : Int64(args[0] as! Int32)
        let toArg = args[1] is Int64 ? args[1] as! Int64 : Int64(args[1] as! Int32)
        api.getHeartRate(from: fromArg, to: toArg) { result in
          switch result {
          case .success(let res):
            reply(wrapResult(res))
          case .failure(let error):
            reply(wrapError(error))
          }
        }
      }
    } else {
      getHeartRateChannel.setMessageHandler(nil)
    }
    let getStepsChannel = FlutterBasicMessageChannel(name: "dev.flutter.pigeon.pigeon_poc.HealthDataHostApi.getSteps", binaryMessenger: binaryMessenger, codec: codec)
    if let api = api {
      getStepsChannel.setMessageHandler { message, reply in
        let args = message as! [Any?]
        let timestampFromArg = args[0] is Int64 ? args[0] as! Int64 : Int64(args[0] as! Int32)
        let timestampToArg = args[1] is Int64 ? args[1] as! Int64 : Int64(args[1] as! Int32)
        api.getSteps(timestampFrom: timestampFromArg, timestampTo: timestampToArg) { result in
          switch result {
          case .success(let res):
            reply(wrapResult(res))
          case .failure(let error):
            reply(wrapError(error))
          }
        }
      }
    } else {
      getStepsChannel.setMessageHandler(nil)
    }
  }
}
private class HealthDataFlutterApiCodecReader: FlutterStandardReader {
  override func readValue(ofType type: UInt8) -> Any? {
    switch type {
    case 128:
      return TimeSeriesData.fromList(self.readValue() as! [Any?])
    default:
      return super.readValue(ofType: type)
    }
  }
}

private class HealthDataFlutterApiCodecWriter: FlutterStandardWriter {
  override func writeValue(_ value: Any) {
    if let value = value as? TimeSeriesData {
      super.writeByte(128)
      super.writeValue(value.toList())
    } else {
      super.writeValue(value)
    }
  }
}

private class HealthDataFlutterApiCodecReaderWriter: FlutterStandardReaderWriter {
  override func reader(with data: Data) -> FlutterStandardReader {
    return HealthDataFlutterApiCodecReader(data: data)
  }

  override func writer(with data: NSMutableData) -> FlutterStandardWriter {
    return HealthDataFlutterApiCodecWriter(data: data)
  }
}

class HealthDataFlutterApiCodec: FlutterStandardMessageCodec {
  static let shared = HealthDataFlutterApiCodec(readerWriter: HealthDataFlutterApiCodecReaderWriter())
}

/// Generated protocol from Pigeon that represents Flutter messages that can be called from Swift.
protocol HealthDataFlutterApiProtocol {
  func onHeartRateAdded(data dataArg: TimeSeriesData, completion: @escaping (Result<Void, FlutterError>) -> Void)
}
class HealthDataFlutterApi: HealthDataFlutterApiProtocol {
  private let binaryMessenger: FlutterBinaryMessenger
  init(binaryMessenger: FlutterBinaryMessenger) {
    self.binaryMessenger = binaryMessenger
  }
  var codec: FlutterStandardMessageCodec {
    return HealthDataFlutterApiCodec.shared
  }
  func onHeartRateAdded(data dataArg: TimeSeriesData, completion: @escaping (Result<Void, FlutterError>) -> Void) {
    let channelName: String = "dev.flutter.pigeon.pigeon_poc.HealthDataFlutterApi.onHeartRateAdded"
    let channel = FlutterBasicMessageChannel(name: channelName, binaryMessenger: binaryMessenger, codec: codec)
    channel.sendMessage([dataArg] as [Any?]) { response in
      guard let listResponse = response as? [Any?] else {
        completion(.failure(createConnectionError(withChannelName: channelName)))
        return
      }
      if listResponse.count > 1 {
        let code: String = listResponse[0] as! String
        let message: String? = nilOrValue(listResponse[1])
        let details: String? = nilOrValue(listResponse[2])
        completion(.failure(FlutterError(code: code, message: message, details: details)))
      } else {
        completion(.success(Void()))
      }
    }
  }
}
/// Generated protocol from Pigeon that represents Flutter messages that can be called from Swift.
protocol BleScannerFlutterApiProtocol {
  func onBluetoothStatusChanged(status statusArg: BluetoothStatus, completion: @escaping (Result<Void, FlutterError>) -> Void)
}
class BleScannerFlutterApi: BleScannerFlutterApiProtocol {
  private let binaryMessenger: FlutterBinaryMessenger
  init(binaryMessenger: FlutterBinaryMessenger) {
    self.binaryMessenger = binaryMessenger
  }
  func onBluetoothStatusChanged(status statusArg: BluetoothStatus, completion: @escaping (Result<Void, FlutterError>) -> Void) {
    let channelName: String = "dev.flutter.pigeon.pigeon_poc.BleScannerFlutterApi.onBluetoothStatusChanged"
    let channel = FlutterBasicMessageChannel(name: channelName, binaryMessenger: binaryMessenger)
    channel.sendMessage([statusArg.rawValue] as [Any?]) { response in
      guard let listResponse = response as? [Any?] else {
        completion(.failure(createConnectionError(withChannelName: channelName)))
        return
      }
      if listResponse.count > 1 {
        let code: String = listResponse[0] as! String
        let message: String? = nilOrValue(listResponse[1])
        let details: String? = nilOrValue(listResponse[2])
        completion(.failure(FlutterError(code: code, message: message, details: details)))
      } else {
        completion(.success(Void()))
      }
    }
  }
}
