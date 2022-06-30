import 'package:deliveryherochallenge/_.dart';
import 'package:deliveryherochallenge/core/bindings/start_binding.dart';
import 'package:deliveryherochallenge/pages/search_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: StartBinding(),
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SearchPage(),
    );
  }
}
