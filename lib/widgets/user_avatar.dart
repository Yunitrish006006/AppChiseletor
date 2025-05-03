import 'package:app_chiseletor/auth/auth_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// 用戶頭像元件
///
/// 一個顯示用戶頭像的可重用元件，支援以下功能：
/// - 顯示網絡圖片頭像
/// - 顯示本地圖片頭像
/// - 顯示用戶名首字母的文字頭像
/// - 顯示預設頭像圖標
/// - 支援不同尺寸和樣式設定
class UserAvatar extends StatelessWidget {
  /// 創建一個用戶頭像元件
  ///
  /// [size] 頭像的尺寸（高度和寬度相同）
  /// [imageUrl] 頭像圖片的 URL，可為 null
  /// [name] 用戶名稱，當 [imageUrl] 為 null 時可用於顯示首字母
  /// [backgroundColor] 頭像背景顏色
  /// [foregroundColor] 頭像前景顏色（文字或圖標顏色）
  /// [borderRadius] 頭像邊框圓角
  /// [borderWidth] 頭像邊框寬度
  /// [borderColor] 頭像邊框顏色
  /// [showBorder] 是否顯示邊框
  /// [useCircleAvatar] 是否使用 CircleAvatar 小部件
  /// [placeholderIconData] 預設顯示的圖標
  /// [useAuthManager] 是否從 AuthManager 讀取用戶信息
  const UserAvatar({
    Key? key,
    this.size = 40,
    this.imageUrl,
    this.name,
    this.backgroundColor,
    this.foregroundColor,
    this.borderRadius,
    this.borderWidth = 2,
    this.borderColor,
    this.showBorder = false,
    this.useCircleAvatar = true,
    this.placeholderIconData = Icons.person,
    this.useAuthManager = false,
    this.onTap,
  }) : super(key: key);

  final double size;
  final String? imageUrl;
  final String? name;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final double? borderRadius;
  final double borderWidth;
  final Color? borderColor;
  final bool showBorder;
  final bool useCircleAvatar;
  final IconData placeholderIconData;
  final bool useAuthManager;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // 如果使用 AuthManager，則從中獲取用戶資訊
    if (useAuthManager) {
      return Consumer<AuthenticationManager>(
        builder: (context, authManager, child) {
          final user = authManager.currentUser;
          final userImageUrl = user?.photoURL;
          final userName = user?.displayName;

          return _buildAvatar(
            context: context,
            theme: theme,
            imageUrl: userImageUrl,
            name: userName,
          );
        },
      );
    }

    // 否則使用直接提供的參數
    return _buildAvatar(
      context: context,
      theme: theme,
      imageUrl: imageUrl,
      name: name,
    );
  }

  Widget _buildAvatar({
    required BuildContext context,
    required ThemeData theme,
    String? imageUrl,
    String? name,
  }) {
    final effectiveBgColor = backgroundColor ?? theme.colorScheme.primary;
    final effectiveFgColor = foregroundColor ?? theme.colorScheme.onPrimary;
    final effectiveBorderColor = borderColor ?? theme.colorScheme.primary;

    Widget avatar;

    if (imageUrl != null && imageUrl.isNotEmpty) {
      // 顯示圖片頭像
      if (useCircleAvatar) {
        avatar = CircleAvatar(
          radius: size / 2,
          backgroundColor: effectiveBgColor,
          child: ClipOval(
            child: Image.network(
              imageUrl,
              width: size,
              height: size,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => _buildPlaceholder(
                effectiveBgColor,
                effectiveFgColor,
                name,
              ),
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return Center(
                  child: CircularProgressIndicator(
                    value: loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded /
                            loadingProgress.expectedTotalBytes!
                        : null,
                    color: effectiveFgColor,
                    strokeWidth: 2.0,
                  ),
                );
              },
            ),
          ),
        );
      } else {
        avatar = ClipRRect(
          borderRadius: BorderRadius.circular(borderRadius ?? size / 2),
          child: Image.network(
            imageUrl,
            width: size,
            height: size,
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => _buildPlaceholder(
              effectiveBgColor,
              effectiveFgColor,
              name,
            ),
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return Container(
                width: size,
                height: size,
                color: effectiveBgColor,
                child: Center(
                  child: CircularProgressIndicator(
                    value: loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded /
                            loadingProgress.expectedTotalBytes!
                        : null,
                    color: effectiveFgColor,
                    strokeWidth: 2.0,
                  ),
                ),
              );
            },
          ),
        );
      }
    } else {
      // 沒有圖片時顯示文字頭像或預設圖標
      if (useCircleAvatar) {
        avatar = CircleAvatar(
          radius: size / 2,
          backgroundColor: effectiveBgColor,
          child: _buildPlaceholder(
            effectiveBgColor,
            effectiveFgColor,
            name,
          ),
        );
      } else {
        avatar = Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: effectiveBgColor,
            borderRadius: BorderRadius.circular(borderRadius ?? size / 2),
          ),
          child: _buildPlaceholder(
            effectiveBgColor,
            effectiveFgColor,
            name,
          ),
        );
      }
    }

    // 如果要顯示邊框
    if (showBorder) {
      avatar = Container(
        decoration: BoxDecoration(
          shape: useCircleAvatar ? BoxShape.circle : BoxShape.rectangle,
          borderRadius: !useCircleAvatar
              ? BorderRadius.circular(borderRadius ?? size / 2)
              : null,
          border: Border.all(
            color: effectiveBorderColor,
            width: borderWidth,
          ),
        ),
        child: avatar,
      );
    }

    // 添加點擊動作（如果有）
    if (onTap != null) {
      avatar = InkWell(
        onTap: onTap,
        customBorder: useCircleAvatar
            ? const CircleBorder()
            : RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(borderRadius ?? size / 2),
              ),
        child: avatar,
      );
    }

    return avatar;
  }

  Widget _buildPlaceholder(
    Color backgroundColor,
    Color foregroundColor,
    String? name,
  ) {
    // 如果有名稱且不為空，則顯示首字母
    if (name != null && name.isNotEmpty) {
      return Center(
        child: Text(
          name[0].toUpperCase(),
          style: TextStyle(
            color: foregroundColor,
            fontWeight: FontWeight.bold,
            fontSize: size * 0.5,
          ),
        ),
      );
    }

    // 否則顯示預設圖標
    return Icon(
      placeholderIconData,
      color: foregroundColor,
      size: size * 0.5,
    );
  }
}
