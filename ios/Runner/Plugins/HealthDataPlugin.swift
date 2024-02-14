//
//  HealthDataPlugin.swift
//  Runner
//
//  Created by Danijel Tolj on 5. 2. 2024..
//

import Foundation
import Flutter

extension FlutterError: Error {}

class HealthDataPlugin: HealthDataHostApi {
    func getSteps(timestampFrom: Int64, timestampTo: Int64, completion: @escaping (Result<[StepsData], Error>) -> Void) {
        // competion(.success(data))
        // completion(.failure())
    }
    
    private let flutterApi: HealthDataFlutterApi
    private var timer: Timer?
    
    init(binaryMessenger: FlutterBinaryMessenger) {
        self.flutterApi = HealthDataFlutterApi(binaryMessenger: binaryMessenger)
        HealthDataHostApiSetup.setUp(binaryMessenger: binaryMessenger, api: self)
        self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(timerTask), userInfo: nil, repeats: true)
    }
    
    @objc func timerTask() {
        let timeSeriesData = TimeSeriesData(
            timestamp: Int64(Date().timeIntervalSince1970 * 1000),
            data: Int64.random(in: 60...70)
        )
        self.flutterApi.onHeartRateAdded(data: timeSeriesData) { _ in }
    }
    
    func dispose() {
        timer?.invalidate()
        timer = nil
    }
    
    func getHeartRate(from: Int64, to: Int64, completion: @escaping (Result<[TimeSeriesData], Error>) -> Void) {
        // you can use the parameters passed from flutter method call here
        //let fromDate = Date(timeIntervalSince1970: TimeInterval(from) / 1000)
        //let toDate = Date(timeIntervalSince1970: TimeInterval(to) / 1000)
        
        
        // Fetch some health data
        let data = [
            TimeSeriesData(timestamp: Int64(Date().timeIntervalSince1970 * 1000) - 1000, data: Int64.random(in: 60...70)),
            TimeSeriesData(timestamp: Int64(Date().timeIntervalSince1970 * 1000) - 2000, data: Int64.random(in: 60...70)),
            TimeSeriesData(timestamp: Int64(Date().timeIntervalSince1970 * 1000) - 3000, data: Int64.random(in: 60...70))
        ]
        
        completion(.success(data))
    }
}
