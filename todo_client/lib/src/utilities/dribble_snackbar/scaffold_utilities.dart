import 'package:flutter/material.dart';

// ignore: non_constant_identifier_names
final _SCAFFOLD_KEY = GlobalKey<ScaffoldMessengerState>();

class ScaffoldUtilities {
  ScaffoldUtilities._();
  static final ScaffoldUtilities _factory = ScaffoldUtilities._();
  static ScaffoldUtilities instance = _factory;

  GlobalKey<ScaffoldMessengerState> get key => _SCAFFOLD_KEY;

  static showToast({required Widget widget, int? secDuration}) {
    _SCAFFOLD_KEY.currentState?.showSnackBar(
      SnackBar(
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        duration: Duration(seconds: secDuration ?? 3),
        padding: EdgeInsets.zero,
        content: Align(
          alignment: Alignment.bottomCenter,
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: 940,
            ),
            child: widget,
          ),
        ),
      ),
    );
  }

  static hideToast() {
    _SCAFFOLD_KEY.currentState?.hideCurrentSnackBar();
  }
}

showToastError(String desc, [String? status, IconData? icon]) {
  ScaffoldUtilities.showToast(
    widget: RedSnackBarWidget(
      descriptionText: desc,
      status: status,
      icon: icon,
    ),
  );
}

showToastInfo(String desc, [String? status, IconData? icon]) {
  ScaffoldUtilities.showToast(
    widget: BlueSnackBarWidget(
      descriptionText: desc,
      status: status,
      icon: icon,
    ),
  );
}

showToastWarning(String desc, [String? status, IconData? icon]) {
  ScaffoldUtilities.showToast(
    widget: YellowSnackBarWidget(
      descriptionText: desc,
      status: status,
      icon: icon,
    ),
  );
}

showToastSuccess(String desc, [String? status, IconData? icon]) {
  ScaffoldUtilities.showToast(
    widget: GreenSnackBarWidget(
      descriptionText: desc,
      status: status,
      icon: icon,
    ),
  );
}

class GreenSnackBarWidget extends StatelessWidget {
  const GreenSnackBarWidget({
    Key? key,
    required this.descriptionText,
    this.status,
    this.icon,
  }) : super(key: key);

  final String descriptionText;
  final String? status;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    final bg = Colors.greenAccent.shade100;
    const border = Colors.green;
    final iconBg = Colors.greenAccent.shade400;
    const baseIcon = Icons.warning;
    const baseTitle = 'Congratulations!';

    return Container(
      margin: const EdgeInsets.only(left: 12, right: 12, bottom: 24),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 0),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: border,
        ),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: iconBg,
              ),
              padding: const EdgeInsets.all(10),
              child: Icon(
                icon ?? baseIcon,
                color: Colors.white,
                size: 20,
              ),
            ),
          ),
          const SizedBox(width: 5),
          Expanded(
            flex: 7,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  status ?? baseTitle,
                  style: const TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 16,
                    height: 1,
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 5.0),
                Text(
                  descriptionText,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade800,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 5),
          Expanded(
            flex: 2,
            child: Center(
              child: InkWell(
                onTap: () => ScaffoldUtilities.hideToast(),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.all(10),
                  child: const Icon(
                    Icons.cancel_outlined,
                    color: Colors.grey,
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

class BlueSnackBarWidget extends StatelessWidget {
  const BlueSnackBarWidget({
    Key? key,
    required this.descriptionText,
    this.status,
    this.icon,
  }) : super(key: key);

  final String descriptionText;
  final String? status;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    final bg = Colors.blue.shade100;
    const border = Colors.blue;
    const iconBg = Colors.blue;
    const baseIcon = Icons.info;
    const baseTitle = 'Wait!';
    return Container(
      margin: const EdgeInsets.only(left: 12, right: 12, bottom: 24),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 0),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: border,
        ),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: iconBg,
              ),
              padding: const EdgeInsets.all(10),
              child: Icon(
                icon ?? baseIcon,
                color: Colors.white,
                size: 20,
              ),
            ),
          ),
          const SizedBox(width: 5),
          Expanded(
            flex: 7,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  status ?? baseTitle,
                  style: const TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 16,
                    height: 1,
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 5.0),
                Text(
                  descriptionText,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade800,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 5),
          Expanded(
            flex: 2,
            child: Center(
              child: InkWell(
                onTap: () => ScaffoldUtilities.hideToast(),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.all(10),
                  child: const Icon(
                    Icons.cancel_outlined,
                    color: Colors.grey,
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

class RedSnackBarWidget extends StatelessWidget {
  const RedSnackBarWidget({
    Key? key,
    required this.descriptionText,
    this.status,
    this.icon,
  }) : super(key: key);

  final String descriptionText;
  final String? status;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    final bg = Colors.red.shade100;
    const border = Colors.red;
    const iconBg = Colors.red;
    const baseIcon = Icons.warning_rounded;
    const baseTitle = 'Error!';
    return Container(
      margin: const EdgeInsets.only(left: 12, right: 12, bottom: 24),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 0),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: border,
        ),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: iconBg,
              ),
              padding: const EdgeInsets.all(10),
              child: Icon(
                icon ?? baseIcon,
                color: Colors.white,
                size: 20,
              ),
            ),
          ),
          const SizedBox(width: 5),
          Expanded(
            flex: 7,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  status ?? baseTitle,
                  style: const TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 16,
                    height: 1,
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 5.0),
                Text(
                  descriptionText,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade800,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 5),
          Expanded(
            flex: 2,
            child: Center(
              child: InkWell(
                onTap: () => ScaffoldUtilities.hideToast(),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.all(10),
                  child: const Icon(
                    Icons.cancel_outlined,
                    color: Colors.grey,
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

class YellowSnackBarWidget extends StatelessWidget {
  const YellowSnackBarWidget({
    Key? key,
    required this.descriptionText,
    this.status,
    this.icon,
  }) : super(key: key);

  final String descriptionText;
  final String? status;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    final bg = Colors.orange.shade100;
    const border = Colors.orange;
    const iconBg = Colors.orange;
    const baseIcon = Icons.warning_rounded;
    const baseTitle = 'Error!';
    return Container(
      margin: const EdgeInsets.only(left: 12, right: 12, bottom: 24),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 0),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: border,
        ),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: iconBg,
              ),
              padding: const EdgeInsets.all(10),
              child: Icon(
                icon ?? baseIcon,
                color: Colors.white,
                size: 20,
              ),
            ),
          ),
          const SizedBox(width: 5),
          Expanded(
            flex: 7,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  status ?? baseTitle,
                  style: const TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 16,
                    height: 1,
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 5.0),
                Text(
                  descriptionText,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade800,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 5),
          Expanded(
            flex: 2,
            child: Center(
              child: InkWell(
                onTap: () => ScaffoldUtilities.hideToast(),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.all(10),
                  child: const Icon(
                    Icons.cancel_outlined,
                    color: Colors.grey,
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
