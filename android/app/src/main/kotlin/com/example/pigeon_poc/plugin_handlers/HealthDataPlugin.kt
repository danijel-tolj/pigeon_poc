package com.example.pigeon_poc.plugin_handlers

import HealthDataFlutterApi
import HealthDataHostApi
import StepsData
import TimeSeriesData
import android.os.Looper
import io.flutter.plugin.common.BinaryMessenger
import java.time.Instant
import java.util.Timer
import java.util.TimerTask
import kotlin.random.Random

class HealthDataPlugin(binaryMessenger: BinaryMessenger) : HealthDataHostApi {
    private val _flutterApi: HealthDataFlutterApi = HealthDataFlutterApi(binaryMessenger)

    private val timer = Timer()
    private val handler = android.os.Handler(Looper.getMainLooper())

    private val task = object : TimerTask() {
        override fun run() {
            // Use Handler to execute UI-related task on the main thread
            handler.post {
                _flutterApi.onHeartRateAdded(
                    TimeSeriesData(
                        Instant.now().toEpochMilli(), Random.nextInt(60, 70 + 1).toLong()
                    )
                ) {}
            }
        }
    }

    init {
        HealthDataHostApi.setUp(binaryMessenger, this)
        timer.scheduleAtFixedRate(task, 0, 1000)
    }

    fun dispose() {
        timer.cancel()
    }

    override fun getHeartRate(
        from: Long,
        to: Long,
        callback: (Result<List<TimeSeriesData>>) -> Unit
    ) {
        // you can use the parameters passed from flutter method call here
        val from = Instant.ofEpochMilli(from)
        val to = Instant.ofEpochMilli(to)


        // Fetch some health data
        val data = listOf(
            TimeSeriesData(
                timestamp = Instant.now().toEpochMilli() + 1000,
                data = Random.nextInt(60, 70).toLong()
            ),
            TimeSeriesData(
                timestamp = Instant.now().toEpochMilli() + 2000,
                data = Random.nextInt(60, 70).toLong()
            ),
            TimeSeriesData(
                timestamp = Instant.now().toEpochMilli() + 3000,
                data = Random.nextInt(60, 70).toLong()
            )
        )
        callback(Result.success(data))
    }



    override fun getSteps(
        timestampFrom: Long,
        timestampTo: Long,
        callback: (Result<List<StepsData>>) -> Unit
    ) {
        TODO("Not yet implemented")
    }

}