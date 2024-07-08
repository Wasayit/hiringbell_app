import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_sound_record/flutter_sound_record.dart';
import 'package:get/get.dart';
import 'package:hiringbell/models/constants.dart';
import 'package:hiringbell/pages/comments/model/message_type.dart';
import 'package:hiringbell/pages/comments/model/request_message.dart';
import 'package:hiringbell/services/http_service.dart';
import 'package:hiringbell/utilities/Util.dart';
import 'package:jiffy/jiffy.dart';
import 'package:just_audio/just_audio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:stomp_dart_client/stomp_dart_client.dart';

class ChatStreamService extends GetxService {
  bool _isConnected = false;
  late String wsBaseUrl;
  StompClient? client;
  dynamic channelSubscription;
  late HttpService httpService;
  var chatMessage = RxList<RequestMessage>([]).obs;
  final ScrollController scrollController = ScrollController();
  final TextEditingController messageController = TextEditingController();
  var user = Util.getInstance().getUserDetail();

  var isRecordPlaying = false.obs;
  var isRecording = false.obs;
  Util util = Util.getInstance();
  var isLoading = false.obs;
  int counter = 0;

  FlutterSoundRecord? recorder;
  String recordedFilePath = "";
  Timer? timer;
  Timer? ampTimer;
  Amplitude? amplitude;
  int recordDuration = 0;
  var fileDuration = "00:00".obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    httpService = HttpService.getInstance();
    wsBaseUrl = httpService.getBaseUrl;
    ever(chatMessage.value, (_) {
      _scrollBottom();
    });

    connect();
  }

  void cleanChat() {
    chatMessage = RxList<RequestMessage>([]).obs;
    // unSubscribe();
  }

  void disconnect() {
    client?.deactivate();
    client = null;
  }

  void connect() {
    var address = wsBaseUrl.replaceAll("https", "wss").replaceAll("http", "ws");
    client = StompClient(
        config: StompConfig(
            url: '${address}chat',
            stompConnectHeaders: {
              'Authorization': 'Bearer ${httpService.token}'
            },
            webSocketConnectHeaders: {
              'Authorization': 'Bearer ${httpService.token}'
            },
            onConnect: onConnectCallback,
            onWebSocketError: (data) {
              debugPrint("Error: $data");
            }));

    client?.activate();
  }

  void onConnectCallback(StompFrame frame) {
    if (frame.command == "CONNECTED") {
      debugPrint("------------------------Connected----------------------------------");
      _isConnected = true;
      client?.subscribe(
        destination: "/user/istiyaq.mi9_gmail/queue/messages",
        callback: (StompFrame frame) {
          if (frame.body != null) {
            final body = json.decode(frame.body!);
            chatMessage.value.add(
              RequestMessage(
                  content: body["content"].toString(),
                  type: MessageType.text,
                  chatId: body["groupId"].toString(),
                  senderId: body["senderId"].toString(),
                  recipientId: body["recipientId"].toString(),
                  timestamp:
                      Jiffy.parse(body["timestamp"].toString()).dateTime),
            );
          }
        },
      );
    } else {
      debugPrint("Fail to connected");
    }
  }

  void sendTextMessage() {
    DateTime timestamp = DateTime.now();
    var body = {
      'content': messageController.text,
      'type': 2,
      'chatId': 'istiyaq.mi9_gmail',
      'senderId': 'istiyaq.mi9_gmail',
      'recipientId': 'istiyaq.mi9_gmail',
      'timestamp': '2024-06-29'
    };

    if (_isConnected) {
      client?.send(
        destination: "/app/chat",
        body: json.encode(body),
      );

      chatMessage.value.add(
        RequestMessage(
            content: body["content"].toString(),
            type: MessageType.text,
            chatId: body["groupId"].toString(),
            senderId: body["senderId"].toString(),
            recipientId: body["recipientId"].toString(),
            timestamp: Jiffy.parse(body["timestamp"].toString()).dateTime),
      );

      messageController.text = "";
    } else {
      debugPrint('WebSocket is not connected.');
    }
  }

  void subscribePostComments(String groupChatId, String userId) {
    if (_isConnected) {
      debugPrint("Subscribed to post: $groupChatId");
      client?.subscribe(
        destination: "/user/$groupChatId/queue/messages",
        callback: (StompFrame frame) {
          if (frame.body != null) {
            final body = json.decode(frame.body!);
            if (body["senderId"] != userId) {
              chatMessage.value.add(
                RequestMessage(
                    content: body["content"],
                    type: RequestMessage.getMessageType(body["type"]),
                    chatId: body["chatId"],
                    senderId: body["senderId"],
                    recipientId: body["recipientId"],
                    timestamp: DateTime.parse(body["timestamp"]),
                ),
              );
            }
          }
        },
      );
    } else {
      debugPrint("Fail to connected");
    }
  }

  void unSubscribe() {
    channelSubscription(unsubscribeHeaders: {});
  }

  void send(
      String groupId, String senderId, String recipientId, bool isGroupChat) {
    if (isGroupChat) {
      postOnGroup(groupId, senderId, recipientId);
    } else {
      sendTextMessage();
    }
  }

  void postOnGroup(String groupId, String senderId, String recipientId) {
    var timestamp = Jiffy.parseFromDateTime(DateTime.now()).format(pattern: "yyyy-MM-dd HH:mm:ss");
    var body = {
      'content': messageController.text,
      'type': 2,
      'chatId': groupId,
      'senderId': senderId,
      'recipientId': recipientId,
      'timestamp': timestamp
    };

    if (_isConnected) {
      client?.send(
        destination: "/app/comment",
        body: json.encode(body),
      );

      chatMessage.value.add(
        RequestMessage(
          content: messageController.text,
          type: MessageType.text,
          chatId: groupId,
          senderId: senderId,
          recipientId: recipientId,
          timestamp: Jiffy.parse(timestamp).dateTime,
        ),
      );

      messageController.text = "";
    } else {
      debugPrint('WebSocket is not connected.');
    }
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
  }

  Future<void> loadComments(String groupId) async {
    var result = await httpService
        .httpGet("chat/messages/getMessagesByGroupId/$groupId");
    if (result != null) {
      for (var body in result) {
        chatMessage.value.add(
          RequestMessage(
            content: body["content"].toString(),
            type: MessageType.text,
            chatId: body["groupId"].toString(),
            senderId: body["senderId"].toString(),
            recipientId: body["recipientId"].toString(),
            timestamp: DateTime.parse(body["timestamp"]),
          ),
        );
      }
    }
  }
}
