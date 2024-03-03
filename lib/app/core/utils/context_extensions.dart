import 'package:tracking/app/core/widgets/alert_dialog.dart';
import 'package:tracking/app/resources/assets_manager.dart';
import 'package:tracking/app/resources/strings_manager.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

extension ContextExtension on BuildContext {
  Future<void> openBrowser(String url) async {
    try {
      final uri = Uri.parse(url);
      if (await canLaunchUrl(uri)) {
        launchUrl(
          mode: LaunchMode.externalApplication,
          uri,
        );
      }
    } catch (e) {
      alertDialog(
        context: this,
        image: SvgManager.infoWarning,
        message: "${LocaleKeys.canNotOpenBrowser.tr()} $e",
        onConfirm: () {},
      );
    }
  }
}
