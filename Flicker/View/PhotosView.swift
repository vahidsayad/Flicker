//
//  PhotosView.swift
//  Flicker
//
//  Created by Vahid Sayad on 28/5/2022 .
//

import SwiftUI
import SDWebImageSwiftUI

struct PhotosView: View {
    @StateObject private var vm = ViewModel()
    
    private let gridItems: [GridItem] = Array(repeating: .init(.adaptive(minimum: 100), spacing: 8), count: 3)
    
    var body: some View {
        VStack {
            ScrollView {
                VStack {
                    LazyVGrid(columns: gridItems) {
                        ForEach(vm.photos, id:\.self) { photo in
                            AnimatedImage(url: URL(string: photo.url_s))
                                .resizable()
                                .scaledToFill()
                                .clipped()
                                .onAppear {
                                    vm.photoAppeared(photo)
                                }
                        }
                    }
                }
            }
            if vm.isLoading {
                ProgressView()
                    .progressViewStyle(.circular)
            }
        }
        .alert(isPresented: $vm.showError) {
            Alert(title: Text("Error"), message: Text(vm.errorMessage), dismissButton: Alert.Button.default(Text("OK")))
        }
    }
}

struct PhotosView_Previews: PreviewProvider {
    static var previews: some View {
        PhotosView()
    }
}
