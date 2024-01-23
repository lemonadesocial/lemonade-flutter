import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class ScannerActions extends StatelessWidget {
  final MobileScannerController controller;

  const ScannerActions({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ValueListenableBuilder<TorchState>(
              valueListenable: controller.torchState,
              builder: (context, value, child) {
                final Color iconColor;
                switch (value) {
                  case TorchState.off:
                    iconColor = Colors.white;
                    break;
                  case TorchState.on:
                    iconColor = Colors.yellow;
                    break;
                }
                return IconButton(
                  onPressed: () => controller.toggleTorch(),
                  icon: Icon(
                    Icons.flashlight_on,
                    color: iconColor,
                  ),
                );
              },
            ),
            IconButton(
              onPressed: () => controller.switchCamera(),
              icon: const Icon(
                Icons.cameraswitch_rounded,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
