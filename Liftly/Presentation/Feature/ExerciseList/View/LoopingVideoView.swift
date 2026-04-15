//
//  LoopingVideoView.swift
//  Liftly
//
//  Created by Natanael Jop on 15/04/2026.
//


import SwiftUI
import AVFoundation

struct LoopingVideoView: UIViewRepresentable {
    let url: URL
    
    func makeUIView(context: Context) -> PlayerView {
        let view = PlayerView()
        
        let player = AVPlayer(url: url)
        player.isMuted = true
        player.actionAtItemEnd = .none
        
        view.playerLayer.player = player
        view.playerLayer.videoGravity = .resizeAspectFill
        
        context.coordinator.player = player
        
        NotificationCenter.default.addObserver(
            forName: .AVPlayerItemDidPlayToEndTime,
            object: player.currentItem,
            queue: .main
        ) { _ in
            player.seek(to: .zero)
            player.play()
        }
        
        player.play()
        
        return view
    }
    
    func updateUIView(_ uiView: PlayerView, context: Context) {
        // nic nie trzeba robić
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator()
    }
    
    class Coordinator {
        var player: AVPlayer?
    }
}

final class PlayerView: UIView {
    override static var layerClass: AnyClass {
        AVPlayerLayer.self
    }
    
    var playerLayer: AVPlayerLayer {
        layer as! AVPlayerLayer
    }
}
