import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_sound_record/flutter_sound_record.dart';
import 'package:get/get.dart';
import 'package:hiringbell/models/constants.dart';
import 'package:hiringbell/models/user.dart';
import 'package:hiringbell/pages/common/realtime_communication/chat_stream_service.dart';
import 'package:hiringbell/services/http_service.dart';
import 'package:hiringbell/utilities/Util.dart';
import 'package:just_audio/just_audio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import 'model/message_type.dart';

class CommentsController extends GetxController {
  int postId = Get.arguments as int;
  HttpService httpService = HttpService.getInstance();
  Util util = Util.getInstance();
  User? user;
  var isLoading = false.obs;
  var isRecordPlaying = false.obs;
  final ScrollController scrollController = ScrollController();
  int counter = 0;

  var isRecording = false.obs;
  FlutterSoundRecord? recorder;
  String recordedFilePath = "";
  Timer? timer;
  Timer? ampTimer;
  Amplitude? amplitude;
  int recordDuration = 0;
  var fileDuration = "00:00".obs;
  String commentChatId = Constants.empty;

  final TextEditingController messageController = TextEditingController();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    user = util.getUserDetail();
    initRecorder();
  }

  Future<String> getTemporaryDirPath() async {
    Directory tempDir = await getTemporaryDirectory();
    return tempDir.path;
  }

  Future<void> stopRecording() async {
    debugPrint("Stop recording...");
    isRecording.value = false;
    await recorder!.stop();
    isRecording.value = false;
    sendAudioMessage();
  }

  Future playRecording() async {
    isRecordPlaying.value = true;
    final player = AudioPlayer();
    await player.setVolume(1);
    Duration? duration = await player.setUrl(recordedFilePath);
    fileDuration.value = "${duration!.inMinutes}:${duration.inMinutes}";
    await player.play();
    isRecordPlaying.value = false;
  }

  void startTimer() {
    timer?.cancel();
    ampTimer?.cancel();

    timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
      recordDuration++;
    });

    ampTimer =
        Timer.periodic(const Duration(milliseconds: 200), (Timer t) async {
      amplitude = await recorder!.getAmplitude();
    });
  }

  Future<void> startRecording() async {
    debugPrint("Start recording...");
    isRecording.value = true;

    var tempPath = await getTemporaryDirPath();
    recordedFilePath = "$tempPath/${DateTime.now().microsecondsSinceEpoch}.aac";

    try {
      recorder = FlutterSoundRecord();
      await recorder!.start(
          bitRate: 128000,
          samplingRate: 44100,
          encoder: AudioEncoder.AAC,
          path: recordedFilePath);
    } catch (e) {
      isRecording.value = false;
    }
  }

  Future initRecorder() async {
    final status = await Permission.microphone.request();
    if (status != PermissionStatus.granted) {
      util.showToast("Microphone permission not granted", type: Constants.fail);
    }
  }

  void _scrollBottom() {
    scrollController.animateTo(
      scrollController.position.maxScrollExtent + 60,
      duration: const Duration(microseconds: 300),
      curve: Curves.easeOut,
    );
  }

  Future sendAudioMessage() async {
    if (recordedFilePath.isNotEmpty) {
      /*chatMessage.value.add(RequestMessage(
        message: "Message count: ${++counter}",
        messageType: MessageType.audio,
      ));*/
      util.showToast("Please record or type a message first");
    }

    _scrollBottom();
  }
}
