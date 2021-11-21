import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_news_app/model/news_model.dart';
import 'package:http/http.dart';

class NewsData{

  List<NewsModel>dataToBeSavedList=[];

 Future getNews()async{

   var response=await get("https://newsapi.org/v2/top-headlines?country=us&apiKey=4d2fed8f96e34ea688bc26e87dd2ce3a");
   var jsonData=jsonDecode(response.body);

   if(jsonData["status"]=="ok"){
     jsonData["articles"].forEach((element){

       if(element["urlToImage"]!=null &&element["description"]!=null ){

         // Now Initialze our model class

         NewsModel newsModel=NewsModel(

           title: element["title"],
           author: element["author"],
           description: element["description"],
           url: element["url"],
           urlToImage: element["urlToImage"]
         );

         dataToBeSavedList.add(newsModel);
       }
     });
   }
  }
}

class CategoryNews{

  List<NewsModel>dataToBeSavedList=[];


  Future getNews(String category)async{

    var response=await get("https://newsapi.org/v2/top-headlines?country=us&category=$category&apiKey=4d2fed8f96e34ea688bc26e87dd2ce3a");
    var jsonData=jsonDecode(response.body);

    if(jsonData["status"]=="ok"){
      jsonData["articles"].forEach((element){

        if(element["urlToImage"]!=null &&element["description"]!=null){

          // Now Initialze our model class

          NewsModel newsModel=NewsModel(

              title: element["title"],
              author: element["author"],
              description: element["description"],
              url: element["url"],
              urlToImage: element["urlToImage"]
          );

          dataToBeSavedList.add(newsModel);
        }
      });
    }
  }
}