import 'package:app_chiseletor/widgets/user_avatar.dart';
import 'package:app_chiseletor_example/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

/// 範例頁面：展示如何使用 UserAvatar 顯示多個不同用戶的頭像
class UserListSample extends StatelessWidget {
  const UserListSample({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // 範例用戶資料
    final users = [
      {
        'name': 'Alice Johnson',
        'email': 'alice@example.com',
        'photoUrl': 'https://i.pravatar.cc/150?img=1',
        'status': 'online',
      },
      {
        'name': 'Bob Smith',
        'email': 'bob@example.com',
        'photoUrl': 'https://i.pravatar.cc/150?img=2',
        'status': 'away',
      },
      {
        'name': 'Carol White',
        'email': 'carol@example.com',
        'photoUrl': 'https://i.pravatar.cc/150?img=3',
        'status': 'online',
      },
      {
        'name': 'Dave Brown',
        'email': 'dave@example.com',
        'photoUrl': null, // 沒有頭像的用戶
        'status': 'offline',
      },
      {
        'name': 'Ella Davis',
        'email': 'ella@example.com',
        'photoUrl': 'https://i.pravatar.cc/150?img=5',
        'status': 'online',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('用戶列表範例'),
      ),
      body: ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          final user = users[index];
          final userName = user['name'] as String;
          final userEmail = user['email'] as String;
          final userPhotoUrl = user['photoUrl'] as String?;
          final userStatus = user['status'] as String;

          // 根據狀態設置顏色
          final statusColor = userStatus == 'online'
              ? Colors.green
              : userStatus == 'away'
                  ? Colors.amber
                  : Colors.grey;

          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: ListTile(
              leading: Stack(
                children: [
                  // 用戶頭像 - 使用 UserAvatar 組件
                  UserAvatar(
                    imageUrl: userPhotoUrl,
                    name: userName,
                    size: 50,
                    showBorder: true,
                    borderColor: theme.colorScheme.primary.withOpacity(0.5),
                  ),

                  // 狀態指示器
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        color: statusColor,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: theme.scaffoldBackgroundColor,
                          width: 2,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              title: Text(userName),
              subtitle: Text(userEmail),
              trailing: IconButton(
                icon: const Icon(Icons.message),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('向 $userName 傳送訊息')),
                  );
                },
              ),
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('查看 $userName 的個人資料')),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
