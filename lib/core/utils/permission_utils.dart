import 'package:app/i18n/i18n.g.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionUtils {
  static Future<void> _showPermissionSettingsDialog(
    BuildContext context,
  ) async {
    final t = Translations.of(context);
    final shouldOpenSettings = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(t.common.permissions.photos.alertTitle),
        content: Text(t.common.permissions.photos.alertContent),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(t.common.actions.cancel),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text(t.common.actions.openSettings),
          ),
        ],
      ),
    );

    if (shouldOpenSettings == true) {
      await openAppSettings();
    }
  }

  static Future<bool> checkPhotosPermission(BuildContext context) async {
    try {
      final status = await Permission.photos.status;
      if (status.isGranted || status.isLimited) {
        return true;
      }

      if (!status.isPermanentlyDenied) {
        final result = await Permission.photos.request();
        if (result.isGranted || result.isLimited) {
          return true;
        }
      }

      if (status.isPermanentlyDenied) {
        await _showPermissionSettingsDialog(context);
      }

      return false;
    } catch (e) {
      debugPrint('Error checking photos permission: $e');
      return false;
    }
  }
}
