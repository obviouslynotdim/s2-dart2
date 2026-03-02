import 'package:flutter/material.dart';
 import 'package:provider/provider.dart'; // add provider
import '../../../model/settings/app_settings.dart';
import '../../theme/theme.dart';
import '../../states/settings_state.dart'; // setting state
import 'widget/theme_color_button.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // watch the global settings state
    AppSettingsState settingsState = context.watch<AppSettingsState>();
 
    return Container(
      color: settingsState.theme.backgroundColor, // bg from state
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 16),
          Text("Settings", style: AppTextStyles.heading),

          SizedBox(height: 50),

          Text(
            "Theme",
            style: AppTextStyles.label.copyWith(color: AppColors.textLight),
          ),

          SizedBox(height: 10),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: ThemeColor.values
                .map(
                  (theme) => ThemeColorButton(
                    themeColor: theme,
                    // check if this button matches the current state
                    isSelected: settingsState.theme == theme,
                    onTap: (value) {
                      // update theme
                      settingsState.changeTheme(value);
                    },
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}
