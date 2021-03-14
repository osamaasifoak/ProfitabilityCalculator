import 'package:flutter/material.dart';

class NetworkImageComponent extends StatelessWidget {
  final String url;
  final double height, width;
  const NetworkImageComponent(
      {Key key, this.url = "", this.height = 200, this.width = 200})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Image.network(
      url,
      fit: BoxFit.fill,
      height: height,
      width: width,
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) {
          return child;
        } else {
          return SizedBox(
            width: 100,
            height: 100,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircularProgressIndicator(
                    backgroundColor: Colors.green,
                    valueColor: new AlwaysStoppedAnimation<Color>(Colors.blue),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    loadingProgress.expectedTotalBytes != null
                        ? ((loadingProgress.cumulativeBytesLoaded /
                                    loadingProgress.expectedTotalBytes) *
                                100)
                            .toStringAsFixed(0)
                        : "",
                  )
                ],
              ),
            ),
          );
        }
      },
    );
  }
}
