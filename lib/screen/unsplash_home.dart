
import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'package:omdb_api/models/api_model.dart';
import 'package:omdb_api/models/topic_api.dart';
import 'package:omdb_api/screen/photo_detail.dart';

import '../models/photo_model.dart';


class HomeScreen extends StatefulWidget {
   HomeScreen({Key? key, }) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var selectedIndex = 0;
  List<String> dropList=['Company','About','Advertisement','Blog','History','Join the team','Press''Contact us','Help',];
  List<String> dropList2=['Developers/Api','UnSplash Dataset','Unsplash for IOS','Apps & Plugins',];
  List<String> dropList3=['Become a Contributor','Topics','Collections','Trends','Unsplash Award','Stats'];
  List<String> dropList4=['License','Privacy Policy','Terms','Security',];
  var myInitialItem = 'Company';
  var myInitialItem2 = 'Developers/Api';
  var myInitialItem3 = 'Become a Contributor';
  var myInitialItem4 = 'License';

  late StreamController streamController;
  late Stream stream;
  late StreamController photoController;
  late Stream photoStream;
  getAllPhotos(String photoUrl)async
  {
    photoController.add('loading');
    var AllPhotoUrl = Config.getPhotos(photoUrl);
    http.Response response =await http.get(Uri.parse(AllPhotoUrl));

    if(response.statusCode==200)
      {
        var jsonData = json.decode(response.body);
        List<Photo> photoList = [];
        for(var jsonPhoto in jsonData)
          {
            Photo photo = Photo.fromJson(jsonPhoto);
           photoList.add(photo);

          }
        photoController.add(photoList);
      }

    else{
      return photoController.add('wrong');
    }
  }
  getAllTopic()async{
   http.Response response = await http.get(Uri.parse(Config.topicUrl));
   if(response.statusCode==200)
     {
        var jsonList = json.decode(response.body);
        List<Topic> topicList =[];
        for(var jsonTopic in jsonList)
          {
            Topic topic = Topic.fromJson(jsonTopic);
            topicList.add(topic);
          }
        streamController.add(topicList);
        getAllPhotos(topicList[0].photos);
     }
   else
     {
       streamController.add('wrong');
     }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    streamController = StreamController();
    stream = streamController.stream;
    streamController.add('loading');

    photoController = StreamController();
    photoStream = photoController.stream;
    getAllTopic();


  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Image.asset('images/unsplash.png',fit: BoxFit.cover,),
        title: Expanded(
          child: Container(

            height: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              color: Color(0XFFeeeeee)

            ),
            child: const Center(
              child: TextField(
                textAlign: TextAlign.center,

                decoration: InputDecoration(
                  border: InputBorder.none,
                  suffixIcon: Icon(Icons.search,color: Colors.black,),
                  hintText: 'Search Photos',
                ),
              ),
            ),
          ),
        ),



      ),

      endDrawer: Drawer(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              SizedBox(height: 40,),
              Container(
                height: 20,
              color: Colors.white,
                child: Text('Profile',style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue,fontSize: 20),),
              ),
              SizedBox(height: 20,),
              Container(
                width: 120,
                height: 100,
                child: CircleAvatar(
               child: ClipOval(
                 child: Image.asset('images/mian.jpg',fit: BoxFit.cover,),
               ),
                ),
              ),
              Divider(),
              SizedBox(height: 30,),
              DropdownButtonHideUnderline(

                child: DropdownButton(

                  onChanged: (value) {

                    setState(() {
                      myInitialItem=value.toString();
                    });
                  },
                    value: myInitialItem,
                    items: dropList.map((items) {
                  return DropdownMenuItem(
                      value:items,

                      child: Text(items.trim()));
                }).toList(), ),
              ),
              Divider(),
              SizedBox(height: 20,),
              DropdownButtonHideUnderline(

                child: DropdownButton(

                  onChanged: (value) {

                    setState(() {
                      myInitialItem2=value.toString();
                    });
                  },
                  value: myInitialItem2,
                  items: dropList2.map((items) {
                    return DropdownMenuItem(
                        value:items,

                        child: Text(items.trim()));
                  }).toList(), ),
              ),
              Divider(),
              SizedBox(height: 20,),
              DropdownButtonHideUnderline(

                child: DropdownButton(

                  onChanged: (value) {

                    setState(() {
                      myInitialItem3=value.toString();
                    });
                  },
                  value: myInitialItem3,
                  items: dropList3.map((items) {
                    return DropdownMenuItem(
                        value:items,

                        child: Text(items.trim()));
                  }).toList(), ),
              ),
              Divider(),
              SizedBox(height: 20,),
              DropdownButtonHideUnderline(

                child: DropdownButton(

                  onChanged: (value) {

                    setState(() {
                      myInitialItem4=value.toString();
                    });
                  },
                  value: myInitialItem4,
                  items: dropList4.map((items) {
                    return DropdownMenuItem(
                        value:items,

                        child: Text(items.trim()));
                  }).toList(), ),
              ),

              SizedBox(height: 20,),
              Divider(
                thickness: 3,
                color: Colors.grey,
              ),
              SizedBox(height: 20,),
              SizedBox(
                width: 200,
                height: 40,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.white70,
                    ),
                    onPressed: (){}, child: Text('Submit a photo',style: TextStyle(color: Colors.black45),)),
              ),
          ])
        ),
      ),

        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Trending Topics',style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                letterSpacing: 0.5,
              ),),

              Container(
                margin: EdgeInsets.symmetric(vertical: 20),
                height: 50,
                child: StreamBuilder(stream: stream,
                builder: (context,snapshot){
                  if(snapshot.hasData)
                    {
                      if(snapshot.data=='loading')
                        {
                          return Center(child: CircularProgressIndicator(
                            color: Colors.blue,
                          ),);
                        }
                      else if(snapshot.data=='wrong')
                        {
                          return Center(child: Text('Something went wrong'),);
                        }
                      else{
                        List<Topic> topics = snapshot.data as List<Topic>;
                        return ListView.builder(
                          scrollDirection: Axis.horizontal,
                            itemCount: topics.length,
                            itemBuilder: (context,index){
                              return InkWell(
                                onTap: (){
                                setState(() {
                                  selectedIndex = index;

                                });
                                getAllPhotos(topics[index].photos);

                                },
                                child: Container(

                                  margin: EdgeInsets.only(right: 15),
                                    padding: EdgeInsets.all(15),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                     color: selectedIndex == index? Colors.blue: Colors.black12,

                                    ),
                                    child: Center(child: Text(topics[index].title,style: TextStyle(fontWeight: FontWeight.bold,
                                    color: selectedIndex == index ? Colors.white: Colors.black,
                                    ),))),
                              );
                        });
                      }

                    }
                  else
                    {
                      return Center(child: CircularProgressIndicator(
                        color: Colors.blue,
                      ),
                      );
                    }
                },
                ),
              ),
              Text('Photos',style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                letterSpacing: 0.5,
              ),),
              SizedBox(height: 20,),
              Expanded(
                child: Container(

                  child: StreamBuilder(stream: photoStream,
                    builder: (context,snapshot){
                      if(snapshot.hasData)
                      {
                        if(snapshot.data=='loading')
                        {
                          return Center(child: CircularProgressIndicator(
                            color: Colors.blue,
                          ),);
                        }
                        else if(snapshot.data=='wrong')
                        {
                          return Center(child: Text('Something went wrong'));
                        }
                        else{

                          List<Photo> photo = snapshot.data! as List<Photo>;
                          return GridView.builder(
                              itemCount: photo.length,
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisSpacing: 10,
                                crossAxisSpacing: 10,

                              ), itemBuilder: (context,index)

                          {
                            Photo photos = photo[index];
                            return Expanded(
                              child: InkWell(
                                onTap: (){
                                 Navigator.of(context).push(MaterialPageRoute(builder: (context){
                                   return PhotoDetail(photo:photos);
                                 }));
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                      image: DecorationImage(fit: BoxFit.cover,
                                        image: NetworkImage(photos.thumb),
                                      )
                                  ),
                                ),
                              ),
                            );
                          });
                        }
                      }
                      else
                      {
                        return Center(child: CircularProgressIndicator(),);
                      }
                    },
                  ),
                ),
              )

            ],
          ),
        ) ,

    );
  }
}
