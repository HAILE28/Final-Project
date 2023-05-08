import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ijob_clone_app/Jobs/job_details.dart';
import 'package:ijob_clone_app/Services/global_methods.dart';
import 'package:ijob_clone_app/Jobs/job_details.dart';

class JobWidget extends StatefulWidget {
  final String jobTitle;
  final String jobDescribtion;
  final String jobId;
  final String uploadedBy;
  final String userImage;
  final String name;
  final String recruitment;
  final String email;
  final String location;
  const JobWidget(
      {required this.jobTitle,
      required this.jobDescribtion,
      required this.jobId,
      required this.uploadedBy,
      required this.userImage,
      required this.name,
      required this.recruitment,
      required this.email,
      required this.location});

  @override
  State<JobWidget> createState() => _JobWidgetState();
}

final FirebaseAuth _auth = FirebaseAuth.instance;

class _JobWidgetState extends State<JobWidget> {
  _deleteDailog() {
    User? user = _auth.currentUser;
    final _uid = user!.uid;

    showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            actions: [
              TextButton(
                  onPressed: (() async {
                    try {
                      if (widget.uploadedBy == _uid) {
                        await FirebaseFirestore.instance
                            .collection('jobs')
                            .doc(widget.jobId)
                            .delete();
                        await Fluttertoast.showToast(
                            msg: 'Job has been Deleted',
                            toastLength: Toast.LENGTH_LONG,
                            backgroundColor: Colors.grey,
                            fontSize: 18.0);
                        Navigator.canPop(context)
                            ? Navigator.pop(context)
                            : null;
                      } else {
                        GlobalMethod.showErrorDialog(
                            error: 'YOu can Not perform this action', ctx: ctx);
                      }
                    } catch (error) {
                      GlobalMethod.showErrorDialog(
                          error: 'this cant not be Deleted', ctx: ctx);
                    }
                  }),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                      Text(
                        'Delete',
                        style: TextStyle(
                          color: Colors.red,
                        ),
                      )
                    ],
                  ))
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color.fromARGB(255, 254, 255, 255),
      elevation: 8,
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(color: Colors.grey, width: 1),
      ),
      child: ListTile(
        onTap: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => JobDetailScreen(
                uploadedBy: widget.uploadedBy,
                jobId: widget.jobId,
              ),
            ),
          );
        },
        onLongPress: () {
          _deleteDailog();
        },
        contentPadding: EdgeInsets.all(0),
        leading: Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            image: DecorationImage(
              image: NetworkImage(widget.userImage),
              fit: BoxFit.cover,
            ),
          ),
        ),
        title: Card(
          margin: EdgeInsets.all(0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          color: Colors.cyan,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
            child: Text(
              widget.jobTitle,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 8),
            Card(
              margin: EdgeInsets.all(0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                child: Text(
                  widget.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
              ),
            ),
            SizedBox(height: 8),
            Card(
              margin: EdgeInsets.all(0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                child: Text(
                  widget.jobDescribtion,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                  ),
                ),
              ),
            ),
          ],
        ),
        trailing: Icon(
          Icons.keyboard_arrow_right,
          size: 30,
          color: Colors.black,
        ),
      ),
    );

    // Card(
    //   color: Color.fromARGB(255, 254, 255, 255),
    //   elevation: 8,
    //   margin: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
    //   shape: RoundedRectangleBorder(
    //     borderRadius: BorderRadius.circular(10),
    //     side: BorderSide(color: Colors.grey, width: 1),
    //   ),
    //   child: ListTile(
    //     onTap: () {
    //       Navigator.pushReplacement(
    //         context,
    //         MaterialPageRoute(
    //           builder: (context) => JobDetailScreen(
    //             uploadedBy: widget.uploadedBy,
    //             jobId: widget.jobId,
    //           ),
    //         ),
    //       );
    //     },
    //     onLongPress: () {
    //       _deleteDailog();
    //     },
    //     contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 18),
    //     leading: Container(
    //       padding: EdgeInsets.only(right: 12),
    //       decoration: BoxDecoration(
    //         border: Border(
    //           right: BorderSide(width: 1, color: Colors.grey),
    //         ),
    //       ),
    //       child: Image.network(widget.userImage),
    //     ),
    //     title: Text(
    //       widget.jobTitle,
    //       maxLines: 2,
    //       overflow: TextOverflow.ellipsis,
    //       style: TextStyle(
    //         color: Colors.cyan,
    //         fontWeight: FontWeight.bold,
    //         fontSize: 18,
    //       ),
    //     ),
    //     subtitle: Column(
    //       crossAxisAlignment: CrossAxisAlignment.start,
    //       children: [
    //         SizedBox(height: 8),
    //         Text(
    //           widget.name,
    //           maxLines: 1,
    //           overflow: TextOverflow.ellipsis,
    //           style: TextStyle(
    //             color: Colors.black,
    //             fontWeight: FontWeight.bold,
    //             fontSize: 13,
    //           ),
    //         ),
    //         SizedBox(height: 8),
    //         Text(
    //           widget.jobDescribtion,
    //           maxLines: 3,
    //           overflow: TextOverflow.ellipsis,
    //           style: TextStyle(
    //             color: Colors.black,
    //             fontSize: 15,
    //           ),
    //         ),
    //       ],
    //     ),
    //     trailing: Icon(
    //       Icons.keyboard_arrow_right,
    //       size: 30,
    //       color: Colors.black,
    //     ),
    //   ),
    // );

    // Card(
    //   color: Color.fromARGB(255, 254, 255, 255),
    //   elevation: 8,
    //   margin: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
    //   child: ListTile(
    //     onTap: () {
    //       Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => JobDetailScreen(

    //         uploadedBy: widget.uploadedBy,
    //         jobId: widget.jobId,
    //       ),));
    //     },
    //     onLongPress: () {
    //       _deleteDailog();
    //     },
    //     contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 18),
    //     leading: Container(
    //       padding: EdgeInsets.only(right: 12),
    //       decoration:
    //           const BoxDecoration(border: Border(right: BorderSide(width: 1))),
    //       child: Image.network(widget.userImage),
    //     ),
    //     title: Text(
    //       widget.jobTitle,
    //       maxLines: 2,
    //       overflow: TextOverflow.ellipsis,
    //       style: const TextStyle(
    //         color: Colors.cyan,
    //         fontWeight: FontWeight.bold,
    //         fontSize: 18,
    //       ),
    //     ),
    //     subtitle: Column(
    //       children: [
    //         Text(
    //           widget.name,
    //           maxLines: 2,
    //           overflow: TextOverflow.ellipsis,
    //           style: const TextStyle(
    //             color: Colors.black,
    //             fontWeight: FontWeight.bold,
    //             fontSize: 13,
    //           ),
    //         ),
    //         const SizedBox(
    //           height: 8,
    //         ),
    //         Text(
    //           widget.jobDescribtion,
    //           maxLines: 4,
    //           overflow: TextOverflow.ellipsis,
    //           style: const TextStyle(
    //             color: Colors.black,
    //             fontSize: 15,
    //           ),
    //         ),
    //       ],
    //     ),
    //     trailing: const Icon(
    //       Icons.keyboard_arrow_right,
    //       size: 30,
    //       color: Colors.black,
    //     ),
    //   ),
    // );
  }
}
