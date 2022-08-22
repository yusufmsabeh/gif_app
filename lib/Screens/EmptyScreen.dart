import 'package:flutter/cupertino.dart';
import 'package:lottie/lottie.dart';

class EmptyScreen extends StatelessWidget {
  const EmptyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Lottie.network(
          "https://assets1.lottiefiles.com/packages/lf20_heejrebm.json"),
    );
  }
}
