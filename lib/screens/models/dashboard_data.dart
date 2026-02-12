import 'package:flutter/material.dart';

class DashboardData {
  static List<PackageData> getPackages() {
    return [
      PackageData(
        name: 'Sawit TBS Grade A',
        price: 'Rp 3.281 / Kg',
        distance: '25 Km',
      ),
      PackageData(
        name: 'Sawit TBS Grade B',
        price: 'Rp 3.181 / Kg',
        distance: '15 Km',
      ),
    ];
  }

  static List<ServiceItem> getServices() {
    return [
      ServiceItem(
        label: 'Toko Tani',
        icon: Icons.shopping_bag_rounded,
        iconColor: const Color(0xFF2E8B57),
      ),
      ServiceItem(
        label: 'Rekomendasi Nutrisi Sawit',
        icon: Icons.nature_rounded,
        iconColor: const Color(0xFF667eea),
      ),
      ServiceItem(
        label: 'Pelajari Gulma & Hama',
        icon: Icons.grass_rounded,
        iconColor: const Color(0xFFf5576c),
      ),
      ServiceItem(
        label: 'Tanya Konsultan',
        icon: Icons.forum_rounded,
        iconColor: const Color(0xFFf093fb),
      ),
      ServiceItem(
        label: 'Lihat PKS',
        icon: Icons.factory_rounded,
        iconColor: const Color(0xFF4ade80),
      ),
      ServiceItem(
        label: 'All Fitur',
        icon: Icons.apps_rounded,
        iconColor: const Color(0xFFfbbf24),
      ),
    ];
  }

  static List<PromoItem> getPromos() {
    return [
      PromoItem(
        title: 'Diskon Pupuk Sawit 20%',
        description: 'Dapatkan diskon khusus untuk pembelian pupuk sawit premium kualitas terbaik.',
        discount: '20% OFF',
        validUntil: 'Berakhir 30 Jan',
        icon: Icons.eco_rounded,
        color: const Color(0xFF2E8B57),
      ),
      PromoItem(
        title: 'Gratis Ongkir KUD',
        description: 'Gratis ongkos kirim untuk pemesanan minimal 500kg dalam radius 30km.',
        discount: 'GRATIS',
        validUntil: 'Berakhir 25 Jan',
        icon: Icons.local_shipping_rounded,
        color: const Color(0xFF667eea),
      ),
      PromoItem(
        title: 'Cashback Hingga Rp 500rb',
        description: 'Cashback langsung untuk transaksi pembelian sawit TBS Grade A minggu ini.',
        discount: 'Rp 500K',
        validUntil: 'Berakhir 20 Jan',
        icon: Icons.account_balance_wallet_rounded,
        color: const Color(0xFFfbbf24),
      ),
      PromoItem(
        title: 'Paket Hemat Nutrisi',
        description: 'Beli 3 nutrisi sawit gratis 1 untuk kesehatan tanaman perkebunan Anda.',
        discount: 'BUY 3 GET 1',
        validUntil: 'Berakhir 15 Feb',
        icon: Icons.card_giftcard_rounded,
        color: const Color(0xFFf5576c),
      ),
    ];
  }

  static List<OrderItem> getOrders() {
    return [
      OrderItem(
        id: '#ORD-2024-001',
        productName: 'Sawit TBS Grade A',
        quantity: 500,
        totalPrice: 'Rp 1.640.500',
        status: 'Diproses',
        statusColor: const Color(0xFFfbbf24),
        date: '12 Jan 2024',
      ),
      OrderItem(
        id: '#ORD-2024-002',
        productName: 'Sawit TBS Grade B',
        quantity: 350,
        totalPrice: 'Rp 1.113.350',
        status: 'Selesai',
        statusColor: const Color(0xFF4ade80),
        date: '10 Jan 2024',
      ),
      OrderItem(
        id: '#ORD-2024-003',
        productName: 'Pupuk Sawit Premium',
        quantity: 100,
        totalPrice: 'Rp 850.000',
        status: 'Selesai',
        statusColor: const Color(0xFF4ade80),
        date: '8 Jan 2024',
      ),
      OrderItem(
        id: '#ORD-2024-004',
        productName: 'Sawit TBS Grade A',
        quantity: 200,
        totalPrice: 'Rp 656.200',
        status: 'Pending',
        statusColor: const Color(0xFFf5576c),
        date: '5 Jan 2024',
      ),
      OrderItem(
        id: '#ORD-2024-005',
        productName: 'Nutrisi Tanaman Sawit',
        quantity: 50,
        totalPrice: 'Rp 425.000',
        status: 'Selesai',
        statusColor: const Color(0xFF4ade80),
        date: '3 Jan 2024',
      ),
    ];
  }

