import 'package:flutter/cupertino.dart';

class MoreAlbumsLoadingIndicator extends StatelessWidget {
  const MoreAlbumsLoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.2,
      child: const Center(child: CupertinoActivityIndicator()),
    );
  }
}
