import '../../_.dart';

class BaseView extends StatefulWidget {
  final Widget Function(BuildContext context, AppController c) builder;
  const BaseView({
    Key? key,
    required this.builder,
  }) : super(key: key);

  @override
  State<BaseView> createState() => _BaseViewState();
}

class _BaseViewState extends State<BaseView> {
  AppController controller = Get.find<AppController>();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context, controller);
  }
}
