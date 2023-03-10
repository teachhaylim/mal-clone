import 'package:flutter/material.dart';
import 'package:mal_clone/core/theme/design_system.dart';

class CustomButton {
  static Widget backButton({VoidCallback? onPressed, Color color = Colors.white, double opacity = 0.6}) {
    return Container(
      margin: const EdgeInsets.only(left: DesignSystem.spacing16, top: DesignSystem.spacing16),
      decoration: BoxDecoration(
        color: color.withOpacity(opacity),
        borderRadius: BorderRadius.circular(DesignSystem.radius8),
      ),
      child: IconButton(
        onPressed: () => onPressed?.call(),
        icon: Icon(Icons.arrow_back_rounded, color: Colors.black),
      ),
    );
  }

  static Widget closeButton({VoidCallback? onPressed, Color color = Colors.white, double opacity = 0.6}) {
    return Container(
      margin: const EdgeInsets.only(left: DesignSystem.spacing16, top: DesignSystem.spacing16),
      decoration: BoxDecoration(
        color: color.withOpacity(opacity),
        borderRadius: BorderRadius.circular(DesignSystem.radius8),
      ),
      child: IconButton(
        onPressed: () => onPressed?.call(),
        icon: Icon(Icons.close_rounded, color: Colors.black),
      ),
    );
  }
}
