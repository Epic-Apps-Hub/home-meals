import 'package:flutter/material.dart';
import 'package:home_made/constants.dart';
import 'package:home_made/views/unAuthed/login.dart';

class ChooseCountry extends StatefulWidget {
  @override
  _ChooseCountryState createState() => _ChooseCountryState();
}

class _ChooseCountryState extends State<ChooseCountry> {
  Widget buildCountryListTile(String picUrl, String name) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: ListTile(
        onTap: () {
        
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (ctx) => LoginPage()));
        },
        trailing: Icon(
          Icons.arrow_forward_ios,
          color: yellow,
        ),
        title: Text(
          name,
          style: TextStyle(
              color: Colors.black,
              fontFamily: 'tajwal',
              fontSize: 22,
              fontWeight: FontWeight.w800),
        ),
        leading: CircleAvatar(
          radius: 25,
          backgroundColor: yellow,
          backgroundImage: NetworkImage(picUrl),
        ),
      ),
    );
  }

 

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.height;
    final _width = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          brightness: Brightness.dark,
          title: Text(
            "اين نوصل طلبك؟",
            style: TextStyle(color: Colors.black, fontFamily: 'tajwal'),
          ),
          centerTitle: true,
          iconTheme: IconThemeData(color: Colors.black),
        ),
        body: Container(
          child: Center(
            child: ListView(
              children: [
                SizedBox(
                  height: _height * .02,
                ),
                buildCountryListTile(
                    "https://modo3.com/thumbs/fit630x300/69946/1447851074/%D9%83%D9%85_%D8%B9%D8%AF%D8%AF_%D8%A3%D9%84%D9%88%D8%A7%D9%86_%D8%B9%D9%84%D9%85_%D8%A7%D9%84%D9%83%D9%88%D9%8A%D8%AA.jpg",
                    "الكويت"),
                buildCountryListTile(
                    "https://www.marefa.org/images/thumb/0/0d/Flag_of_Saudi_Arabia.svg/1200px-Flag_of_Saudi_Arabia.svg.png",
                    "السعودية"),
                buildCountryListTile(
                    "https://gawlah.com/wp-content/uploads/2020/05/1.jpg",
                    "البحرين"),
                buildCountryListTile(
                    "https://upload.wikimedia.org/wikipedia/commons/thumb/c/cb/Flag_of_the_United_Arab_Emirates.svg/280px-Flag_of_the_United_Arab_Emirates.svg.png",
                    "الامارات"),
                buildCountryListTile(
                    "https://upload.wikimedia.org/wikipedia/commons/thumb/d/dd/Flag_of_Oman.svg/280px-Flag_of_Oman.svg.png",
                    "عمان"),
                buildCountryListTile(
                    "https://e3arabi.com/wp-content/uploads/2019/12/qatar-162396_1280.png",
                    "قطر"),
                buildCountryListTile(
                    "https://upload.wikimedia.org/wikipedia/commons/thumb/c/c0/Flag_of_Jordan.svg/560px-Flag_of_Jordan.svg.png",
                    "الأردن"),
                buildCountryListTile(
                    "https://upload.wikimedia.org/wikipedia/commons/thumb/f/fe/Flag_of_Egypt.svg/250px-Flag_of_Egypt.svg.png",
                    "مصر"),
                buildCountryListTile(
                    "https://alamphoto.com/wp-content/uploads/2018/01/Iraq-Flag-8.jpg",
                    "العراق"),
                SizedBox(
                  height: _height * .05,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
