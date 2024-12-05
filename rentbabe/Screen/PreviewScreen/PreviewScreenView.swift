//
//  PreviewScreenView.swift
//  rentbabe
//
//  Created by Richard Gozali on 06/12/24.
//

import SwiftUI

struct PreviewScreenView: View {
    @ObservedObject var viewModel: PreviewScreenViewModel
    
    private func renderTitle() -> some View {
        HStack(spacing: 8){
            Text("ZYNX")
                .font(.system(size: 30))
                .fontWeight(.bold)
            Circle()
                .fill(Color.green)
                .frame(width: 8, height: 8)
        }
    }

    private func renderIcons() -> some View {
        HStack(spacing: 8) {
            Image("ticker")
                .resizable()
                .scaledToFit()
                .frame(width: 30, height: 30)
            Image("instagram")
                .resizable()
                .scaledToFit()
                .frame(width: 30, height: 30)
        }
    }

    private func renderHeaderTitle() -> some View {
        HStack(spacing: 16) {
            renderTitle()
            Spacer()
            renderIcons()
        }.padding(.bottom, 16)
    }

    private func renderOverlayGameIcons() -> some View {
        HStack(spacing: 0){
            Image("game")
                .resizable()
                .scaledToFit()
                .clipShape(Circle())
                .frame(width: 120, height: 120)
            ZStack{
                Image("game")
                    .resizable()
                    .scaledToFit()
                    .clipShape(Circle())
                    .overlay(
                        Color.black.opacity(0.7)
                            .clipShape(Circle())
                        
                    )
                Text("+3")
                    .font(.system(size: 32))
                    .foregroundColor(.white)
                    .bold()
            }
            .offset(x: -60)
            .frame(width: 120, height: 120)
            Spacer()
            Image("game")
                .resizable()
                .scaledToFit()
                .clipShape(Circle())
                .frame(width: 120, height: 120)
        }
        .background(Color.clear.opacity(0.1))
        .cornerRadius(10)
        .offset(y: 200)
    }

    private func renderTitleOverlay() -> some View {
        VStack {
            HStack(alignment: .center, spacing: 10) {
                Image("star")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 36, height: 36)
                Text("Available Today")
                    .font(.system(size: 32))
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding()
            .background(Color.gray.opacity(0.2))
            .cornerRadius(30)
            Spacer()
        }
        .padding(.top, 10)
    }

    private func renderImage() -> some View {
        ZStack {
            Image(uiImage: viewModel.image)
                .resizable()
                .scaledToFit()
                .clipShape(Rectangle())
                .frame(maxWidth: .infinity, maxHeight: 550)
            renderTitleOverlay()
            renderOverlayGameIcons()
        }
        .padding(.bottom, 80)
    }

    private func renderStatus() -> some View {
        VStack(spacing: 16) {
            HStack(spacing: 8){
                Image("star")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 36, height: 36)
                Text("4.9")
                    .font(.system(size: 24))
                    .fontWeight(.bold)
                Text("(61)")
                    .font(.system(size: 24))
                    .fontWeight(.light)
                Spacer()
            }
            HStack(spacing: 0){
                Image("fire")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 36, height: 36)
                Text("110")
                    .font(.system(size: 32))
                Text(".00/1hr")
                    .font(.system(size: 24))
                Spacer()
            }
        }
    }

    var body: some View {
        ScrollView {
            VStack(spacing: 8) {
                renderHeaderTitle()
                renderImage()
                renderStatus()
            }
            .padding(.horizontal, 20)
        }
    }
}
