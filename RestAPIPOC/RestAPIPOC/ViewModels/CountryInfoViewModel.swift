//
//  CountryInfoViewModel.swift
//  RestAPIPOC
//
//  Created by Siddharth Kumar on 07/10/20.
//  Copyright © 2020 MyOrganisation. All rights reserved.
//

import Foundation

protocol CountryInfoViewModelDelegate: AnyObject {
   
    func fetchCountryInfoStarted()
    func fetchCountryInfoEnded()
    func fetchCountryEndedWithError(error: Error?, code: Int)
    
}

final class CountryInfoViewModel {
    
    var countryInfo: CountryInfo?
    weak var delegate: CountryInfoViewModelDelegate?

    func getCountryInfo() {
        delegate?.fetchCountryInfoStarted()
        NetworkService.makeRequest(for: NetworkEndPoint.countryInfoEndPoint, method: .GET, success: { [weak self] (responseData) in
            guard let data = responseData else { return }
            guard let utf8Data = String(decoding: data, as: UTF8.self).data(using: .utf8) else { return }
            let jsonDecoder = JSONDecoder()
            do {
                self?.countryInfo = try jsonDecoder.decode(CountryInfo.self, from: utf8Data)
            }catch {
                print(error)
            }
            self?.delegate?.fetchCountryInfoEnded()
        }) { [weak self](_, error, code) in
            self?.delegate?.fetchCountryInfoEnded()
            self?.delegate?.fetchCountryEndedWithError(error: error, code: code)
        }
    }
    
    func numberOfRows() -> Int {
        return countryInfo?.rows?.count ?? 0
    }
    
    func screenTitle() -> String? {
        return countryInfo?.title
    }
    
    func title(index: Int) -> String? {
        return countryInfo?.rows?[index].title
    }
    
    func message(index: Int) -> String? {
        return countryInfo?.rows?[index].description
    }
    
    func imageUrl(index: Int) -> String? {
        return countryInfo?.rows?[index].imageUrl
    }
    
    func configureCell(cell: InfoTableViewCell, index: Int) {
        cell.configureCell(title: title(index: index), message: message(index: index))
    }
    
    func showImageForCell(cell: InfoTableViewCell, index: Int, completion: @escaping () -> Void) {
        cell.setImage(imageString: imageUrl(index: index), completion: completion)
    }
    
}
