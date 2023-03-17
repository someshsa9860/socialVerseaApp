
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:videoplayer/providers/api_provider.dart';
List<SingleChildWidget> getProviders() {
  return [

    ChangeNotifierProvider(
      create: (ctx) => ApiProvider(),
    ),
  ];
}
