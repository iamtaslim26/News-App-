import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_news_app/Views/category_page.dart';
import 'package:flutter_news_app/helper/category_data.dart';
import 'package:flutter_news_app/helper/news_data.dart';
import 'package:flutter_news_app/model/categorymodel.dart';
import 'package:flutter_news_app/model/news_model.dart';

class HomePage extends StatefulWidget {
 // const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List<CategoryModel>categories=List<CategoryModel>();
  List<NewsModel>newsModels=List<NewsModel>();

  bool isLoading=true;


  getNews()async{

    NewsData newsData=NewsData();
    await newsData.getNews();
    newsModels=newsData.dataToBeSavedList;
    setState(() {

      isLoading=false;
    });
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    categories=getCategories();

    getNews();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Row(
           mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Flutter",style: TextStyle(color: Colors.black,fontSize: 20),),
            SizedBox(width: 2,),
            Text("News",style: TextStyle(color: Colors.blue,fontSize: 20),),
          ],
        ),
        elevation: 0.0,
      ),
      body: isLoading?
          Center(
            child: CircularProgressIndicator(),
          ):
      SingleChildScrollView(
        child: Container(
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: <Widget>[
                Container(
                  height:MediaQuery.of(context).size.height/5,
                  padding: EdgeInsets.symmetric(horizontal: 12.0),
                  child: ListView.builder(
                    itemCount:categories.length ,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context,index){
                        return CategoryTile(
                          imageUrl: categories[index].imageUrl,
                          categoryName: categories[index].categoryName,


                        );
                      }
                  ),
                ),

                Container(
                  child:SingleChildScrollView(
                    physics: ClampingScrollPhysics(),
                      child: ListView.builder(
                        shrinkWrap: true,
                          physics: ClampingScrollPhysics(),

                          itemCount: newsModels.length,
                          itemBuilder: (context,index){

                            return NewsTile(
                              urlToImage: newsModels[index].urlToImage,
                              title: newsModels[index].title,
                              description: newsModels[index].description,
                             // author: newsModels[index].author==null?" ":newsModels[index].author,

                            );
                          }
                      ),
                  ),
                )
              ],
            ),
          ),
      ),

    );
  }
}

class CategoryTile extends StatelessWidget {
  final String imageUrl,categoryName;

  const CategoryTile({Key key, this.imageUrl, this.categoryName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>CategoryPage(

          category:categoryName.toLowerCase(),
        )));
      },
      child: Container(
        margin: EdgeInsets.only(right: 16),
        child: Stack(
          children: <Widget>[

               ClipRRect(
                 borderRadius: BorderRadius.circular(10.0),
                 child: CachedNetworkImage(
                    imageUrl: imageUrl,
                  height: 220,
                  width: 130,
                  fit: BoxFit.cover,
              ),
               ),


            Container(
              alignment: Alignment.center,
              width: 130,

              decoration: BoxDecoration(
                  color: Colors.black12,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Text(categoryName,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white
                ),
              ),
            )
          ],
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

