//
//  PhotosView.ViewModel.swift
//  Flicker
//
//  Created by Vahid Sayad on 28/5/2022 .
//

import SwiftUI

extension PhotosView {
    class ViewModel: ObservableObject {
        init() {
            getMorePhoto()
        }
        
        private var page = 0
        private var pageSize = 50
        
        @Published var isLoading = false
        @Published var photos = [FlickerPhoto]()
        @Published var showError = false
        @Published var errorMessage = ""
        
        private func getMorePhoto() {
            page += 1
            fetchPhotos(page: page, pageSize: pageSize)
        }
        
        private func fetchPhotos(page: Int, pageSize: Int) {
            guard !isLoading else { return }
            isLoading = true
            let network = Network<FlickerPhotoResponse>(api: FlickerService.search(page: page, pageSize: pageSize))
            network.execute { [weak self] response in
                DispatchQueue.main.async {
                    self?.isLoading = false
                    switch response {
                    case .failure(let error):
                        self?.handleNetworkError(error)
                    case .success(let photoResponse):
                        self?.photos.append(contentsOf: photoResponse.photos.photo)
                    }
                }
            }
        }
        
        private func handleNetworkError(_ error: NetworkError) {
            self.errorMessage = error.localizedDescription
            self.showError = true
        }
        
        func listReachedToBottomOfList() {
            getMorePhoto()
        }
        
        func photoAppeared(_ photo: FlickerPhoto) {
            guard photos.count >= 10 else { return }
            if photo == photos[photos.count - 10] {
                getMorePhoto()
            }
        }
    }
}
