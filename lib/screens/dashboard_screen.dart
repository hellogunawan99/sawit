import 'package:flutter/material.dart';
import '../auth/auth_service.dart';
import 'dashboard_content.dart';
import 'promo_screen.dart';
import 'pesanan_screen.dart';
import 'profil_screen.dart';
import 'timbang_tbs_screen.dart';

class DashboardScreen extends StatefulWidget {
  final VoidCallback? onLogout;

  const DashboardScreen({super.key, this.onLogout});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final _authService = AuthService();
  int _currentIndex = 0;

  final List<BottomNavItem> _navItems = [
    BottomNavItem(icon: Icons.dashboard_rounded, label: 'Beranda'),
    BottomNavItem(icon: Icons.car_rental_rounded, label: 'Kirim PKS'),
    BottomNavItem(icon: Icons.scale_rounded, label: 'Timbang TBS'),
    BottomNavItem(icon: Icons.book_rounded, label: 'Laporan'),
    BottomNavItem(icon: Icons.person_rounded, label: 'Profile'),
  ];

  Future<void> _logout() async {
    await _authService.logout();
    if (mounted) {
      widget.onLogout?.call();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SafeArea(child: _buildCurrentPage()),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  Widget _buildCurrentPage() {
    switch (_currentIndex) {
      case 0:
        return const DashboardContent();
      case 1:
        return const PromoScreen();
      case 2:
        return const TimbangTbsScreen();
      case 3:
        return const PesananScreen();
      case 4:
        return ProfilScreen(onLogout: _logout);
      default:
        return const DashboardContent();
    }
  }

  Widget _buildBottomNav() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 12,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
          child: Row(
            children: List.generate(_navItems.length, (index) {
              final item = _navItems[index];
              final isSelected = _currentIndex == index;
              return Expanded(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      _currentIndex = index;
                    });
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 4,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? const Color(0xFF2E8B57).withValues(alpha: 0.1)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          item.icon,
                          color: isSelected
                              ? const Color(0xFF2E8B57)
                              : Colors.grey.shade400,
                          size: 22,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          item.label,
                          style: TextStyle(
                            color: isSelected
                                ? const Color(0xFF2E8B57)
                                : Colors.grey.shade400,
                            fontSize: 10,
                            fontWeight: isSelected
                                ? FontWeight.w600
                                : FontWeight.w500,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}

class BottomNavItem {
  final IconData icon;
  final String label;

  BottomNavItem({required this.icon, required this.label});
}
