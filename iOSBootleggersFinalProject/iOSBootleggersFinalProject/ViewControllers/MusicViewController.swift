//
//  MusicViewController.swift
//  iOSBootleggersFinalProject
//
//  Created by Lucas Zanlorensi on 2021-04-17.
//

import UIKit
import MediaPlayer

class MusicViewController : UIViewController {
    
    var musicPlayer: MPMusicPlayerApplicationController?
    @IBOutlet var nextButton: UIButton!
    @IBOutlet var prevButton: UIButton!
    @IBOutlet var songLabel: UILabel!
    @IBOutlet var artistLabel: UILabel!
    @IBOutlet var albumCover: UIImageView!
    @IBOutlet var playPausebutton: UIButton!
    @IBOutlet var volumeSlider: UISlider!
    var isPlaying: Bool = false
    
    @IBAction func playPause(){
        if musicPlayer?.playbackState == MPMusicPlaybackState.playing {
            musicPlayer?.stop()
            playPausebutton.setImage(UIImage(systemName: "play.fill"), for: .normal)
        }
        else {
            musicPlayer?.play()
            playPausebutton.setImage(UIImage(systemName: "pause.fill"), for: .normal)
            songLabel.text = musicPlayer?.nowPlayingItem?.title
            artistLabel.text = musicPlayer?.nowPlayingItem?.albumArtist
            albumCover.image = musicPlayer?.nowPlayingItem?.artwork?.image(at: CGSize(width: 339, height: 339))
        }
    }
    
    @IBAction func volumeChanged(sender: UISlider){
        setVolume(sender.value)
    }
    
    func setVolume(_ volume: Float) {
            let volumeView = MPVolumeView()
            let slider = volumeView.subviews.first(where: { $0 is UISlider }) as? UISlider

            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.01) {
                slider?.value = volume
            }
        }
    
    @IBAction func nextSong(){
        musicPlayer!.skipToNextItem()
        songLabel.text = musicPlayer?.nowPlayingItem?.title
        artistLabel.text = musicPlayer?.nowPlayingItem?.albumArtist
        albumCover.image = musicPlayer?.nowPlayingItem?.artwork?.image(at: CGSize(width: 339, height: 339))
    }
    
    @IBAction func prevSong(){
        musicPlayer!.skipToPreviousItem()
        songLabel.text = musicPlayer?.nowPlayingItem?.title
        artistLabel.text = musicPlayer?.nowPlayingItem?.albumArtist
        albumCover.image = musicPlayer?.nowPlayingItem?.artwork?.image(at: CGSize(width: 339, height: 339))
    }
    
    override func viewDidLoad() {

        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        musicPlayer = appDelegate.musicPlayer
    
        if musicPlayer?.playbackState == MPMusicPlaybackState.paused || musicPlayer?.playbackState == MPMusicPlaybackState.stopped {
            artistLabel.text = "Artist"
            songLabel.text = "Song name"
            playPausebutton.setImage(UIImage(systemName: "play.fill"), for: .normal)
        }
        else {
            songLabel.text = musicPlayer?.nowPlayingItem?.title
            artistLabel.text = musicPlayer?.nowPlayingItem?.albumArtist
            albumCover.image = musicPlayer?.nowPlayingItem?.artwork?.image(at: CGSize(width: 339, height: 339))
            playPausebutton.setImage(UIImage(systemName: "pause.fill"), for: .normal)
        }
    }
}
