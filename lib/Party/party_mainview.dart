import 'dart:io';

import 'package:flutter/material.dart';
import 'package:home_body/Party/party_detail_nonwriterview.dart';
import 'package:home_body/Party/party_detail_writerview.dart';
import 'package:home_body/Party/party_writeview.dart';
import 'package:home_body/color.dart';

import '../Login/login.dart';
import '../Home/home_mainview.dart';
import '../dummy/party_dummydata.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../server.dart';



class PartyMainPage extends StatefulWidget {

  const PartyMainPage({Key? key}) : super(key: key);

  @override
  State<PartyMainPage> createState() => _PartyMainPageState();
}

final partyList = new List<PartyList>.empty(growable: true);

final isEnabled = new List <bool>.empty(growable: true);

final userName = new List <String>.empty(growable: true);
final userPhone = new List <String>.empty(growable: true);

final userId = new List <int>.empty(growable: true);

String writer = "글쓴이";
String title = "넷플릭스 함께 봐요";
String ottType = "넷플릭스";
String startDate = "2022-11-05";
String endDate = "2022-12-31";
int price = 4250;
int maxPeople = 3;
int curPeople = 1;

fetchPost(String where) async {

  partyList.clear();

  if(where == "total"){
    var url = Uri.parse('${serverHttp}/party/gather');
    var response = await http.get(url, headers: {'Accept': 'application/json', "content-type": "application/json", "Authorization": "Bearer ${authToken}" });



    if (response.statusCode == 200) {
      // 만약 서버로의 요청이 성공하면, JSON을 파싱합니다.

      var body = jsonDecode(response.body);

      dynamic data = body["parties"];

      if(data.length != 0){
        for(dynamic i in data){
          int partyId = i['partyId'];
          String authorName = i['authorName'];
          String title = i['title'];
          String startDate = i['startDate'];
          String endDate = i['endDate'];
          int numOfPeople = i['numOfPeople'];
          int joinedPeopleCount = i['joinedPeopleCount'];
          String type = i['type'];
          int cost = i['cost'];
          String ott = i['ott'];
          bool isOwner = i['isOwner'];

          partyList.add(PartyList(partyId, authorName, title, startDate, endDate, numOfPeople, joinedPeopleCount, type, cost, ott, isOwner));
        }

      }

    } else {
      // 만약 요청이 실패하면, 에러를 던집니다.
      throw Exception('Failed to load post');
    }
  }
  else{

    Map<String, String> _queryParameters = <String, String>{
      'ott': where.toString()
    };

    var url = Uri.parse('${serverHttp}/party/gather?ott=${where}');

    var response = await http.get(url, headers: {'Accept': 'application/json', "content-type": "application/json", "Authorization": "Bearer ${authToken}" });


    if (response.statusCode == 200) {
      // 만약 서버로의 요청이 성공하면, JSON을 파싱합니다.

      var body = jsonDecode(response.body);

      dynamic data = body["parties"];

      if(data.length != 0){
        for(dynamic i in data){
          int partyId = i['partyId'];
          String authorName = i['authorName'];
          String title = i['title'];
          String startDate = i['startDate'];
          String endDate = i['endDate'];
          int numOfPeople = i['numOfPeople'];
          int joinedPeopleCount = i['joinedPeopleCount'];
          String type = i['type'];
          int cost = i['cost'];
          String ott = i['ott'];
          bool isOwner = i['isOwner'];

          partyList.add(PartyList(partyId, authorName, title, startDate, endDate, numOfPeople, joinedPeopleCount, type, cost, ott, isOwner));
        }

      }

    } else {
      // 만약 요청이 실패하면, 에러를 던집니다.
      throw Exception('Failed to load post');
    }



  }



}

class Post {
  final int partyId;
  final String authorName;
  final String title;
  final String startDate;
  final String endDate;
  final int numOfPeople;
  final int joinedPeopleCount;
  final String type;
  final int cost;
  final String ott;
  final bool isOwner;

  Post({required this.partyId, required this.authorName, required this.title, required this.startDate, required this.endDate, required this.numOfPeople, required this.joinedPeopleCount, required this.type, required this.cost, required this.ott, required this.isOwner});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      partyId: json['userId'],
      authorName: json['id'],
      title: json['title'],
      startDate: json['body'],
      endDate: json['endDate'],
      numOfPeople: json['numOfPeople'],
      joinedPeopleCount: json['joinedPeopleCount'],
      type: json['type'],
      cost: json['cost'],
      ott: json['ott'],
      isOwner: json['isOwner'],
    );
  }
}

class _PartyMainPageState extends State<PartyMainPage> {
  //data
  String currentLocation="total";
  late PartyDummydata partydummydata;
  int isChecked = 0;

