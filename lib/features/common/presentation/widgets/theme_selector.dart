import 'package:craftybay/app/extensions/localization_extensions.dart';
import 'package:craftybay/app/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ThemeSelector extends StatefulWidget {
  const ThemeSelector({super.key});

  @override
  State<ThemeSelector> createState() => _ThemeSelectorState();
}

class _ThemeSelectorState extends State<ThemeSelector> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(context.localizations.changeLanguage),
        DropdownMenu<ThemeMode> (
          initialSelection: context.read<ThemeProvider>().currentThemeMode,
          onSelected: (ThemeMode? mode) {
            if(mode == null) {
              context.read<ThemeProvider>().changeThemeMode(mode!);
            }
          },
          dropdownMenuEntries:const [
            DropdownMenuEntry(value: ThemeMode.light, label: 'Light'),
            DropdownMenuEntry(value: ThemeMode.dark, label: 'Dark'),
          ]
        ),
      ],
    );
  }
}
