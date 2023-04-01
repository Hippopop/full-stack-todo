import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../system/themes/extensions/colors_theme.dart';

class AllTodoScreen extends StatelessWidget {
  const AllTodoScreen({super.key});

  // final String profileAvatarString =
  // 'https://img.freepik.com/free-psd/3d-illustration-person-tank-top_23-2149436202.jpg?size=626&ext=jpg&ga=GA1.1.517707850.1679506246&semt=ais';
  // 'https://img.freepik.com/free-vector/3d-cartoon-young-woman-smiling-circle-frame-character-illustration-vector-design_40876-3100.jpg?size=626&ext=jpg&ga=GA1.1.517707850.1679506246&semt=ais';
  // 'https://img.freepik.com/free-psd/3d-illustration-person-with-glasses_23-2149436185.jpg?size=626&ext=jpg&ga=GA1.1.517707850.1679506246&semt=ais';
  // 'https://img.freepik.com/free-photo/fun-3d-illustration-black-referee-with-mask_183364-81233.jpg?size=626&ext=jpg&ga=GA1.1.517707850.1679506246&semt=ais';
  // 'https://img.freepik.com/free-vector/portrait-beautiful-girl-with-tiara-her-head_1196-849.jpg?size=626&ext=jpg&ga=GA1.1.517707850.1679506246&semt=ais';
  @override
  Widget build(BuildContext context) {
    final colorTheme = Theme.of(context).extension<ColorsTheme>();
    return ColoredBox(
      color: colorTheme?.backgroundColor ?? Colors.white70,
      child: Column(
        children: [
          ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: 980,
            ),
            child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: Row(
                children: [
                  DecoratedBox(
                    decoration: BoxDecoration(
                      color: colorTheme?.white,
                      shape: BoxShape.circle,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: CircleAvatar(
                        maxRadius: 32,
                        foregroundImage: const AssetImage(
                          'assets/images/avatar.jpg',
                        ),
                        backgroundColor: colorTheme?.mainAccent,
                      ),
                    ),
                  ),
                  const SizedBox(width: 18),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Hello,',
                          style: context.theme.textTheme.bodyLarge?.copyWith(
                            color: colorTheme?.extraTextColor,
                          ),
                        ),
                        Text(
                          'Mr Candyman.',
                          style: context.theme.textTheme.titleLarge,
                        ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'Thu, 12 March 2022',
                        style: context.theme.textTheme.titleMedium,
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CountWidget(
                            color: colorTheme?.primaryAccent ?? Colors.green,
                            amount: 0,
                          ),
                          CountWidget(
                            color: colorTheme?.mainAccent ?? Colors.yellow,
                            amount: 0,
                          ),
                          CountWidget(
                            color: colorTheme?.secoderyAccent ?? Colors.purple,
                            amount: 0,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Transform.rotate(
              angle: 20,
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxWidth: 640,
                  ),
                  child: Lottie.asset(
                    'assets/lottie/astronaut.json',
                    addRepaintBoundary: true,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CountWidget extends StatelessWidget {
  const CountWidget({
    super.key,
    required this.amount,
    required this.color,
  });

  final int amount;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          DecoratedBox(
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
            child: const Padding(
              padding: EdgeInsets.all(4),
            ),
          ),
          const SizedBox(width: 8),
          Text(
            '$amount',
            style: context.theme.textTheme.bodyLarge?.copyWith(
              height: 1,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}

extension ThemeGetter on BuildContext {
  ThemeData get theme => Theme.of(this);
}
