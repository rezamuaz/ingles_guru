// import 'dart:async';
// import 'dart:io';
// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:loading_animation_widget/loading_animation_widget.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:flutter_cache_manager/flutter_cache_manager.dart';
// import 'package:sysbit/src/core/local_storage/hive/hive_service.dart';
// import 'package:path/path.dart' as path;
// import 'package:sysbit/src/features/lessons_page/data/model/url_mod.dart';

// class MultiDownloadFile extends StatefulWidget {
//   const MultiDownloadFile({super.key, this.urls = const []});
//   final List<UrlMod> urls;
//   @override
//   MultiDownloadFileState createState() => MultiDownloadFileState();
// }

// class MultiDownloadFileState extends State<MultiDownloadFile> {

//   late List<UrlMod> urls;
//   double _totalProgress = 0.0;
//   int _totalBytes = 0;
//   int _receivedBytes = 0;
//   ValueNotifier<bool> _isDownloading = ValueNotifier<bool>(false);
//   bool _isDisconnected = false;

//   @override
//   void initState() {
//     //Check Stream Network Status
//     //  _subscription = Network.connection.onStatusChange.listen((status) {
//     //   if(status == InternetStatus.disconnected && _isDownloading.value){
//     //     setState(() {
//     //       _isDownloading.value = false;

//     //     });
//     //   }else if (status == InternetStatus.connected && !_isDownloading.value){
//     //     downloadFiles();
//     //   }

//     //   setState(() {
//     //     _connectionStatus = status;
//     //   });
//     // });
//     setState(() {
//       urls = widget.urls;
//     });
//     _isDownloading.addListener(() {
//       if (!_isDownloading.value) {
//         Navigator.of(context).pop(true);
//       }
//     });
//     super.initState();
//   }

//   Future<void> downloadFiles() async {
//     setState(() {
    
//       _isDownloading.value = true;
//       _totalProgress = 0.0;
//       _receivedBytes = 0;
//       _totalBytes = 0;
//     });

//     // http.Client client = http.Client();
//     final dio = Dio();
//     List<Future<UrlMod>> downloadWait = [];
//     Directory documentDirectory = await getApplicationDocumentsDirectory();
//     // Check existing files in cache and calculate total size
//     for (var url in urls) {
//         downloadWait.add(_checkFile(url));
//     }

//    var downloadList = await Future.wait(downloadWait);
   
//     if (downloadList.isNotEmpty) {
//       final List<Future<String>> downloadTasks = [];
//       for (var url in downloadList) {
//             if (url.url.isNotEmpty){
// downloadTasks.add( _downloadFileToCache(documentDirectory, dio, url.url,
//             updatedAt: url.updatedAt));
//             }
            
//       }
//       await Future.wait(downloadTasks);
//     }
//     setState(() {
//       _isDownloading.value = false;
//     });
//   }

//   Future<UrlMod> _checkFile(UrlMod url )async{
//      var preference = const HiveService();
//       var cache = await preference.read<CacheHive>(
//           boxName: "vaultCache", key: url.url);
//       if (cache == null) {
//         return UrlMod(updatedAt: url.updatedAt,url: url.url);
       
//         // // If the file is not in cache, get its size and headers
//         // var  response = await dio.headUri(Uri.parse(url["url"]));
//         // _totalBytes += int.parse(response.headers.value('content-length') ?? '0');
//       } else {
//         // Check ETag if file exists in cache
//         if (url.updatedAt > cache.updatedAt) {
//         //   var  response = await dio.headUri(Uri.parse(url["url"]));
//         //  _totalBytes += int.parse(response.headers.value('content-length') ?? '0');
//         return UrlMod(url: url.url,updatedAt: url.updatedAt);
//         }
//         return UrlMod();
//       }
//   }

//   Future<String> _downloadFileToCache(
//       Directory documentDirectory, Dio client, String url,
//       {required int updatedAt}) async {
      
//     String fileName = url.split('/').last;
//     Directory tempDir = await getTemporaryDirectory();
//     String filePathTemp = '${tempDir.path}/$fileName';
//     File tempFile = File(filePathTemp);
//     // int receivedBytes = 0;
//     // Send GET request and handle the response stream
//       // http.StreamedResponse response =
//       //   await client.send(http.Request('GET', Uri.parse(url)));
     
//     //  late int received = 0;
//     // Track the progress of download
    
//      await client.download(
//         url,
//         tempFile.path,
//         onReceiveProgress: (received, total) {
//           setState(() {
//             _receivedBytes = received;
//             _totalProgress = total > 0 ? received / total : 0;
            
//           });
//         },
//       );
   
   
//     // Save the downloaded file to cache with ETag as metadata
//     String filepath = path.join(documentDirectory.path, path.basename(url));
//     File file = File(filepath);
//     // Write the downloaded file to local storage
//     await file.writeAsBytes(tempFile.readAsBytesSync());
//     await const HiveService().write<CacheHive>(
//         boxName: "vaultCache",
//         key: url,
//         value: CacheHive(location: filepath, updatedAt: updatedAt));
//     File('${tempDir.path}/$fileName').deleteSync();
    
//     return url;
//   }


//   @override
//   void didChangeDependencies() {
//     downloadFiles();
//     super.didChangeDependencies();
//   }
//   @override
//   void dispose() {
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Material(
//       color: Colors.transparent,

//       child: Padding(
//         padding: const EdgeInsets.all(20),
//         child: Center(
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                   Container(
//                       decoration: const BoxDecoration(color: Colors.white,borderRadius: BorderRadius.all(Radius.circular(15))),
//                     child: _isDownloading.value?  AnimatedOpacity(
//                         opacity: _isDownloading.value ? 1 : 0,
//                         duration: const Duration(milliseconds: 800),
//                         curve: Curves.linear,
//                         child: Container(
//                           padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
//                           alignment: Alignment.center,
                         
//                           child: Column(
//                             mainAxisSize: MainAxisSize.min,
//                             children: [
//                               Row(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: [
//                                   Text("Downloading...",style: GoogleFonts.inter(fontSize: 16,fontWeight: FontWeight.bold)),
//                                   const SizedBox(width: 10),
//                                   LoadingAnimationWidget.threeRotatingDots(
//                                       color: Colors.blue, size: 40),
                                       
//                                 ],
//                               ),
//                               Text(
//                 'Download Progress: ${(_totalProgress*100).toStringAsFixed(0)}%'),
            
//             const SizedBox(height: 20),
//             LinearProgressIndicator(value: _totalProgress),
//                             ],
//                           ),
//                         ),
//                       ) :  const SizedBox.shrink()
//                   ),
                  
//                 //  _isDisconnected?  Container(
//                 //         padding: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
//                 //         alignment: Alignment.center,
                       
//                 //         child: Column(
//                 //           children: [
//                 //             LottieBuilder.asset(Assets.lottie.disconnected,width: 100,fit: BoxFit.cover,),
//                 //             SizedBox(height: 10,),
//                 //             Text("Internet Disconnected",style: GoogleFonts.inter(fontSize: 16,fontWeight: FontWeight.bold),)
//                 //           ],
//                 //         )
//                 //       ): SizedBox.shrink(),
//                   ],
//                 ),
//               ),
//       )
//     );
   
//   }

//   void _clearCache() {
//     DefaultCacheManager().emptyCache();
//   }
// }