  static ProfileData getProfile() {
    return ProfileData(
      name: 'KUD Sawit Makmur',
      email: 'kud.sawitmakmur@example.com',
      phone: '+62 812-3456-7890',
      address: 'Jl. Perkebunan No. 123, Riau',
      totalOrders: '156',
      completedOrders: '142',
      pendingOrders: '3',
      memberSince: 'Jan 2022',
      menuItems: [
        ProfileMenuItem(
          label: 'Edit Profil',
          icon: Icons.edit_rounded,
          iconColor: const Color(0xFF2E8B57),
        ),
        ProfileMenuItem(
          label: 'Alamat Pengiriman',
          icon: Icons.location_on_rounded,
          iconColor: const Color(0xFF667eea),
        ),
        ProfileMenuItem(
          label: 'Metode Pembayaran',
          icon: Icons.payment_rounded,
          iconColor: const Color(0xFF764ba2),
        ),
        ProfileMenuItem(
          label: 'Riwayat Transaksi',
          icon: Icons.receipt_long_rounded,
          iconColor: const Color(0xFFfbbf24),
        ),
        ProfileMenuItem(
          label: 'Notifikasi',
          icon: Icons.notifications_rounded,
          iconColor: const Color(0xFFf5576c),
        ),
        ProfileMenuItem(
          label: 'Pusat Bantuan',
          icon: Icons.help_rounded,
          iconColor: const Color(0xFF38bdf8),
        ),
        ProfileMenuItem(
          label: 'Tentang Aplikasi',
          icon: Icons.info_rounded,
          iconColor: const Color(0xFF4ade80),
        ),
      ],
    );
  }
}

class PackageData {
  final String name;
  final String price;
  final String distance;

  PackageData({
    required this.name,
    required this.price,
    required this.distance,
  });
}

class ServiceItem {
  final String label;
  final IconData icon;
  final Color iconColor;

  ServiceItem({
    required this.label,
    required this.icon,
    required this.iconColor,
  });
}

class PromoItem {
  final String title;
  final String description;
  final String discount;
  final String validUntil;
  final IconData icon;
  final Color color;

  PromoItem({
    required this.title,
    required this.description,
    required this.discount,
    required this.validUntil,
    required this.icon,
    required this.color,
  });
}

class OrderItem {
  final String id;
  final String productName;
  final int quantity;
  final String totalPrice;
  final String status;
  final Color statusColor;
  final String date;

  OrderItem({
    required this.id,
    required this.productName,
    required this.quantity,
    required this.totalPrice,
    required this.status,
    required this.statusColor,
    required this.date,
  });
}

class ProfileData {
  final String name;
  final String email;
  final String phone;
  final String address;
  final String totalOrders;
  final String completedOrders;
  final String pendingOrders;
  final String memberSince;
  final List<ProfileMenuItem> menuItems;

  ProfileData({
    required this.name,
    required this.email,
    required this.phone,
    required this.address,
    required this.totalOrders,
    required this.completedOrders,
    required this.pendingOrders,
    required this.memberSince,
    required this.menuItems,
  });
}

class ProfileMenuItem {
  final String label;
  final IconData icon;
  final Color iconColor;

  ProfileMenuItem({
    required this.label,
    required this.icon,
    required this.iconColor,
  });
}
