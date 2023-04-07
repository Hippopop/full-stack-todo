import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
      child: MouseRegion(
        onHover: (PointerHoverEvent event) {
          // print(event.toString());//Local offset
          // print(event.distanceMin);//0.0
          // print(event.distanceMax);//0.0
          // print(event.distance);//0.0
          // print(event.delta);//distanceMoved
          // print(event.localDelta);//DistanceMoved based on the whole screen
          // print(event.orientation);//0.0
          // print(event.original);//GlobalOffset ig.
          // print(event.)
        },
        child: SafeArea(
          child: Column(
            children: [
              TODOScreenAppBar(colorTheme: colorTheme),
              Expanded(
                child: Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(
                      left: 32, right: 32, top: 16, bottom: 40),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: colorTheme?.white,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: MenuTheme(
                    data: MenuThemeData(
                      style: MenuStyle(
                        elevation: MaterialStateProperty.resolveWith(
                          (states) {
                            print(states.toString());
                            if (states.contains(MaterialState.focused))
                              return 8;
                          },
                        ),
                      ),
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                          width: double.infinity,
                          height: 75,
                          child: Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color:
                                  colorTheme?.backgroundColor.withOpacity(0.3),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Row(
                              children: const [
                                Spacer(),
                                DropdownMenu(
                                  selectedTrailingIcon:
                                      Icon(Icons.check_circle_outline),
                                  enableFilter: false,
                                  initialSelection: 'All',
                                  hintText: 'Filter',
                                  menuStyle: MenuStyle(),
                                  leadingIcon: Icon(
                                    Icons.search,
                                  ),

                                  // inputDecorationTheme: InputDecorationTheme(
                                  // border: OutlineInputBorder(),
                                  // ),
                                  dropdownMenuEntries: [
                                    DropdownMenuEntry(
                                      value: 'All',
                                      label: 'All',
                                    ),
                                    DropdownMenuEntry(
                                      value: 'Completed',
                                      label: 'Completed',
                                    ),
                                    DropdownMenuEntry(
                                      value: 'Left',
                                      label: 'Left',
                                    ),
                                  ],
                                ),
                                /* MenuBar(
                                  children: [
                                    Icon(Icons.abc),
                                    Icon(Icons.access_alarm),
                                    Icon(Icons.abc),
                                    Icon(Icons.access_alarm),
                                  ],
                                  style: MenuStyle(),
                                ), */
                                MenuAnchor(menuChildren: [
                                  Icon(Icons.abc),
                                  Icon(Icons.access_alarm),
                                  Icon(Icons.abc),
                                  Icon(Icons.access_alarm),
                                ]),
                                /* DropdownButtonHideUnderline(
                                  child: DropdownButton(
                                    items: ["All", "Selected", "Done"]
                                        .map(
                                          (e) => DropdownMenuItem(
                                            value: e,
                                            child: Text(
                                              e,
                                            ),
                                          ),
                                        )
                                        .toList(),
                                    value: 'All',
                                    selectedItemBuilder: (context) =>
                                        List.generate(
                                      3,
                                      (index) => Container(color: Colors.white),
                                    ),
                                    onChanged: (value) {},
                                  ),
                                ), */
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AstronautPlaceholder extends StatelessWidget {
  const AstronautPlaceholder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
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
    );
  }
}

class TODOScreenAppBar extends StatelessWidget {
  const TODOScreenAppBar({
    super.key,
    required this.colorTheme,
  });

  final ColorsTheme? colorTheme;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
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
