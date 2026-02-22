import 'package:flutter/material.dart';
import '../../../providers/theme_color_provider.dart';
import 'download_controler.dart';

class DownloadTile extends StatelessWidget {
  const DownloadTile({super.key, required this.controller});

  final DownloadController controller;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: controller,
      builder: (context, child) {
        final res = controller.ressource;
        final downloadedMB = (controller.progress * res.size).toStringAsFixed(1);
        final progressPercent = (controller.progress * 100).toStringAsFixed(1);

        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              color: themeProvider.themeColor.color.withOpacity(0.5),
            ),
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      res.name,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "$progressPercent% completed - $downloadedMB of ${res.size} MB",
                      style: const TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                  ],
                ),
              ),
              _buildTrailing(),
            ],
          ),
        );
      },
    );
  }

  Widget _buildTrailing() {
    switch (controller.status) {
      case DownloadStatus.notDownloaded:
        return IconButton(
          icon: const Icon(Icons.download),
          // color: themeProvider.themeColor.color,
          onPressed: controller.startDownload,
        );
      case DownloadStatus.downloading:
        return SizedBox(
          width: 24,
          height: 24,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            color: themeProvider.themeColor.color,
          ),
        );
      case DownloadStatus.downloaded:
        return Icon(Icons.check_circle, color: themeProvider.themeColor.color);
    }
  }
}
