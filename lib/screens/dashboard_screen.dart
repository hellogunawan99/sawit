import 'package:flutter/material.dart';
import '../auth/auth_service.dart';
import 'models/dashboard_data.dart';

class DashboardScreen extends StatefulWidget {
  final VoidCallback? onLogout;

  const DashboardScreen({super.key, this.onLogout});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final _authService = AuthService();
  int _selectedIndex = 0;

  final List<NavigationItem> _navItems = [
    NavigationItem(
      icon: Icons.dashboard_rounded,
      selectedIcon: Icons.dashboard_rounded,
      label: 'Dashboard',
    ),
    NavigationItem(
      icon: Icons.analytics_rounded,
      selectedIcon: Icons.analytics_rounded,
      label: 'Analytics',
    ),
    NavigationItem(
      icon: Icons.inventory_2_rounded,
      selectedIcon: Icons.inventory_2_rounded,
      label: 'Products',
    ),
    NavigationItem(
      icon: Icons.people_rounded,
      selectedIcon: Icons.people_rounded,
      label: 'Customers',
    ),
    NavigationItem(
      icon: Icons.receipt_long_rounded,
      selectedIcon: Icons.receipt_long_rounded,
      label: 'Orders',
    ),
    NavigationItem(
      icon: Icons.settings_rounded,
      selectedIcon: Icons.settings_rounded,
      label: 'Settings',
    ),
  ];

