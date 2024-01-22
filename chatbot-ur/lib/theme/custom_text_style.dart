import 'package:flutter/material.dart';
import '../core/app_export.dart';

/// A collection of pre-defined text styles for customizing text appearance,
/// categorized by different font families and weights.
/// Additionally, this class includes extensions on [TextStyle] to easily apply specific font families to text.

class CustomTextStyles {
  // Body text style
  static get bodyMediumInterBluegray500 =>
      theme.textTheme.bodyMedium!.inter.copyWith(
          color: appTheme.blueGray500,
          decorationStyle: TextDecorationStyle.wavy);
  static get bodyMediumInterOnPrimaryContainer =>
      theme.textTheme.bodyMedium!.inter.copyWith(
        color: theme.colorScheme.onPrimaryContainer,
      );
  static get bodySmallBlack900 => theme.textTheme.bodySmall!.copyWith(
        color: appTheme.black900,
        fontSize: 12.fSize,
      );
  static get bodySmallProximaNovaOnPrimary =>
      theme.textTheme.bodySmall!.proximaNova.copyWith(
        color: theme.colorScheme.onPrimary,
        fontWeight: FontWeight.w300,
      );
  // Title style
  static get titleMediumInter => theme.textTheme.titleMedium!.inter;
  static get titleMediumInterOnPrimary =>
      theme.textTheme.titleMedium!.inter.copyWith(
        color: theme.colorScheme.onPrimary,
      );
  static get titleMediumInter_1 => theme.textTheme.titleMedium!.inter;
  static get titleMediumInter_2 => theme.textTheme.titleMedium!.inter;
  static get titleSmallPrimary => theme.textTheme.titleSmall!.copyWith(
        color: Colors.grey,
      );
  static get titleSmallPrimary_1 => theme.textTheme.titleSmall!.copyWith(
        color: theme.colorScheme.primary,
      );
}

extension on TextStyle {
  TextStyle get geometria {
    return copyWith(
      fontFamily: 'Geometria',
    );
  }

  TextStyle get inter {
    return copyWith(
      fontFamily: 'Inter',
    );
  }

  TextStyle get poppins {
    return copyWith(
      fontFamily: 'Poppins',
    );
  }

  TextStyle get proximaNova {
    return copyWith(
      fontFamily: 'Proxima Nova',
    );
  }
}
