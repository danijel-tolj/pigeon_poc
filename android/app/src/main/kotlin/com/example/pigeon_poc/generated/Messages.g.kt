// Autogenerated from Pigeon (v16.0.5), do not edit directly.
// See also: https://pub.dev/packages/pigeon


import android.util.Log
import io.flutter.plugin.common.BasicMessageChannel
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MessageCodec
import io.flutter.plugin.common.StandardMessageCodec
import java.io.ByteArrayOutputStream
import java.nio.ByteBuffer

private fun wrapResult(result: Any?): List<Any?> {
  return listOf(result)
}

private fun wrapError(exception: Throwable): List<Any?> {
  if (exception is FlutterError) {
    return listOf(
      exception.code,
      exception.message,
      exception.details
    )
  } else {
    return listOf(
      exception.javaClass.simpleName,
      exception.toString(),
      "Cause: " + exception.cause + ", Stacktrace: " + Log.getStackTraceString(exception)
    )
  }
}

private fun createConnectionError(channelName: String): FlutterError {
  return FlutterError("channel-error",  "Unable to establish connection on channel: '$channelName'.", "")}

/**
 * Error class for passing custom error details to Flutter via a thrown PlatformException.
 * @property code The error code.
 * @property message The error message.
 * @property details The error details. Must be a datatype supported by the api codec.
 */
class FlutterError (
  val code: String,
  override val message: String? = null,
  val details: Any? = null
) : Throwable()

enum class DeviceType(val raw: Int) {
  APPLEWATCH(0),
  OURAS(1);

  companion object {
    fun ofRaw(raw: Int): DeviceType? {
      return values().firstOrNull { it.raw == raw }
    }
  }
}

/** Generated class from Pigeon that represents data sent in messages. */
data class TimeSeriesData (
  val timestamp: Long,
  val data: Long

) {
  companion object {
    @Suppress("UNCHECKED_CAST")
    fun fromList(list: List<Any?>): TimeSeriesData {
      val timestamp = list[0].let { if (it is Int) it.toLong() else it as Long }
      val data = list[1].let { if (it is Int) it.toLong() else it as Long }
      return TimeSeriesData(timestamp, data)
    }
  }
  fun toList(): List<Any?> {
    return listOf<Any?>(
      timestamp,
      data,
    )
  }
}

@Suppress("UNCHECKED_CAST")
private object HealthDataHostApiCodec : StandardMessageCodec() {
  override fun readValueOfType(type: Byte, buffer: ByteBuffer): Any? {
    return when (type) {
      128.toByte() -> {
        return (readValue(buffer) as? List<Any?>)?.let {
          TimeSeriesData.fromList(it)
        }
      }
      else -> super.readValueOfType(type, buffer)
    }
  }
  override fun writeValue(stream: ByteArrayOutputStream, value: Any?)   {
    when (value) {
      is TimeSeriesData -> {
        stream.write(128)
        writeValue(stream, value.toList())
      }
      else -> super.writeValue(stream, value)
    }
  }
}

/** Generated interface from Pigeon that represents a handler of messages from Flutter. */
interface HealthDataHostApi {
  fun getHeartRate(from: Long, to: Long, callback: (Result<List<TimeSeriesData>?>) -> Unit)

  companion object {
    /** The codec used by HealthDataHostApi. */
    val codec: MessageCodec<Any?> by lazy {
      HealthDataHostApiCodec
    }
    /** Sets up an instance of `HealthDataHostApi` to handle messages through the `binaryMessenger`. */
    @Suppress("UNCHECKED_CAST")
    fun setUp(binaryMessenger: BinaryMessenger, api: HealthDataHostApi?) {
      run {
        val channel = BasicMessageChannel<Any?>(binaryMessenger, "dev.flutter.pigeon.pigeon_poc.HealthDataHostApi.getHeartRate", codec)
        if (api != null) {
          channel.setMessageHandler { message, reply ->
            val args = message as List<Any?>
            val fromArg = args[0].let { if (it is Int) it.toLong() else it as Long }
            val toArg = args[1].let { if (it is Int) it.toLong() else it as Long }
            api.getHeartRate(fromArg, toArg) { result: Result<List<TimeSeriesData>?> ->
              val error = result.exceptionOrNull()
              if (error != null) {
                reply.reply(wrapError(error))
              } else {
                val data = result.getOrNull()
                reply.reply(wrapResult(data))
              }
            }
          }
        } else {
          channel.setMessageHandler(null)
        }
      }
    }
  }
}
@Suppress("UNCHECKED_CAST")
private object HealthDataFlutterApiCodec : StandardMessageCodec() {
  override fun readValueOfType(type: Byte, buffer: ByteBuffer): Any? {
    return when (type) {
      128.toByte() -> {
        return (readValue(buffer) as? List<Any?>)?.let {
          TimeSeriesData.fromList(it)
        }
      }
      else -> super.readValueOfType(type, buffer)
    }
  }
  override fun writeValue(stream: ByteArrayOutputStream, value: Any?)   {
    when (value) {
      is TimeSeriesData -> {
        stream.write(128)
        writeValue(stream, value.toList())
      }
      else -> super.writeValue(stream, value)
    }
  }
}

/** Generated class from Pigeon that represents Flutter messages that can be called from Kotlin. */
@Suppress("UNCHECKED_CAST")
class HealthDataFlutterApi(private val binaryMessenger: BinaryMessenger) {
  companion object {
    /** The codec used by HealthDataFlutterApi. */
    val codec: MessageCodec<Any?> by lazy {
      HealthDataFlutterApiCodec
    }
  }
  fun onHeartRateAdded(dataArg: TimeSeriesData, callback: (Result<Unit>) -> Unit)
{
    val channelName = "dev.flutter.pigeon.pigeon_poc.HealthDataFlutterApi.onHeartRateAdded"
    val channel = BasicMessageChannel<Any?>(binaryMessenger, channelName, codec)
    channel.send(listOf(dataArg)) {
      if (it is List<*>) {
        if (it.size > 1) {
          callback(Result.failure(FlutterError(it[0] as String, it[1] as String, it[2] as String?)))
        } else {
          callback(Result.success(Unit))
        }
      } else {
        callback(Result.failure(createConnectionError(channelName)))
      } 
    }
  }
}
