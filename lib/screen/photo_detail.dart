import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:omdb_api/models/photo_model.dart';
import 'package:wallpaper_manager_flutter/wallpaper_manager_flutter.dart';

class PhotoDetail extends StatefulWidget {
  const PhotoDetail({Key? key, required this.photo}) : super(key: key);

  final Photo photo;

  @override
  _PhotoDetailState createState() => _PhotoDetailState();
}

class _PhotoDetailState extends State<PhotoDetail> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          clipBehavior: Clip.none,

          children: [
        Positioned.fill(child: Image.network(widget.photo.regular,
          fit: BoxFit.cover,)),
    Positioned(
    bottom: 50,
    left: 30,
    right: 30,
    child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [

    OutlinedButton(
        style: OutlinedButton.styleFrom(backgroundColor: Colors.black45),
      child: Text('Download',style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        onPressed:()async{


    bool? result =await GallerySaver.saveImage(widget.photo.regular +'.jpg'); {

    if(result !=null && result == true)
    {
    Fluttertoast.showToast(msg: 'Image Downloaded');}
    }
    } ),

      OutlinedButton(
        style: OutlinedButton.styleFrom(backgroundColor: Colors.black45),
        onPressed: ()async{
        File cachedimage = await DefaultCacheManager().getSingleFile(widget.photo.regular);  //image file

        int location = await WallpaperManagerFlutter.HOME_SCREEN;

        Fluttertoast.showToast(msg: 'Wallpaper is set');//Choose screen type

        WallpaperManagerFlutter().setwallpaperfromFile(cachedimage, location);


      }
      ,child: Text('Set Wallpaper',style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
      )

  ]
  )
  )
  ],),);
}}
