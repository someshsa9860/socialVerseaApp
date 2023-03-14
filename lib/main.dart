import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:provider/provider.dart';
import 'package:videoplayer/providers/api_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
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
  @override
  void initState() {
    super.initState();
    Provider.of<ApiProvider>(context, listen: false).init();
  }

  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //   appBar: AppBar(),
    //   body: PaginationView(itemBuilder: (BuildContext c, u, int i) {
    //     return Container(
    //
    //     );
    //   },
    //     pageFetch: (int currentListSize) async{
    //     print(currentListSize);
    //     return [];
    //   },
    //     header: Text("header"),
    //     footer: Text('footer'),
    //
    //     onEmpty: const Center(child: Text('end')), onError: (v) {
    //     return Text(v.toString());
    //   },),
    // );

    return Scaffold(
      appBar: AppBar(title: const Text("Task 1"),),
      body: Consumer<ApiProvider>(
        builder: (context,data,_) {
          if(data.loading) {
            return const Loader();
          }

          if(data.list.isEmpty){
            return const Center(child: Text("No data available"),);
          }

          return ListView(
            children: (data.list.first.posts!.map((e) => Container(

            )).toList())
          );
        }
      ),
    );
  }
}

class Loader extends StatelessWidget {
  const Loader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const LoadingIndicator(indicatorType: Indicator.ballSpinFadeLoader);
  }
}