  late Future<Post> post;

  final Map<String,String> locationTypeToString={
    "total": "전체",
    "NETFLIX":"넷플릭스",
    "WATCHA":"왓챠",
    "DISNEYPLUS":"디즈니플러스",
    "WAVVE":"웨이브",
    "APPLETV":"애플티비",
    "TVING":"티빙",
    "TVING":"티빙",
  };

  detailViewInfo(int partyId, bool isOwner) async {

    isEnabled.clear();
    userName.clear();
    userPhone.clear();
    userId.clear();

    var url = Uri.parse('${serverHttp}/party/gather/${partyId.toString()}');
    print(url);
    print("authToken: ${authToken}");
    var response = await http.get(url, headers: {'Accept': 'application/json', "content-type": "application/json", "Authorization": "Bearer ${authToken}" });

    print(url);

    print("status: ${response.statusCode}");

    if (response.statusCode == 200) {
      // 만약 서버로의 요청이 성공하면, JSON을 파싱합니다.

      dynamic i = jsonDecode(response.body);

      print(i);

      int partyId = i['partyId'];
      writer = i['authorName'];
      title = i['title'];
      startDate = i['startDate'];
      endDate = i['endDate'];
      maxPeople = i['numOfPeople'];
      curPeople = i['joinedPeopleCount'];
      //ottType = i['type'];
      price = i['cost'];
      ottType = i['ott'];


      if (isOwner == true){
        dynamic data = i["participants"];


        for(dynamic x in data){
          int id = x['id'];
          String name = x['name'];
          bool selected = x['isSelected'];
          String contact = x['contact'];

          isEnabled.add(selected);
          userName.add(name);
          userPhone.add(contact);
          userId.add(id);

        }

        Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => PartyDetailWriterPage(partyId: partyId,)),
        );
      }
      else{
        Navigator.push(context, MaterialPageRoute(builder: (context) => PartyDetailNonWriterPage(partyId: partyId,)),
        );
      }



