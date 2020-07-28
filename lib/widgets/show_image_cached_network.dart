import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ShowImageCachedNetwork extends StatelessWidget {
  String _image = '';

  ShowImageCachedNetwork(this._image);

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: CachedNetworkImage(
        imageUrl: _image,
        placeholder: (context, url) => Container(
          height: 80,
          width: 80,
          child: Center(
            child: CircularProgressIndicator(),
          ),
        ),
        errorWidget: (context, url, error) => Center(
          child: Icon(Icons.error),
        ),
      ),
    );
  }
}
