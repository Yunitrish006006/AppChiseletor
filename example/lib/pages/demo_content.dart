import 'package:app_chiseletor_example/pages/demo_sub/page1.dart';
import 'package:flutter/material.dart';

class DemoContent extends StatefulWidget {
  const DemoContent({super.key});

  @override
  State<DemoContent> createState() => _DemoContentState();
}

class _DemoContentState extends State<DemoContent>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Column(
        children: [
          // TabBar 展示
          TabBar(
            controller: _tabController,
            tabs: const [
              Tab(icon: Icon(Icons.directions_car)),
              Tab(icon: Icon(Icons.directions_transit)),
              Tab(icon: Icon(Icons.directions_bike)),
            ],
          ),
          // TabBarView 展示
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                const Page1(),
                // 第三個頁面：列表展示
                ListView.builder(
                  itemCount: 20,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: const CircleAvatar(
                        child: Icon(Icons.person),
                      ),
                      title: Text('Item ${index + 1}'),
                      subtitle: Text('Description for item ${index + 1}'),
                      trailing: const Icon(Icons.arrow_forward_ios),
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('You tapped item ${index + 1}'),
                          ),
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
