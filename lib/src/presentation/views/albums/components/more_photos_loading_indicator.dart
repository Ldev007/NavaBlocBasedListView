import 'package:flutter/cupertino.dart';

class MorePhotosLoadingIndicator extends StatelessWidget {
  const MorePhotosLoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.25,
      height: double.infinity,
      child: const Center(child: CupertinoActivityIndicator()),
    );
  }
}
