from kivymd.app import MDApp
from kivy.uix.boxlayout import BoxLayout
from kivy.properties import StringProperty
from kivy.clock import Clock
from threading import Thread
from plyer import filechooser
import librosa
import numpy as np
from kivy.core.audio import SoundLoader

class MusicPlayer(BoxLayout):
    song_name = StringProperty("No song selected")
    mood = StringProperty("")
    genre = StringProperty("")
    recommendations = StringProperty("")
    sound = None

    def select_song(self):
        self.ids.spinner.active = True
        filechooser.open_file(filters=["*.mp3", "*.wav"], on_selection=self.handle_selection)

    def handle_selection(self, selection):
        if selection:
            self.song_name = selection[0]
            Thread(target=self.analyze_song, args=(self.song_name,)).start()

    def analyze_song(self, file_path):
        try:
            y, sr = librosa.load(file_path, duration=30)
            tempo, _ = librosa.beat.beat_track(y=y, sr=sr)
            energy = np.mean(librosa.feature.rms(y=y))
            mood = "Energetic" if tempo > 120 and energy > 0.5 else "Sad" if tempo < 80 else "Happy"
            genre = "Electronic/Dance" if tempo > 140 else "Classical/Ambient" if tempo < 100 else "Pop/Rock"
            rec = self.get_recommendations(genre, mood)
            Clock.schedule_once(lambda dt: self.update_ui(mood, genre, rec))
        except Exception as e:
            print(f"Error analyzing song: {e}")
            Clock.schedule_once(lambda dt: self.update_ui("Error", "Error", ""))

    def update_ui(self, mood, genre, rec):
        self.mood = mood
        self.genre = genre
        self.recommendations = rec
        self.ids.spinner.active = False

    def get_recommendations(self, genre, mood):
        rec_dict = {
            ("Pop/Rock", "Happy"): "Song A, Song B",
            ("Electronic/Dance", "Energetic"): "Song C, Song D",
            ("Classical/Ambient", "Sad"): "Song E, Song F",
        }
        return rec_dict.get((genre, mood), "No recommendations")

    def play_song(self):
        if self.song_name != "No song selected":
            if self.sound:
                self.sound.stop()
            self.sound = SoundLoader.load(self.song_name)
            if self.sound:
                self.sound.play()
            else:
                self.song_name = "Error loading audio"

    def pause_song(self):
        if self.sound:
            self.sound.stop()

    def stop_song(self):
        if self.sound:
            self.sound.stop()
            self.sound = None

class MusicPlayerApp(MDApp):
    def build(self):
        self.theme_cls.theme_style = "Light"
        self.theme_cls.primary_palette = "Blue"
        return MusicPlayer()

if __name__ == '__main__':
    MusicPlayerApp().run()