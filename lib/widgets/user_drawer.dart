import 'package:app_chiseletor/auth/auth_manager.dart';
import 'package:app_chiseletor/l10n/app_chiselator_localizations.dart';
import 'package:app_chiseletor/widgets/user_avatar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserDrawer extends StatelessWidget {
  const UserDrawer({
    super.key,
    this.onProfileTap,
    this.onSettingsTap,
    this.onAboutTap,
    this.onFeedbackTap,
    this.onHomeTap,
    this.onHelpTap,
    this.additionalItems = const [],
    this.headerHeight = 200,
    this.showHeader = true,
    this.headerBackgroundImage,
    this.avatarBackgroundColor,
  });

  final VoidCallback? onProfileTap;
  final VoidCallback? onSettingsTap;
  final VoidCallback? onAboutTap;
  final VoidCallback? onFeedbackTap;
  final VoidCallback? onHomeTap;
  final VoidCallback? onHelpTap;
  final List<Widget> additionalItems;
  final double headerHeight;
  final bool showHeader;
  final ImageProvider? headerBackgroundImage;
  final Color? avatarBackgroundColor;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return Drawer(
      child: Consumer<AuthenticationManager>(
        builder: (context, authManager, child) {
          final user = authManager.currentUser;

          return ListView(
            padding: EdgeInsets.zero,
            children: [
              if (showHeader)
                UserAccountsDrawerHeader(
                  decoration: BoxDecoration(
                    color: theme.primaryColor,
                    image: headerBackgroundImage != null
                        ? DecorationImage(
                            image: headerBackgroundImage!,
                            fit: BoxFit.cover,
                            opacity: 0.7,
                          )
                        : null,
                  ),
                  accountName: Text(
                    user?.displayName ?? l10n.guest,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  accountEmail: Text(
                    user?.email ?? l10n.notLoggedIn,
                  ),
                  currentAccountPicture: UserAvatar(
                    size: 80,
                    useAuthManager: true,
                    backgroundColor:
                        avatarBackgroundColor ?? theme.colorScheme.onPrimary,
                    foregroundColor: theme.primaryColor,
                    showBorder: true,
                    borderColor: theme.colorScheme.onPrimary.withOpacity(0.7),
                    onTap: onProfileTap,
                  ),
                ),

              // 首頁選項
              if (onHomeTap != null)
                ListTile(
                  leading: const Icon(Icons.home),
                  title: Text(l10n.home),
                  onTap: () {
                    Navigator.pop(context);
                    onHomeTap?.call();
                  },
                ),

              // 個人資料選項
              if (onProfileTap != null)
                ListTile(
                  leading: const Icon(Icons.person),
                  title: Text(l10n.profile),
                  onTap: () {
                    Navigator.pop(context);
                    onProfileTap?.call();
                  },
                ),

              // 設置選項
              if (onSettingsTap != null)
                ListTile(
                  leading: const Icon(Icons.settings),
                  title: Text(l10n.settings),
                  onTap: () {
                    Navigator.pop(context);
                    onSettingsTap?.call();
                  },
                ),

              // 額外的自訂選項
              ...additionalItems,

              const Divider(),

              // 關於選項
              if (onAboutTap != null)
                ListTile(
                  leading: const Icon(Icons.info_outline),
                  title: Text(l10n.about),
                  onTap: () {
                    Navigator.pop(context);
                    onAboutTap?.call();
                  },
                ),

              // 反饋選項
              if (onFeedbackTap != null)
                ListTile(
                  leading: const Icon(Icons.feedback_outlined),
                  title: Text(l10n.feedback),
                  onTap: () {
                    Navigator.pop(context);
                    onFeedbackTap?.call();
                  },
                ),

              // 幫助選項
              if (onHelpTap != null)
                ListTile(
                  leading: const Icon(Icons.help_outline),
                  title: Text(l10n.help),
                  onTap: () {
                    Navigator.pop(context);
                    onHelpTap?.call();
                  },
                ),

              // 登入/登出按鈕
              ListTile(
                leading: Icon(
                  authManager.isLoggedIn ? Icons.logout : Icons.login,
                ),
                title: Text(
                  authManager.isLoggedIn ? l10n.logout : l10n.login,
                ),
                onTap: () async {
                  Navigator.pop(context);
                  if (authManager.isLoggedIn) {
                    await authManager.signOut();
                  } else {
                    // 可以在這裡顯示登入對話框
                    // 或通過回調函數將登入邏輯委託給外部處理
                  }
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
