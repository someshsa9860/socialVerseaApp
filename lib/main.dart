import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:provider/provider.dart';
import 'package:videoplayer/providers/api_provider.dart';
import 'package:videoplayer/providers/app_providers.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: getProviders(),
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const MyHomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late ScrollController scrollController;
  VlcPlayerController? vlcPlayerController;

  @override
  void initState() {
    super.initState();

    var of = Provider.of<ApiProvider>(context, listen: false);
    of.init();
    scrollController = ScrollController();
    // scrollController.addListener(of.init);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Task 1"),
        ),
        body: Consumer<ApiProvider>(builder: (context, data, _) {
          if (data.loading && data.list.isEmpty) {
            return const Loader();
          }

          if (data.list.isEmpty) {
            return const Center(
              child: Text("No data available"),
            );
          }

          return Column(
            children: [
              Expanded(
                child: NotificationListener<ScrollUpdateNotification>(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: ListView.separated(
                      controller: scrollController,
                      itemBuilder: (BuildContext context, int index) {
                        final e = data.list[index];
                        print("index:$index,getCurrentItem:$getCurrentItem");
                        return InkWell(
                          onTap: () {
                            if (e.videoLink == null) return;
                            data.currentIndex=-1;
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (ctx) => VideoView(
                                url: e.videoLink.toString(),
                                options: VlcPlayerOptions(),
                                vlcPlayerController: vlcPlayerController,
                              ),
                            ));
                          },
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width / 3,
                                height: 256,
                                child: ((data.currentIndex != index) &&
                                            (e.videoLink != null))

                                    ? Image.network(
                                        e.thumbnailUrl.toString(),
                                        height: 256,
                                        errorBuilder: (ctx, e, s) {
                                          return const Center(
                                              child:
                                                  Text("Image does not exist"));
                                        },
                                        width:
                                            MediaQuery.of(context).size.width /
                                                3,
                                      )
                                    : VideoView(
                                        url: e.videoLink.toString(),
                                        vlcPlayerController:
                                            vlcPlayerController,
                                      ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8.0),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                2,
                                        child: Text(
                                          '${e.firstName} ${e.lastName ?? ''}',
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              fontWeight: FontWeight.w700,
                                              fontSize: 16),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 100,
                                        width:
                                            MediaQuery.of(context).size.width /
                                                2,
                                        child: Text(
                                          '${e.title}',
                                          maxLines: 5,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              color: Colors.black
                                                  .withOpacity(0.5)),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 100,
                                      ),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                2,
                                        child: Text(
                                          '${e.category?.name}',
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black
                                                  .withOpacity(0.8)),
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 8.0),
                                            child: Row(
                                              children: [
                                                Icon(
                                                  Icons.thumb_up,
                                                  size: 20,
                                                  color: Colors.black
                                                      .withOpacity(0.5),
                                                ),
                                                Text(
                                                  ': ${e.upvoteCount}',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w300,
                                                      color: Colors.black
                                                          .withOpacity(0.5)),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                3,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 8.0),
                                            child: Row(
                                              children: [
                                                Icon(
                                                  Icons.comment,
                                                  size: 20,
                                                  color: Colors.black
                                                      .withOpacity(0.5),
                                                ),
                                                Text(
                                                  ': ${e.commentCount}',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w300,
                                                      color: Colors.black
                                                          .withOpacity(0.5)),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        );
                      },
                      itemCount: data.list.length,
                      separatorBuilder: (BuildContext context, int index) {
                        return Divider();
                      },
                    ),
                  ),
                  onNotification: (v) {
                    data.currentIndex = getCurrentItem;
                    print(
                        "bool:${v.metrics.maxScrollExtent == v.metrics.pixels}");
                    print("max:${v.metrics.maxScrollExtent}");
                    print("pix:${v.metrics.pixels}");
                    print("pos:$getCurrentItem");
                    print("len:${data.list.length}");
                    if (v.metrics.pixels >=
                        max((v.metrics.maxScrollExtent - 5 * 256),
                            v.metrics.maxScrollExtent)) {
                      data.init();
                    }
                    return false;
                  },
                ),
              ),
              if (data.loading && data.lastItemsCount > 0) const Loader()
            ],
          );
        }));
  }

  int get getCurrentItem =>
      ((scrollController.position.pixels) / (256 + 32)).round();
}

class VideoView extends StatefulWidget {
  final String url;
  final VlcPlayerOptions? options;
  VlcPlayerController? vlcPlayerController;
  final bool play;

  VideoView(
      {Key? key,
      required this.url,
      this.vlcPlayerController,
      this.play = false, this.options})
      : super(key: key);

  @override
  State<VideoView> createState() => _VideoViewState();
}

class _VideoViewState extends State<VideoView> {
  @override
  void initState() {
    init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.play
        ? WillPopScope(
            onWillPop: () async {
              Provider.of<ApiProvider>(context, listen: false).play = false;
              return true;
            },
            child: Scaffold(
              body: show(),
            ),
          )
        : show();
  }

  Widget show() {
    return widget.vlcPlayerController == null
        ? const Center(
            child: Loader(),
          )
        : VlcPlayer(
            controller: widget.vlcPlayerController!, aspectRatio: 9 / 16);
  }

  @override
  void dispose() {
    disposeVlc();
    super.dispose();
  }

  disposeVlc() async {
    await widget.vlcPlayerController!.stopRendererScanning();
    await widget.vlcPlayerController!.dispose();
    widget.vlcPlayerController = null;
  }

  init() async {
    if (widget.vlcPlayerController != null) {
      await disposeVlc();
    }
    widget.vlcPlayerController = VlcPlayerController.network(widget.url,
        hwAcc: HwAcc.full, autoPlay: true, options:widget.options??VlcPlayerOptions());
  }
}

class Loader extends StatelessWidget {
  const Loader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SizedBox(
          width: 48,
          height: 48,
          child: LoadingIndicator(indicatorType: Indicator.ballSpinFadeLoader)),
    );
  }
}
