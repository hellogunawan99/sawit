import 'package:flutter/material.dart';

class DashboardData {
  static List<StatCard> getStats() {
    return [
      StatCard(
        icon: Icons.payments_rounded,
        label: 'Total Revenue',
        value: '\$48,294',
        change: '+12.5%',
        isPositive: true,
        color: const Color(0xFF667eea),
      ),
      StatCard(
        icon: Icons.shopping_cart_rounded,
        label: 'Total Orders',
        value: '1,284',
        change: '+8.2%',
        isPositive: true,
        color: const Color(0xFF764ba2),
      ),
      StatCard(
        icon: Icons.people_rounded,
        label: 'New Customers',
        value: '3,842',
        change: '+24.3%',
        isPositive: true,
        color: const Color(0xFFf093fb),
      ),
      StatCard(
        icon: Icons.trending_down_rounded,
        label: 'Pending Orders',
        value: '18',
        change: '-5.1%',
        isPositive: false,
        color: const Color(0xFFf5576c),
      ),
    ];
  }

  static List<Activity> getRecentActivities() {
    return [
      Activity(
        icon: Icons.shopping_bag_rounded,
        title: 'New order received',
        time: '2 minutes ago',
        amount: '+\$249.00',
        isPositive: true,
        color: const Color(0xFF667eea),
      ),
      Activity(
        icon: Icons.person_add_rounded,
        title: 'New customer registered',
        time: '15 minutes ago',
        amount: '+1',
        isPositive: true,
        color: const Color(0xFF764ba2),
      ),
      Activity(
        icon: Icons.cancel_rounded,
        title: 'Order cancelled',
        time: '1 hour ago',
        amount: '-\$89.00',
        isPositive: false,
        color: const Color(0xFFf5576c),
      ),
      Activity(
        icon: Icons.payments_rounded,
        title: 'Payment received',
        time: '2 hours ago',
        amount: '+\$1,299.00',
        isPositive: true,
        color: const Color(0xFF4ade80),
      ),
      Activity(
        icon: Icons.local_shipping_rounded,
        title: 'Order shipped',
        time: '3 hours ago',
        amount: 'ORD-2847',
        isPositive: true,
        color: const Color(0xFFfbbf24),
      ),
    ];
  }
}

class StatCard {
  final IconData icon;
  final String label;
  final String value;
  final String? change;
  final bool? isPositive;
  final Color color;

  StatCard({
    required this.icon,
    required this.label,
    required this.value,
    this.change,
    this.isPositive,
    required this.color,
  });
}

class Activity {
  final IconData icon;
  final String title;
  final String time;
  final String amount;
  final bool isPositive;
  final Color color;

  Activity({
    required this.icon,
    required this.title,
    required this.time,
    required this.amount,
    required this.isPositive,
    required this.color,
  });
}
