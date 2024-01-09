import 'package:flutter/material.dart';

class ImageDetail extends StatefulWidget {
  final String? breed;
  final String? subBreed;
  final int initialIndex;
  final List<String> images;

  const ImageDetail({
    super.key,
    this.breed,
    this.subBreed,
    required this.initialIndex,
    required this.images,
  });

  @override
  State<ImageDetail> createState() => _ImageDetailState();
}

class _ImageDetailState extends State<ImageDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.subBreed != null
              ? '${widget.breed} ${widget.subBreed} Doggo'
              : widget.breed != null
                  ? '${widget.breed} Doggo'
                  : 'Random Doggo',
        ),
      ),
      body: PageView.builder(
        itemCount: widget.images.length,
        controller: PageController(initialPage: widget.initialIndex),
        itemBuilder: (context, index) {
          return Hero(
            tag: widget.images[index],
            child: Image.network(
              widget.images[index],
              fit: BoxFit.scaleDown,
            ),
          );
        },
      ),
    );
  }
}