  Future<void> _logout() async {
    await _authService.logout();
    if (mounted) {
      widget.onLogout?.call();
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth >= 1200;
    final isTablet = screenWidth >= 768 && screenWidth < 1200;

    if (isDesktop) {
      return _buildDesktopLayout();
    } else if (isTablet) {
      return _buildTabletLayout();
    } else {
      return _buildMobileLayout();
    }
  }

  Widget _buildDesktopLayout() {
    return Scaffold(
      body: Row(
        children: [
          _buildSidebar(),
          Expanded(
            child: Column(
              children: [
                _buildTopBar(),
                Expanded(child: _buildContent()),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabletLayout() {
    return Scaffold(
      body: Row(
        children: [
          _buildSidebar(isCollapsed: false),
          Expanded(
            child: Column(
              children: [
                _buildTopBar(),
                Expanded(child: _buildContent()),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMobileLayout() {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu_rounded, color: Color(0xFF1a1a2e)),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        title: const Text(
          'Sawit Dashboard',
          style: TextStyle(color: Color(0xFF1a1a2e), fontWeight: FontWeight.bold),
        ),
        actions: [
          _buildProfileAvatar(),
        ],
      ),
      drawer: _buildSidebar(isCollapsed: false),
      body: _buildContent(),
    );
  }

  Widget _buildSidebar({bool isCollapsed = true}) {
    return Container(
      width: isCollapsed ? 80 : 280,
      decoration: BoxDecoration(
        color: const Color(0xFF1a1a2e),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(2, 0),
          ),
        ],
      ),
      child: Column(
        children: [
          SizedBox(height: isCollapsed ? 16 : 24),
          if (!isCollapsed) ...[
            _buildLogo(),
            const SizedBox(height: 32),
          ] else ...[
            _buildCollapsedLogo(),
            const SizedBox(height: 32),
          ],
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: _navItems.length,
              itemBuilder: (context, index) {
                final item = _navItems[index];
                final isSelected = _selectedIndex == index;
                return _buildNavItem(item, isSelected, isCollapsed);
              },
            ),
          ),
          _buildLogoutItem(isCollapsed),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildLogo() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF667eea), Color(0xFF764ba2)],
              ),
              borderRadius: BorderRadius.all(Radius.circular(12)),
            ),
            child: const Icon(Icons.eco_rounded, color: Colors.white, size: 24),
          ),
          const SizedBox(width: 12),
          const Text(
            'Sawit',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
              letterSpacing: 1,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCollapsedLogo() {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF667eea), Color(0xFF764ba2)],
          ),
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
        child: const Icon(Icons.eco_rounded, color: Colors.white, size: 24),
      ),
    );
  }

  Widget _buildNavItem(NavigationItem item, bool isSelected, bool isCollapsed) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: isCollapsed ? 8 : 16, vertical: 4),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            setState(() {
              _selectedIndex = _navItems.indexOf(item);
            });
          },
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: EdgeInsets.symmetric(
              vertical: 12,
              horizontal: isCollapsed ? 0 : 16,
            ),
            decoration: BoxDecoration(
              color: isSelected ? const Color(0xFF667eea).withOpacity(0.2) : Colors.transparent,
              borderRadius: BorderRadius.circular(12),
              border: isSelected
                  ? Border.all(color: const Color(0xFF667eea).withOpacity(0.5), width: 1)
                  : null,
            ),
            child: isCollapsed
                ? Column(
                    children: [
                      Icon(
                        isSelected ? item.selectedIcon : item.icon,
                        color: isSelected ? const Color(0xFF667eea) : Colors.grey.shade400,
                        size: 24,
                      ),
                      if (isSelected) const SizedBox(height: 4),
                      if (isSelected)
                        Container(
                          width: 4,
                          height: 4,
                          decoration: const BoxDecoration(
                            color: Color(0xFF667eea),
                            shape: BoxShape.circle,
                          ),
                        ),
                    ],
                  )
                : Row(
                    children: [
                      Icon(
                        isSelected ? item.selectedIcon : item.icon,
                        color: isSelected ? const Color(0xFF667eea) : Colors.grey.shade400,
                        size: 22,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          item.label,
                          style: TextStyle(
                            color: isSelected ? const Color(0xFF667eea) : Colors.grey.shade400,
                            fontSize: 15,
                            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (isSelected)
                        Container(
                          width: 6,
                          height: 6,
                          decoration: const BoxDecoration(
                            color: Color(0xFF667eea),
                            shape: BoxShape.circle,
                          ),
                        ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }

  Widget _buildLogoutItem(bool isCollapsed) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: isCollapsed ? 8 : 16, vertical: 4),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: _logout,
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: EdgeInsets.symmetric(
              vertical: 12,
              horizontal: isCollapsed ? 0 : 16,
            ),
            child: isCollapsed
                ? Icon(Icons.logout_rounded, color: Colors.red.shade400, size: 24)
                : Row(
                    children: [
                      Icon(Icons.logout_rounded, color: Colors.red.shade400, size: 22),
                      const SizedBox(width: 12),
                      Text(
                        'Logout',
                        style: TextStyle(
                          color: Colors.red.shade400,
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }

  Widget _buildTopBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 1,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        children: [
          const Expanded(
            child: Text(
              'Dashboard',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1a1a2e),
              ),
            ),
          ),
          _buildSearchBar(),
          const SizedBox(width: 16),
          _buildNotificationIcon(),
          const SizedBox(width: 16),
          _buildProfileAvatar(),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return SizedBox(
      width: 200,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: const Color(0xFFF3F4F6),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(Icons.search_rounded, color: Colors.grey.shade500, size: 20),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                'Search...',
                style: TextStyle(color: Colors.grey.shade500, fontSize: 14),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNotificationIcon() {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        IconButton(
          icon: Icon(Icons.notifications_outlined, color: Colors.grey.shade600),
          onPressed: () {},
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(minWidth: 40, minHeight: 40),
        ),
        Positioned(
          top: 8,
          right: 8,
          child: Container(
            width: 8,
            height: 8,
            decoration: const BoxDecoration(
              color: Colors.red,
              shape: BoxShape.circle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildProfileAvatar() {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF667eea), Color(0xFF764ba2)],
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: const Center(
        child: Text(
          'TU',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
        ),
      ),
    );
  }

  Widget _buildContent() {
    return Container(
      color: const Color(0xFFF8F9FC),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildWelcomeSection(),
            const SizedBox(height: 16),
            _buildStatsCards(),
            const SizedBox(height: 16),
            _buildChartsSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildWelcomeSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Welcome back, Test!',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF1a1a2e),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'Here\'s what\'s happening with your business today',
          style: TextStyle(
            fontSize: 13,
            color: Colors.grey.shade600,
          ),
        ),
      ],
    );
  }

  Widget _buildStatsCards() {
    final stats = DashboardData.getStats();
    final screenWidth = MediaQuery.of(context).size.width;

    int crossAxisCount;
    if (screenWidth >= 1200) {
      crossAxisCount = 4;
    } else if (screenWidth >= 768) {
      crossAxisCount = 2;
    } else {
      crossAxisCount = 2;
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        double childAspectRatio;
        if (screenWidth >= 1200) {
          childAspectRatio = 2.5;
        } else if (screenWidth >= 768) {
          childAspectRatio = 2.8;
        } else {
          childAspectRatio = 2.2;
        }

        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: childAspectRatio,
          ),
          itemCount: stats.length,
          itemBuilder: (context, index) {
            final stat = stats[index];
            return _buildStatCard(stat);
          },
        );
      },
    );
  }

  Widget _buildStatCard(StatCard stat) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: stat.color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(stat.icon, color: stat.color, size: 22),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  stat.value,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1a1a2e),
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(
                  stat.label,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade600,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          if (stat.isPositive != null)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
              decoration: BoxDecoration(
                color: stat.isPositive! ? Colors.green.shade50 : Colors.red.shade50,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    stat.isPositive! ? Icons.trending_up_rounded : Icons.trending_down_rounded,
                    size: 12,
                    color: stat.isPositive! ? Colors.green.shade700 : Colors.red.shade700,
                  ),
                  const SizedBox(width: 2),
                  Text(
                    stat.change!,
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: stat.isPositive! ? Colors.green.shade700 : Colors.red.shade700,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildChartsSection() {
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth >= 900;

    if (isDesktop) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: _buildChartSection()),
          const SizedBox(width: 16),
          Expanded(child: _buildRecentActivity()),
        ],
      );
    } else {
      return Column(
        children: [
          _buildChartSection(),
          const SizedBox(height: 16),
          _buildRecentActivity(),
        ],
      );
    }
  }

