import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionUtils {
  static Future<void> _showPermissionSettingsDialog(
      BuildContext context) async {
    final shouldOpenSettings = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Photos Permission Required'),
        content: const Text(
          'Photos permission is required to select images. Please enable it in settings.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Open Settings'),
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
