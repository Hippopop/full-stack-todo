import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:todo_client/src/constants/design/paddings.dart';
import 'package:todo_client/src/system/themes/extensions/colors_theme.dart';

class ImageAvatarWithButton extends StatelessWidget {
  const ImageAvatarWithButton({
    super.key,
    this.filePath,
    this.networkPath,
    required this.assetPath,
    required this.onAddClick,
  });

  final List<int>? filePath;
  final String assetPath;
  final String? networkPath;
  final VoidCallback onAddClick;

  @override
  Widget build(BuildContext context) {
    final ImageProvider foregroundImage = switch (filePath) {
      List<int>() => MemoryImage(Uint8List.fromList(filePath!)),
      _ => AssetImage(assetPath),
    } as ImageProvider;
    final ImageProvider backgroundImage = switch (networkPath) {
      String() => NetworkImage(
          networkPath!,
        ),
      _ => AssetImage(assetPath),
    } as ImageProvider;

    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.bottomCenter,
      children: [
        DecoratedBox(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: context.color.borderGreyColor,
          ),
          child: Padding(
            padding: all3,
            child: CircleAvatar(
              minRadius: 32,
              maxRadius: 72,
              backgroundColor: Colors.white,
              foregroundImage: foregroundImage,
              backgroundImage: backgroundImage,
            ),
          ),
        ),
        Positioned(
          bottom: -18,
          child: DecoratedBox(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: context.color.primaryAccent,
            ),
            child: IconButton(
              icon: const Icon(Icons.add),
              visualDensity: VisualDensity.compact,
              onPressed: onAddClick,
            ),
          ),
        ),
      ],
    );
  }
}