  Widget _buildChartSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Expanded(
                child: Text(
                  'Revenue Overview',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1a1a2e),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: const Color(0xFFF3F4F6),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text('This Week', style: TextStyle(fontSize: 12)),
                    const SizedBox(width: 4),
                    Icon(Icons.keyboard_arrow_down_rounded, size: 16, color: Colors.grey.shade600),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          _buildSimpleChart(),
        ],
      ),
    );
  }

  Widget _buildSimpleChart() {
    final data = [40, 65, 45, 80, 55, 90, 70];
    final days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    final maxValue = data.reduce((a, b) => a > b ? a : b);

    return SizedBox(
      height: 180,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(data.length, (index) {
          final value = data[index];
          final height = (value / maxValue) * 140;
          return Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                width: 28,
                height: height,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [Color(0xFF667eea), Color(0xFF764ba2)],
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(6)),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                days[index],
                style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
              ),
            ],
          );
        }),
      ),
    );
  }

  Widget _buildRecentActivity() {
    final activities = DashboardData.getRecentActivities();
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Recent Activity',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1a1a2e),
            ),
          ),
          const SizedBox(height: 16),
          ...activities.map((activity) => _buildActivityItem(activity)),
        ],
      ),
    );
  }

  Widget _buildActivityItem(Activity activity) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: activity.color.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(activity.icon, color: activity.color, size: 16),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  activity.title,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF1a1a2e),
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  activity.time,
                  style: TextStyle(fontSize: 11, color: Colors.grey.shade500),
                ),
              ],
            ),
          ),
          Text(
            activity.amount,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: activity.isPositive ? Colors.green.shade700 : Colors.red.shade700,
            ),
          ),
        ],
      ),
    );
  }
}

class NavigationItem {
  final IconData icon;
  final IconData selectedIcon;
  final String label;

  NavigationItem({
    required this.icon,
    required this.selectedIcon,
    required this.label,
  });
}
