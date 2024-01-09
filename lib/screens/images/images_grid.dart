import 'package:flutter/material.dart';

class ImagesGrid extends StatelessWidget {
  final List<String>? images;
  final String? image;
  final ValueChanged<int> onTap;

  const ImagesGrid({
    Key? key,
    this.images,
    this.image,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
        ),
        itemCount: images!.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              onTap(index);
            },
            child: Hero(
              tag: images![index],
              child: Image.network(
                images![index],
                fit: BoxFit.cover,
              ),
            ),
          );
        },
      ),
    );
  }
}
