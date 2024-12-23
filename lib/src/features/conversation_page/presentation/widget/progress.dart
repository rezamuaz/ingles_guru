

// class ProgressScene extends StatefulWidget {
//   const ProgressScene({super.key, required this.pages});
//    final List<dynamic>? pages;
//   @override
//   State<ProgressScene> createState() => _ProgressSceneState();
// }
// const completeColor = Colors.black12;
// const inProgressColor = Colors.black26;
// const todoColor = Colors.black54;
// class _ProgressSceneState extends State<ProgressScene> {
//   final int _processIndex = 2;
  
//   Color getColor(int index) {
//     if (index == _processIndex) {
//       return inProgressColor;
//     } else if (index < _processIndex) {
//       return completeColor;
//     } else {
//       return todoColor;
//     }}
//   @override
//   Widget build(BuildContext context) {
//     return Timeline.tileBuilder(      
//                 theme: TimelineThemeData(
//                   direction: Axis.horizontal,
//                   connectorTheme: const ConnectorThemeData(
//                     space: 30.0,
//                     thickness: 5.0,
//                   ),
//                 ),
//                 builder: TimelineTileBuilder.connected(
//                   connectionDirection: ConnectionDirection.before,
//                   itemExtentBuilder: (_, __) =>
//                       MediaQuery.of(context).size.width / (widget.pages!.length) ,
                 
//                   contentsBuilder: (context, index) {
//                     return Text(
//                       (index+1).toString(),
//                       style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                         color: getColor(index),
//                       ),
//                     );
//                   },
//                   indicatorBuilder: (_, index) {
//                     Color color;
//                     var child;
//                     if (index == _processIndex) {
//                       color = inProgressColor;
//                       child =  Padding(
//                         padding: const EdgeInsets.all(5.0),
//                         child: CircularProgressIndicator(

//                           strokeWidth: 2.0,
//                           valueColor: AlwaysStoppedAnimation(Theme.of(context).colorScheme.primary),
//                         ),
//                       );
//                     } else if (index < _processIndex) {
//                       color = completeColor;
//                       child =  const Icon(
//                         Icons.check_sharp,
//                         color: Colors.black87,
                        
//                         size: 15.0,
//                       );
//                     } else {
//                       color = todoColor;
//                       child = const Icon(Icons.circle,color: Colors.white,size: 15,);
//                     }
                
//                     if (index <= _processIndex) {
//                       return Stack(
//                         children: [
//                           CustomPaint(
//                             size: const Size(20.0, 20.0),
//                             painter: BezierPainter(
//                               color: color,
//                               drawStart: index > 0,
//                               drawEnd: index < _processIndex,
//                             ),
//                           ),
//                           DotIndicator(
//                             size: 20.0,
//                             color: color,
//                             child: child,
//                           ),
//                         ],
//                       );
//                     } else {
//                       return Stack(
//                         children: [
//                           CustomPaint(
//                             size: const Size(20.0, 20.0),
//                             painter: BezierPainter(
//                               color: color,
//                               drawEnd: index < (widget.pages!.length) - 1,
//                             ),
//                           ),
//                           OutlinedDotIndicator(
//                             size: 20,
//                             borderWidth: 4.0,
//                             backgroundColor: Colors.white,
//                             color: color,
//                           ),
//                         ],
//                       );
//                     }
//                   },
//                   connectorBuilder: (_, index, type) {
//                     if (index > 0) {
//                       if (index == _processIndex) {
//                         final prevColor = getColor(index - 1);
//                         final color = getColor(index);
//                         List<Color> gradientColors;
//                         if (type == ConnectorType.start) {
//                           gradientColors = [Color.lerp(prevColor, color, 0.5)!, color];
//                         } else {
//                           gradientColors = [
//                             prevColor,
//                             Color.lerp(prevColor, color, 0.5)!
//                           ];
//                         }
//                         return DecoratedLineConnector(
//                           decoration: BoxDecoration(
//                             gradient: LinearGradient(
//                               colors: gradientColors,
//                             ),
//                           ),
//                         );
//                       } else {
//                         return SolidLineConnector(
//                           color: getColor(index),
//                         );
//                       }
//                     } else {
//                       return null;
//                     }
//                   },
//                   itemCount: widget.pages!.length,
//                 ),
//                       );
//   }
// }