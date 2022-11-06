import 'package:flutter/material.dart';
import 'package:home_body/Party/party_detail_nonwriterview.dart';
import 'package:home_body/Party/party_detail_writerview.dart';
import 'package:home_body/Party/party_writeview.dart';
import 'package:home_body/color.dart';

import '../Home/home_mainview.dart';
import '../dummy/party_dummydata.dart';


class PartyMainPage extends StatefulWidget {
  const PartyMainPage({Key? key}) : super(key: key);

  @override
  State<PartyMainPage> createState() => _PartyMainPageState();
}

class _PartyMainPageState extends State<PartyMainPage> {
  //data
  String currentLocation="total";
  late PartyDummydata partydummydata;
  int isChecked = 0;

  final Map<String,String> locationTypeToString={
    "total": "전체",
    "netflix":"넷플릭스",
    "watcha":"왓챠",
    "disneyplus":"디즈니플러스",
    "wave":"웨이브",
    "appletv":"애플티비",
    "tving":"티빙",
  };
  
  //data 초기화
  @override
  void initState(){
    super.initState();
    partydummydata=PartyDummydata();
  }

  //상단 appbar 위젯
  PreferredSizeWidget _appbarWidget(){
    return AppBar(
      title: Text("파티모집",style:TextStyle(fontWeight: FontWeight.bold,color:Color(mainColor))),
      backgroundColor: Colors.white,
      elevation: 0.0, //appbar 그림자 제거
      automaticallyImplyLeading: true,
      leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Color(0xff333333),
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomeMainPage()),
            );
          }),
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
                print(where);
                setState(() {
                  currentLocation=where;
                });
              },
              itemBuilder: (BuildContext context){
                return [
                  PopupMenuItem(value: "total", child:Text("전체")),
                  PopupMenuItem(value: "netflix", child:Text("넷플릭스")),
                  PopupMenuItem(value: "watcha", child:Text("왓챠")),
                  PopupMenuItem(value: "disneyplus", child:Text("디즈니플러스")),
                  PopupMenuItem(value: "wave", child:Text("웨이브")),
                  PopupMenuItem(value: "appletv", child:Text("애플티비")),
                  PopupMenuItem(value: "tving", child:Text("티빙")),
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

  _makeDataList(List<Map<String,String>> datas){
    return ListView.separated(
      itemBuilder: (BuildContext _context, int index){
        return GestureDetector(
          onTap: (){
            if(isChecked == 1){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PartyDetailNonWriterPage()),
              );
            }
            else{
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PartyDetailWriterPage()),
              );
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
                          datas[index]["title"]!,
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
                                "${datas[index]["curPeople"]!}/${datas[index]["maxPeople"]!}",
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
                                color: datas[index]["curPeople"]! == datas[index]["maxPeople"]!? Colors.red : Colors.green,
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
                    datas[index]["writer"]!,
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
                        Text(datas[index]["ott"]!),
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
                        Text(datas[index]["period"]!),
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
                        Text(datas[index]["price"]!),
                      ],
                    )
                ),
              ],
            ),
          )
        );
      },
      itemCount: 10,
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
            if (snapshot.connectionState != ConnectionState.done) {
              return Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(child: Text("데이터 오류"));
            }
            if (snapshot.hasData) {
              return _makeDataList(snapshot.data);
            }
            return Center(child: Text("해당 지역에 데이터 없습니다."));
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
