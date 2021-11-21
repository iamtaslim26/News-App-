import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_news_app/helper/news_data.dart';
import 'package:flutter_news_app/model/news_model.dart';

class CategoryPage extends StatefulWidget {
  //const CategoryPage({Key? key}) : super(key: key);

  final String category;

  const CategoryPage({Key key, this.category}) : super(key: key);

  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {

  List<NewsModel>newsModel=List<NewsModel>();
  //NewsData newsData=NewsData();

  bool isLoading=true;


  getNews()async{
    CategoryNews news=CategoryNews();
    await news.getNews(widget.category);
    newsModel=news.dataToBeSavedList;

    setState(() {
      isLoading=false;
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getNews();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category.toUpperCase(),style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),),
        centerTitle: true,
      ),
      body: isLoading?
          Center(child: CircularProgressIndicator(),)
          :SingleChildScrollView(
        child: Container(
          child: ListView.builder(
            physics: ScrollPhysics(),
            itemCount: newsModel.length,
              shrinkWrap: true,
              itemBuilder: (context,index){
                return NewsTile(
                  title: newsModel[index].title,
                  description: newsModel[index].description,
                  urlToImage: newsModel[index].urlToImage,

                );
              }
          ),
        ),
      ),
    );
  }
}

class NewsTile extends StatelessWidget {
  //const NewsTile({Key? key}) : super(key: key);

  final String title,description,url,urlToImage,author;

  const NewsTile({Key key, this.title, this.description, this.url, this.urlToImage, this.author}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(10.0),
        child: Column(

          children: [

            ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: CachedNetworkImage(
                imageUrl:urlToImage,
                height: MediaQuery.of(context).size.height/4,
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.cover,
              ),
            ),


            ListTile(
              title:Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(title,style: TextStyle(color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
                ),
              ),
              subtitle: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(description,
                  maxLines: 1000,
                  style: TextStyle(
                      fontStyle: FontStyle.normal,
                      color: Colors.blue
                  ),),
              ),
              // trailing: Text(author,
              //   style: TextStyle(
              //     color: Colors.black,
              //     fontWeight: FontWeight.w700
              //   ),),
              // )
            ) ],
        )
    );
  }
}
