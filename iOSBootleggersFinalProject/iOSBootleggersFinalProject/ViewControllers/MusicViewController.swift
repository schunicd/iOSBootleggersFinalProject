//
//  MusicViewController.swift
//  iOSBootleggersFinalProject
//
//  Class used to control the behaviour of the music view controller

import UIKit
//import necessary to use Apple Music's api
import MediaPlayer

class MusicViewController : UIViewController {
    
    //variable to hold the reference to the music player controller
    var musicPlayer: MPMusicPlayerApplicationController?
    //reference to the button to skip song
    @IBOutlet var nextButton: UIButton!
    //button to go to previous song
    @IBOutlet var prevButton: UIButton!
    //simple label to show the name of the song
    @IBOutlet var songLabel: UILabel!
    //simple label to show the name of the artist
    @IBOutlet var artistLabel: UILabel!
    //uiimageview to show the album cover fetched from apple music
    @IBOutlet var albumCover: UIImageView!
    //button to allow the user to play/pause the song
    @IBOutlet var playPausebutton: UIButton!
    //slider to change the volume
    @IBOutlet var volumeSlider: UISlider!
    //boolean variable to allow checking if there is aything playing
    var isPlaying: Bool = false
    
    //action called when the user taps the play/pause button
    @IBAction func playPause(){
        //if it is currently playing...
        if musicPlayer?.playbackState == MPMusicPlaybackState.playing {
            //stop the music
            musicPlayer?.stop()
            //change the image of the button to a play button
            playPausebutton.setImage(UIImage(systemName: "play.fill"), for: .normal)
        }
        //if it is not currently playing...
        else {
            //start playing from where it was stopped before, or if it is the first time
            //the app is loading, from the first song on the queue
            musicPlayer?.play()
            //change the image of the button to a pause image
            playPausebutton.setImage(UIImage(systemName: "pause.fill"), for: .normal)
            //update the artist name and song labels, and update the album cover
            songLabel.text = musicPlayer?.nowPlayingItem?.title
            artistLabel.text = musicPlayer?.nowPlayingItem?.albumArtist
            albumCover.image = musicPlayer?.nowPlayingItem?.artwork?.image(at: CGSize(width: 339, height: 339))
        }
    }
    
    //action for the slider to change volume
    @IBAction func volumeChanged(sender: UISlider){
        setVolume(sender.value)
    }
    
    //method that changes the volume of the device
    func setVolume(_ volume: Float) {
        //create a volume view so that it can show in the left corner of the app
        let volumeView = MPVolumeView()
        let slider = volumeView.subviews.first(where: { $0 is UISlider }) as? UISlider

        //dispatch queue to change volume concurrently in the app's threads according to the volume
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.01) {
            slider?.value = volume
        }
    }
    
    //action to skip to the next song
    @IBAction func nextSong(){
        //calls the music controller to skip song
        musicPlayer!.skipToNextItem()
        //update the artist name and song labels and the artcover
        songLabel.text = musicPlayer?.nowPlayingItem?.title
        artistLabel.text = musicPlayer?.nowPlayingItem?.albumArtist
        albumCover.image = musicPlayer?.nowPlayingItem?.artwork?.image(at: CGSize(width: 339, height: 339))
    }
    
    //action to go back a song
    @IBAction func prevSong(){
        //calls the music controller to go back one song
        musicPlayer!.skipToPreviousItem()
        //update the artist name and song labels and the artcover
        songLabel.text = musicPlayer?.nowPlayingItem?.title
        artistLabel.text = musicPlayer?.nowPlayingItem?.albumArtist
        albumCover.image = musicPlayer?.nowPlayingItem?.artwork?.image(at: CGSize(width: 339, height: 339))
    }
    
    override func viewDidLoad() {
        //get a reference to the appdelegate
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        //get a reference to the musicplayer from the app delegate
        musicPlayer = appDelegate.musicPlayer
    
        //if there is nothing playing update the labels and artwork image accordingly
        if musicPlayer?.playbackState == MPMusicPlaybackState.paused || musicPlayer?.playbackState == MPMusicPlaybackState.stopped {
            artistLabel.text = "Artist"
            songLabel.text = "Song name"
            playPausebutton.setImage(UIImage(systemName: "play.fill"), for: .normal)
        }
        //if there is something playing show the artist name, song name and album artwork
        else {
            songLabel.text = musicPlayer?.nowPlayingItem?.title
            artistLabel.text = musicPlayer?.nowPlayingItem?.albumArtist
            albumCover.image = musicPlayer?.nowPlayingItem?.artwork?.image(at: CGSize(width: 339, height: 339))
            playPausebutton.setImage(UIImage(systemName: "pause.fill"), for: .normal)
        }
    }
}
