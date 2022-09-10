//
//  DetailViewModel.swift
//  test_weatherApp
//
//  Created by pablo.jee on 2022/09/09.
//

import Foundation

class DetailViewModel {
    //input
    var didReceiveEntity: (_: BasicWeatherEntity) -> () = { entity in }
    
    //output
    var didReceiveViewModel = { }
    var dataSource: DetailDataSourceModel { return privateDataSource }

    //properties
    private var privateDataSource: DetailDataSourceModel = DetailDataSourceModel()
    
    init() {
        bind()
    }

    private func bind() {
        print("detailContentViewModel Bind")
        didReceiveEntity = { [weak self] entity in
            self?.populateEntity(result: entity)
            self?.didReceiveViewModel()
        }
    }
    
    private func populateEntity(result: BasicWeatherEntity) {
        privateDataSource.cityName = result.cityName
        privateDataSource.icon = result.weather.first?.icon ?? ""
        privateDataSource.presentTemp = result.main.temp
        privateDataSource.feelsLikeTemp = result.main.feelsLikeTemp
        privateDataSource.presentHumid = result.main.humidity
        privateDataSource.min_Temp = result.main.tempMin
        privateDataSource.max_Temp = result.main.tempMax
        privateDataSource.pressure = result.main.pressure
        privateDataSource.windSpeed = result.wind.speed
        privateDataSource.weatherDesc = result.weather.first?.description ?? ""
    }
}
