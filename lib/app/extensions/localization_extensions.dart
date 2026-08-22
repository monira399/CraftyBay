import 'package:craftybay/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

extension LocalizationExtensions on BuildContext {
  AppLocalizations get localizations {
    return AppLocalizations.of(this)!;
  }
}