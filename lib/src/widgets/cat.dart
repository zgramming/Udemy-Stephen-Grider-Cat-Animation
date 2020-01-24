import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class Cat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: 'https://i.imgur.com/QwhZRyL.png',
      placeholder: (context, url) => CircularProgressIndicator(),
      errorWidget: (context, url, error) => Icon(Icons.error),
    );
  }
}
