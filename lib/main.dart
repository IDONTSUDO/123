import 'dart:math';

import 'package:app/generated_plugin_registrant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dart:ui' as ui;

import 'audio_wave_record.dart';
import 'sound.dart';

int getRandomBit() {
  final Random random = Random();
  final rand = random.nextInt(120);
  return rand;
}

int getRandomBitrateLenght() {
  final Random random = Random();
  final rand = random.nextInt(1200);
  return rand;
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Scaffold(body: TestttSsss()));
  }
}

class TestttSsss extends StatefulWidget {
  @override
  _TestttSsssState createState() => _TestttSsssState();
}

class _TestttSsssState extends State<TestttSsss> {
  final model = AudioMessagePlayerState(bitRate: []);
  @override
  void initState() {
    super.initState();
    final List<int> listBitrate = [];
    final lenghtBitRate = getRandomBitrateLenght();
    for (var inc = 0; inc != lenghtBitRate; inc++) {
      listBitrate.add(getRandomBit());
    }
    model.appenedBitRate(listBitrate);
    model.width = 150;
    model.height = 16;
    model.status = PlayerStatus.play;
    model.messageUpdate = updateStatus;
  }

  updateStatus() {
    final PlayerStatus status = model.status;
    if (status == PlayerStatus.play) {
      model.appenedSetStatus(PlayerStatus.pause);
    } else if (status == PlayerStatus.pause) {
      model.appenedSetStatus(PlayerStatus.play);
    }
    // ignore: invalid_use_of_visible_for_testing_member
    // ignore: invalid_use_of_protected_member
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        // color: Colors.black,
        // width: model.width.toDouble() + 5,
        // height: model.height.toDouble(),
        child: Row(
      children: [
        AudioPlayerWave(
          model: model,
        ),
      ],
    ));
  }
}
