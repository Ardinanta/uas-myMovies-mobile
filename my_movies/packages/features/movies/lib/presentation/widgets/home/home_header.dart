import 'package:core_ui/core_ui.dart';
import 'package:core_services/core_services.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class HomeHeader extends StatefulWidget {
  const HomeHeader({super.key});

  @override
  State<HomeHeader> createState() => _HomeHeaderState();
}

class _HomeHeaderState extends State<HomeHeader> {
  String? _username;

  @override
  void initState() {
    super.initState();
    _loadUsername();
  }

  Future<void> _loadUsername() async {
    final storage = GetIt.instance.isRegistered<LocalStorageService>()
        ? GetIt.instance<LocalStorageService>()
        : const SecureStorageService();
    final username = await storage.getString(AuthStorageKeys.username);

    if (!mounted) {
      return;
    }

    setState(() => _username = username);
  }

  @override
  Widget build(BuildContext context) {
    final username = _username?.trim().isNotEmpty == true
        ? _username!.trim()
        : 'Guest';

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 14, 20, 8),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 16,
            backgroundColor: AppColors.surfaceContainerHighest,
            child: Icon(
              Icons.movie_filter_rounded,
              color: AppColors.cinematicRed,
              size: 18,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              'Hi, $username.',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyles.titleMd.copyWith(
                color: AppColors.onSurface,
                fontSize: 15,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
