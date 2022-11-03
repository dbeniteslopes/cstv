//
//  PlayerView.swift
//  CSTVApp
//
//  Created by Diego Benites Lopes on 03/11/22.
//

import SwiftUI

struct PlayerView: View {
    enum ColumnSide { case left, right }
    
    let player: Player
    let columnSide: ColumnSide
    
    private var horizontalAlignment: HorizontalAlignment {
        columnSide == .left ? .trailing : .leading
    }
    
    private var cornersToRound: UIRectCorner {
        columnSide == .left ? [.topRight, .bottomRight] : [.topLeft, .bottomLeft]
    }
    
    private var imagePadding: Edge.Set {
        columnSide == .left ? .trailing : .leading
    }
    
    private var bgColor: Color {
        columnSide == .left ? .yellow : .pink
    }
    
    var body: some View {
        HStack(alignment: .top, spacing: 16) {
            if columnSide == .left {
                Spacer()
                playerInfo
            }
            
            if let stringUrl = player.imageUrl, let url = URL(string: stringUrl) {
                playerImage(with: url)
            } else {
                placeholder
            }
            
            if columnSide == .right {
                playerInfo
                Spacer()
            }
        }
        .frame(maxWidth: .infinity)
        .background(
            Rectangle()
                .fill(Color(red: 0.153, green: 0.149, blue: 0.224, opacity: 1))
                .cornerRadius(radius: 8, corners: cornersToRound)
        )
    }
    
    var nickname: some View {
        Text(player.nickname)
            .foregroundColor(.white)
            .font(.custom("Roboto", size: 14))
            .lineLimit(1)
            .padding(.top, 16)
    }
    
    var name: some View {
        Text("\(player.firstName.orEmpty) \(player.lastName.orEmpty)")
            .foregroundColor(Color(red: 0.424, green: 0.42, blue: 0.494, opacity: 1))
            .font(.custom("Roboto", size: 12))
            .lineLimit(1)
            .padding(.bottom, 8)
    }
    
    var placeholder: some View {
        RoundedRectangle(cornerRadius: 8)
            .fill(Color(red: 0.769, green: 0.769, blue: 0.769, opacity: 1))
            .frame(width: 48, height: 48)
            .offset(y: -2.5)
            .padding(imagePadding, 12)
    }
    
    var playerInfo: some View {
        VStack(alignment: horizontalAlignment) {
            nickname
            name
        }
    }
    
    private func playerImage(with url: URL) -> some View {
        AsyncImage(url: url) { image in
            image
                .resizable()
                .scaledToFill()
                .frame(width: 48, height: 48)
                .background(
                    Rectangle()
                        .fill(bgColor)
                )
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .offset(y: -2.5)
                .padding(imagePadding, 12)
        } placeholder: {
            placeholder
        }
    }
}
