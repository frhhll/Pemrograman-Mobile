import 'dart:io';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/services.dart';
import 'package:flutter_media_metadata/flutter_media_metadata.dart';
import 'package:get/get.dart';

class MusicController extends GetxController {
  AudioPlayer audioPlayer = AudioPlayer();
  RxBool isPlaying = false.obs;
  Rx<Duration> audioDuration = Duration.zero.obs;
  Rx<Duration> currentPosition = Duration.zero.obs;
  RxString songName = ''.obs;
  RxString albumName = ''.obs;

  // void initializeAudio() async {
  //  //await audioPlayer.setAsset('assets/musics/christmas_bells.mp3');
  // }

  Future<void> extractMusicInfo() async {
    ByteData assetData =
        await rootBundle.load('assets/musics/phoebebridgers.mp3');
    Directory tempDir = await Directory.systemTemp.createTemp();
    String tempFilePath = '${tempDir.path}/phoebebridgers.mp3';
    await File(tempFilePath).writeAsBytes(assetData.buffer.asUint8List());
    final metaData = MetadataRetriever.fromFile(File(tempFilePath));
    final musicData = await metaData;
    songName.value = musicData.trackName.toString();
    albumName.value = musicData.albumName.toString();
    //print(musicData.albumName);
  }

  Future<void> playMusic() async {
    if (isPlaying.value) {
      audioPlayer.pause();
    } else {
      //audioPlayer.play();
      await audioPlayer.play(
        AssetSource('musics/phoebebridgers.mp3'),
      );
      // await audioPlayer.setSourceUrl('https://example.com/song.mp3');
      // audioPlayer.play(UrlSource('https://example.com/song.mp3'),);
    }
  }

  void back10Sec() {
    final newPosition =
        Duration(seconds: (currentPosition.value.inSeconds - 10).toInt());
    audioPlayer.seek(newPosition);
  }

  void forward10Sec() {
    final newPosition =
        Duration(seconds: (currentPosition.value.inSeconds + 10).toInt());
    audioPlayer.seek(newPosition);
  }

  void stopAndPlayMusic() {
    //audioDuration.value = Duration.zero;
    currentPosition.value = Duration.zero;
    audioPlayer.seek(Duration.zero);
  }

  // void getSongInfo(){
  // }

  void seekAudio(double value) {
    final position = Duration(seconds: value.toInt());
    audioPlayer.seek(position);
  }

  String formatTime(int seconds) {
    return '${(Duration(seconds: seconds))}'.split('.')[0].padLeft(8, '0');
  }

  @override
  void onInit() {
    //initializeAudio();
    extractMusicInfo();

    audioPlayer.onPlayerStateChanged.listen((state) {
      isPlaying.value = state == PlayerState.playing;
    });

    audioPlayer.onDurationChanged.listen((duration) {
      audioDuration.value = duration;
    });

    audioPlayer.onPositionChanged.listen((position) {
      currentPosition.value = position;
    });

    super.onInit();
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }
}

  // Future<void> playMusic() async{
  //   try {
  //    // await audioPlayer.setSourceAsset('musics/christmas_bells.mp3');
  //      await audioPlayer.play(
  //       AssetSource('musics/christmas_bells.mp3'),
  //       );
  //   } catch (error) {
  //     print('Error playing music: $error');
  //   }
  // }
