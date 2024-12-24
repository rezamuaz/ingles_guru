import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class DownloadPage extends StatelessWidget {
  final Stream<FileResponse> fileStream;
  final VoidCallback downloadFile;
  final VoidCallback clearCache;
  final VoidCallback removeFile;

  const DownloadPage({
    required this.fileStream,
    required this.downloadFile,
    required this.clearCache,
    required this.removeFile,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<FileResponse>(
      stream: fileStream,
      builder: (context, snapshot) {
        Widget body;
        final loading = !snapshot.hasData || snapshot.data is DownloadProgress;

        if (snapshot.hasError) {
          body = ListTile(
            title: const Text('Error'),
            subtitle: Text(snapshot.error.toString()),
          );
        } else if (loading) {
          body = ProgressIndicator(
            progress: snapshot.data as DownloadProgress?,
          );
        } else {
          body = FileInfoWidget(
            fileInfo: snapshot.requireData as FileInfo,
            clearCache: clearCache,
            removeFile: removeFile,
          );
        }

        return Scaffold(
          body: body,
          // floatingActionButton:
          //     !loading ? Fab(downloadFile: downloadFile) : null,
        );
      },
    );
  }
}


class FileInfoWidget extends StatelessWidget {
  final FileInfo fileInfo;
  final VoidCallback clearCache;
  final VoidCallback removeFile;

  const FileInfoWidget({
    required this.clearCache,
    required this.removeFile,
    required this.fileInfo,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ListTile(
          title: const Text('Original URL'),
          subtitle: Text(fileInfo.originalUrl),
        ),
        ListTile(
          title: const Text('Local file path'),
          subtitle: Text(fileInfo.file.path),
        ),
        ListTile(
          title: const Text('Loaded from'),
          subtitle: Text(fileInfo.source.toString()),
        ),
        ListTile(
          title: const Text('Valid Until'),
          subtitle: Text(fileInfo.validTill.toLocal().toString()),
        ),
        Padding(
          padding: const EdgeInsets.all(10),
          child: ElevatedButton(
            onPressed: clearCache,
            child: const Text('CLEAR CACHE'),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10),
          child: ElevatedButton(
            onPressed: removeFile,
            child: const Text('REMOVE FILE'),
          ),
        ),
      ],
    );
  }
}

class ProgressIndicator extends StatelessWidget {
  final DownloadProgress? progress;

  const ProgressIndicator({super.key, this.progress});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 50,
            height: 50,
            child: CircularProgressIndicator.adaptive(
              value: progress?.progress,
            ),
          ),
          const SizedBox(width: 20),
          const Text('Downloading'),
        ],
      ),
    );
  }
}