      print("here");
    } else {
      // 만약 요청이 실패하면, 에러를 던집니다.
      throw Exception('Failed to load post');
    }


  }

  void DetailViewInfo(int partyId) async {

    var url = Uri.parse('${serverHttp}/party/gather/${partyId}');

    var response = await http.get(url, headers: {'Accept': 'application/json', "content-type": "application/json", "Authorization": "Bearer ${authToken}" });


    if (response.statusCode == 200) {

      dynamic i = jsonDecode(utf8.decode(response.bodyBytes));

      // dynamic data = body["data"];

      int partyId = i['partyId'];
      String authorName = i['authorName'];
      String title = i['title'];
      String startDate = i['startDate'];
      String endDate = i['endDate'];
      int numOfPeople = i['numOfPeople'];
      int joinedPeopleCount = i['joinedPeopleCount'];
      String type = i['type'];
      int cost = i['cost'];
      String ott = i['ott'];
      bool isOwner = i['isOwner'];


      // urlInfo(letter, letterId);

    }
    else {
      print('error : ${response.reasonPhrase}');
    }

  }


  //data 초기화
  @override
  void initState(){
    super.initState();
    partydummydata=PartyDummydata();
    partyList.clear();
    fetchPost("total");
  }

  //상단 appbar 위젯
  PreferredSizeWidget _appbarWidget(){
    return AppBar(
      title: Text("파티모집",style:TextStyle(fontWeight: FontWeight.bold,color:Color(mainColor))),
      backgroundColor: Colors.white,
      elevation: 0.0, //appbar 그림자 제거
    );
  }

  //toggle search
  Widget _searchWidget(){
    return Column(
      children: [
        //토글 검색창
        GestureDetector(
          onTap:(){
            print("click");
          },
          child: Container(
            //padding: const EdgeInsets.only(left: 40,top: 20,right:8),
            child: PopupMenuButton<String>(
              offset: Offset(0,25),
              shape: ShapeBorder.lerp(
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                1),
              onSelected: (String where){
                print("this is: ${where}");



                // query param
                setState(() {
                  currentLocation=where;
                  fetchPost(where);
                });


              },
              itemBuilder: (BuildContext context){
                return [
                  PopupMenuItem(value: "total", child:Text("전체")),
                  PopupMenuItem(value: "NETFLIX", child:Text("넷플릭스")),
                  PopupMenuItem(value: "WATCHA", child:Text("왓챠")),
                  PopupMenuItem(value: "DISNEYPLUS", child:Text("디즈니플러스")),
                  PopupMenuItem(value: "WAVVE", child:Text("웨이브")),
                  PopupMenuItem(value: "APPLETV", child:Text("애플티비")),
                  PopupMenuItem(value: "TVING", child:Text("티빙")),
                ];
              },
              child: Container(
                padding: const EdgeInsets.only(left: 20,top: 20,right:8),
                child: Row(
                  children: [
                    Text(locationTypeToString[currentLocation].toString(),style:TextStyle(fontWeight: FontWeight.bold,fontSize: 15,color: Color(graytextcolor))),
                    Icon(Icons.arrow_drop_down,size:32,color: Color(mainColor),),
                  ],
                ),
              ),
            ),
          ),
        ),

        //전체보기 가로선
        Divider(
          height: 1,
          indent: 20,
          endIndent: 280,
          color:Color(mainColor),
        ),
      ],
    );
  }

  _loadContents(){
    return partydummydata.loadContentsFromLocation(currentLocation);
  }

  _makeDataList(List<PartyList> partyList){
    return ListView.separated(
      itemCount: partyList.length,
      itemBuilder: (BuildContext _context, int index){
        return GestureDetector(
          onTap: (){
            if(partyList[index].isOwner == false){
              detailViewInfo(partyList[index].partyId, partyList[index].isOwner);
              // Navigator.push(context,
              //   MaterialPageRoute(builder: (context) => PartyDetailNonWriterPage(partyId: partyList[index].partyId,)),
              // );
            }
            else{
              detailViewInfo(partyList[index].partyId, partyList[index].isOwner);
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => PartyDetailWriterPage(partyId: partyList[index].partyId,)),
              // );
            }

          },
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top:10),
                        child: Text(
                          partyList[index].title!,
                          textAlign: TextAlign.left,
                          style:TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Container(
                        child: Row(
                          //mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              child: Text(
                                "${partyList[index].joinedPeopleCount!}/${partyList[index].numOfPeople!}",
                                style:TextStyle(
                                  fontSize: 10,
                                  color:Color(0xff666666),
                                ),
                              ),
                            ),
                            Container(
                              child: Icon(
                                Icons.circle,
                                size: 9,
                                color: partyList[index].joinedPeopleCount! == partyList[index].numOfPeople!? Colors.red : Colors.green,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  child: Text(
                    partyList[index].authorName!,
                    textAlign: TextAlign.left,
                    style:TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: Color(graytextcolor),
                    ),
                  ),
                ),
                Container(
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right:20),
                          child: Text(
                            "OTT",
                            textAlign: TextAlign.left,
                            style:TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: Color(mainColor),
                            ),
                          ),
                        ),
                        Text(partyList[index].ott!),
                      ],
                    )
                ),
                Container(
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right:15),
                          child: Text(
                            "사용기간",
                            textAlign: TextAlign.left,
                            style:TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: Color(mainColor),
                            ),
                          ),
                        ),
                        Text('${partyList[index].startDate.substring(0,10)} ~ ${partyList[index].endDate.substring(0,10)}'!),
                      ],
                    )
                ),
                Container(
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom:10,right:15),
                          child: Text(
                            "예상가격",
                            textAlign: TextAlign.left,
                            style:TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: Color(mainColor),
                            ),
                          ),
                        ),
                        Text('${partyList[index].cost}'!),
                      ],
                    )
                ),
              ],
            ),
          )
        );
      },
      //itemCount: 10,
      separatorBuilder: (BuildContext _context, int index){
        return Container(height: 1, color: Color(mainColor));
      },
    );
  }
  //content 목록
  Widget _bodyWidget() {
    return Container(
      padding: const EdgeInsets.only(left: 10,top: 30,right:10),
      height: MediaQuery.of(context).size.height *0.7,
      width: MediaQuery.of(context).size.width,

      child: FutureBuilder(
        future: _loadContents(),
          builder: (BuildContext context,dynamic snapshot) {
            // if (snapshot.connectionState != ConnectionState.done) {
            //   return Center(child: CircularProgressIndicator());
            // }
            // if (snapshot.hasError) {
            //   return Center(child: Text("데이터 오류"));
            // }
            // if (snapshot.hasData) {
            //   print("length: ${partyList.length}");
            //   return _makeDataList(partyList);
            // }
            // return Center(child: Text("해당 지역에 데이터 없습니다."));
            print("here4");
            return _makeDataList(partyList);
          }
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _appbarWidget(),
      body:
        Column(
          children: [
            _searchWidget(), //toggle search
            _bodyWidget(), //전체 content 목록
          ],
        ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => PartyWritePage()),
          );
        },
        elevation: 0,
        backgroundColor: Color(mainColor),
        child: Icon(Icons.add,color: Colors.white,),
      ),
    );

  }
}
