import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'models/dashboard_data.dart';
import 'keuangan_screen.dart';

class DashboardContent extends StatefulWidget {
  const DashboardContent({super.key});

  @override
  State<DashboardContent> createState() => _DashboardContentState();
}

class _DashboardContentState extends State<DashboardContent> {
  String _currentLocation = 'lokasi anda';
  bool _isLoading = true;
  bool _hasAskedPermission = false;

  static const String _locationAskedKey = 'location_permission_asked';
  static const String _savedLocationKey = 'saved_location';

  @override
  void initState() {
    super.initState();
    _initLocation();
  }

  Future<void> _initLocation() async {
    final prefs = await SharedPreferences.getInstance();
    final hasAsked = prefs.getBool(_locationAskedKey) ?? false;
    final savedLocation = prefs.getString(_savedLocationKey);

    setState(() {
      _hasAskedPermission = hasAsked;
    });

    if (hasAsked && savedLocation != null && savedLocation.isNotEmpty) {
      setState(() {
        _currentLocation = savedLocation;
        _isLoading = false;
      });
    }

    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        setState(() {
          _currentLocation = 'Layanan lokasi mati';
          _isLoading = false;
        });
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();

      // Only request permission if we haven't asked before
      if (permission == LocationPermission.denied && !_hasAskedPermission) {
        permission = await Geolocator.requestPermission();

        // Mark that we've asked for permission
        final prefs = await SharedPreferences.getInstance();
        await prefs.setBool(_locationAskedKey, true);
        setState(() {
          _hasAskedPermission = true;
        });

        if (permission == LocationPermission.denied) {
          setState(() {
            _currentLocation = 'Izin lokasi ditolak';
            _isLoading = false;
          });
          return;
        }
      }

      if (permission == LocationPermission.denied) {
        setState(() {
          _currentLocation = 'Izin lokasi ditolak';
          _isLoading = false;
        });
        return;
      }

      if (permission == LocationPermission.deniedForever) {
        setState(() {
          _currentLocation = 'Izin lokasi permanen ditolak';
          _isLoading = false;
        });
        return;
      }

      Position position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
        ),
      );

      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      if (placemarks.isNotEmpty) {
        Placemark place = placemarks[0];
        String? locality = place.locality;
        String? subAdministrativeArea = place.subAdministrativeArea;
        String? administrativeArea = place.administrativeArea;

        String locationText = '';
        if (locality != null && locality.isNotEmpty) {
          locationText = locality;
        } else if (subAdministrativeArea != null &&
            subAdministrativeArea.isNotEmpty) {
          locationText = subAdministrativeArea;
        } else if (administrativeArea != null && administrativeArea.isNotEmpty) {
          locationText = administrativeArea;
        } else {
          locationText = 'Lokasi tidak dikenal';
        }

        // Save the location for future use
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString(_savedLocationKey, locationText);

        setState(() {
          _currentLocation = locationText;
          _isLoading = false;
        });
      } else {
        setState(() {
          _currentLocation = 'Lokasi tidak ditemukan';
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _currentLocation = 'Gagal mendapatkan lokasi';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final packages = DashboardData.getPackages();
    final services = DashboardData.getServices();

    return Column(
      children: [
        _buildHeader(),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(16, 24, 16, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTopPriceCard(packages),
                const SizedBox(height: 32),
                _buildServiceGrid(services),
                const SizedBox(height: 32),
                _buildBottomCards(),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 32),
      decoration: const BoxDecoration(
        color: Color(0xFF2E8B57),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (_isLoading)
                const SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                ),
              if (_isLoading) const SizedBox(width: 8),
              Text(
                _currentLocation,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          const Center(
            child: Text(
              'Hallo, User Name KUD',
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTopPriceCard(List<PackageData> packages) {
    final PackageData? first =
        packages.isNotEmpty ? packages[0] : null;
    final PackageData? second =
        packages.length > 1 ? packages[1] : null;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(32),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (first != null) ...[
            const Text(
              'Nama Pabrik',
              style: TextStyle(
                fontSize: 12,
                color: Color(0xFF7C7C7C),
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              first.price,
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              first.distance,
              style: const TextStyle(
                fontSize: 14,
                color: Color(0xFF2E8B57),
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
          if (second != null) ...[
            const SizedBox(height: 24),
            Divider(
              color: Colors.grey.shade300,
              thickness: 1,
            ),
            const SizedBox(height: 24),
            const Text(
              'Nama Pabrik',
              style: TextStyle(
                fontSize: 12,
                color: Color(0xFF7C7C7C),
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              second.price,
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              second.distance,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black87,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildServiceGrid(List<ServiceItem> services) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 0.9,
      ),
      itemCount: services.length,
      itemBuilder: (context, index) {
        final service = services[index];
        return _buildServiceTile(service);
      },
    );
  }

  Widget _buildBottomCards() {
    return Column(
      children: [
        Container(
          height: 140,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.06),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: Container(
                height: 120,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.06),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Container(
                height: 120,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.06),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildServiceTile(ServiceItem service) {
    return GestureDetector(
      onTap: () {
        if (service.label == 'Keuangan') {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const KeuanganScreen(),
            ),
          );
        }
      },
      child: Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: service.iconColor.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(service.icon, color: service.iconColor, size: 24),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              service.label,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey.shade700,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    ),
    );
  }
}
