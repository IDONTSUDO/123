import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

abstract class IAudioPlayerWaveStateState {
  late List<int> bitRate;
}

class AudioMessagePlayerState extends ChangeNotifier
    implements IAudioPlayerWaveStateState {
  AudioMessagePlayerState({required this.bitRate});
  late int width;
  late int height;
  final maxDurationHeight = 120;
  @override
  late List<int> bitRate;
  void bitRateRendering() {
    final List<int> formidabelBitRateRenred = [];
    for (var i = 0; i < bitRate.length; i) {
      formidabelBitRateRenred.add(bitRate[i]);
      i = i + stepQulityLine;
    }
    bitrateRendering = formidabelBitRateRenred;
    notifyListeners();
  }

  void appenedBitRate(List<int> _bitRate) {
    bitRate.addAll(_bitRate);
    notifyListeners();
  }

  List<int> bitrateRendering = [];

  double get maxHeightCooficent => maxDurationHeight / height;
  int get stepQulityLine => bitRate.length ~/ (maxQulityLine);
  int get maxQulityLine => width ~/ 5;
  late PlayerStatus status;
  late Function messageUpdate;
  appenedSetStatus(PlayerStatus _status) {
    status = _status;
    if (status == PlayerStatus.pause) {
      // play logic
    } else if (status == PlayerStatus.play) {
      // stop login
    }
    notifyListeners();
  }

  void init() {
    bitRateRendering();
    print(200);
  }
}

enum PlayerStatus { play, pause, download }

// ignore: must_be_immutable
class AudioPlayerWave extends StatefulWidget {
  AudioPlayerWave({Key? key, required this.model}) : super(key: key);
  AudioMessagePlayerState model;
  @override
  _AudioPlayerWaveState createState() => _AudioPlayerWaveState();
}

class _AudioPlayerWaveState extends State<AudioPlayerWave> {
  final ScrollController scrollController = ScrollController();
  @override
  void initState() {
    widget.model.addListener(_setState);
    WidgetsBinding.instance!.addPostFrameCallback((_) => widget.model.init());

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    scrollController.removeListener(() {});
    widget.model.removeListener(_setState);
  }

  void updateAnimation() {
    scrollController.animateTo(scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 100), curve: Curves.ease);
  }

  void _setState() => setState(() {});

  AudioMessagePlayerState get model => widget.model;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: scrollController,
      scrollDirection: Axis.horizontal,
      child: Container(
        width: widget.model.width.toDouble(),
        height: widget.model.height.toDouble(),
        child: Row(
          // crossAxisAlignment: CrossAxisAlignment.end,
          // mainAxisAlignment: MainAxisAlignment.end,
          children: [
            // GestureDetector(
            //     onTap: () => widget.model.messageUpdate(), child: statusPlayer()),
            // ignore: unnecessary_null_comparison
            if (widget.model.bitRateRendering != null) ...[
              for (var i = 0; i < widget.model.bitrateRendering.length; i)
                // Positioned(
                // left: widget.model.bitrateRendering[i].toDouble(),
                // child:
                Container(
                  margin: const EdgeInsets.only(left: 3),
                  color: Colors.black,
                  width: 2,
                  height: widget.model.bitrateRendering[i].toDouble() /
                      widget.model.maxHeightCooficent,
                )
            ]
          ],
        ),
      ),
    );
  }

  Widget statusPlayer() {
    if (widget.model.status == PlayerStatus.pause) {
      return Container(
        width: 15,
        height: 15,
        color: Colors.yellow,
      );
    } else if (widget.model.status == PlayerStatus.download) {
      return Container(
        width: 15,
        height: 15,
        color: Colors.red,
      );
    } else if (widget.model.status == PlayerStatus.play) {
      return Container(
        width: 15,
        height: 15,
        color: Colors.black,
      );
    }
    return Container(
      width: 15,
      height: 15,
      color: Colors.pink,
    );
  }
}
