
import 'package:firebase_database/firebase_database.dart';


// https://cionman.tistory.com/72
// https://www.slideshare.net/sungbeenjang/firebase-for-web-3-realtime-database
// http://blog.naver.com/PostView.nhn?blogId=wj8606&logNo=221204979652&parentCategoryNo=&categoryNo=10&viewDate=&isShowPopularPosts=true&from=search
// https://stackoverflow.com/questions/26700924/query-based-on-multiple-where-clauses-in-firebase
// https://polyglot-programming.tistory.com/26
// https://stack07142.tistory.com/282
// http://blog.naver.com/PostView.nhn?blogId=wj8606&logNo=221204979652&parentCategoryNo=&categoryNo=10&viewDate=&isShowPopularPosts=true&from=search
// https://grokonez.com/flutter/flutter-firebase-database-example-firebase-database-crud-listview
// https://dart.academy/build-a-real-time-chat-web-app-with-dart-angular-2-and-firebase-3/
// https://beomseok95.tistory.com/114?category=1031942
// https://medium.com/flutter-community/building-a-chat-app-with-flutter-and-firebase-from-scratch-9eaa7f41782e
// https://academy.realm.io/kr/posts/firebase-as-a-real-mobile-backend/
// https://forest71.tistory.com/170
// https://github.com/firebase/functions-samples/blob/master/convert-images/functions/index.js

class ManageFirebaseDatabase
{
  static final DatabaseReference reference = FirebaseDatabase.instance.reference();

  /*
  static Future<void> dddd() async
  {
    reference.child('.info/connected').on.on('value', function(connectedSnap) {
    if (connectedSnap.val() ==true) {
    /* we're connected! */
    } else {
    /* we're disconnected! */
    }
    });
  }
   */


  static Future<String> checkUserInfo(String userUId) async
  {
    DatabaseReference modelUserInfoReference = reference.child('model_user_info').child(userUId);
    modelUserInfoReference.once().then((DataSnapshot snapshot)
    {
      print('checkUserInfo : ${snapshot.value}');
      return snapshot.value;

    },
    onError: (e)
    {
      print(e);
    });

    return null;

  }

  static Future<Map<dynamic,dynamic>> read(String childName) async
  {
    DatabaseReference modelUserInfoReference = reference.child(childName);
    modelUserInfoReference.once().then((DataSnapshot snapshot)
    {
      print('read sample : ${snapshot.value}');
      return snapshot.value;

    });

    return null;

  }


  static String readOrderByChild(String childName,String orderByChild,String equalTo)
  {
    DatabaseReference modelUserInfoReference = reference.child(childName);
    modelUserInfoReference.orderByChild(orderByChild).equalTo(equalTo).once().then((DataSnapshot snapshot)
    {
      print('read sample : ${snapshot.value}');
      return snapshot.value;
    });

    return '';
  }


  static void create()
  {
    DatabaseReference modelUserInfoReference = reference.child('model_user_info');
    modelUserInfoReference.child('6666').set({
   // modelUserInfoReference.push().set({
      'id': '1111',
      'creator_id': '22222'
    }).then((_) {
      // ...
    });

    //print('create - key : ${modelUserInfoReference.key}');
  }


  static void update()
  {
    DatabaseReference modelUserInfoReference = reference.child('model_user_info');

    //print('update - key : ${modelUserInfoReference.key}');


    modelUserInfoReference.update({
      'id': '2222',
      'creator_id': '55555'
    }).then((_) {
      // ...
    });
  }


  static void delete()
  {
    DatabaseReference modelUserInfoReference = reference.child('model_user_info');
    modelUserInfoReference.remove().then((_) {
      // ...
    });
  }


  static void testRead()
  {
    DatabaseReference modelUserInfoReference = reference.child('model_user_info');
    modelUserInfoReference.orderByChild('id').equalTo('1111').once().then((DataSnapshot snapshot)
    {
        //{6666: {id: 1111, creator_id: 22222}}
        print('read sample : ${snapshot.value}');

    });
  }


  static void setModelFeaturedComicInfo()
  {
    String comicId = '000004';
    DatabaseReference modelReference = reference.child('model_featured_comic_info');



    String title = '불의나라';


    modelReference.child('1566811403000_$comicId').set({
      'comic_id': comicId,
      'creator_id': '1566811403000',
      'creator_name': 'Ⓒ조성황/김일민',
      'part_id':'001',
      'season_id':'001',
      'title':title,
      'user_id':'1566811403000',
    }).then((_) {
      // ...
    });



  }


  static void updateModelFeaturedComicInfo()
  {
    String comicId = '000003';
    DatabaseReference modelReference = reference.child('model_featured_comic_info');

    String title;
    String creatorName;
    String explain;
    switch(comicId)
    {
      case '000001':
        {
          title = '명품열전 루비통편';
          creatorName = 'Ⓒ조성황/김일민';
          explain = '명품은 만들어지는 것. 처음부터 명품인 것은 없다. 도대체 명품이 무엇이기에 이토록 사람들을 미치고 환장하게 만드는가?';
        }
        break;

      case '000002':
        {
          title = '명품열전 샤넬편';
          creatorName = 'Ⓒ조성황/이경렬';
          explain = '명품은 만들어지는 것. 처음부터 명품인 것은 없다. 도대체 명품이 무엇이기에 이토록 사람들을 미치고 환장하게 만드는가?';
        }
        break;

      case '000003':
        {
          title = '명품열전 페라가모편';
          creatorName = 'Ⓒ조성황/이경렬';
          explain = '명품은 만들어지는 것. 처음부터 명품인 것은 없다. 도대체 명품이 무엇이기에 이토록 사람들을 미치고 환장하게 만드는가?';
        }
        break;

      default:
        break;
    }

    modelReference.child('1566811403000_$comicId').update({
      'creator_name': creatorName,
      'title':title,
    }).then((_) {
      // ...
    });



  }


  static void updateModelRecommendedComicInfo(String comicId)
  {
    //String comicId = '000003';
    DatabaseReference modelReference = reference.child('model_recommended_comic_info');

    String title;
    String creatorName;
    String explain;
    switch(comicId)
    {
      case '000001':
        {
          title = '명품열전 루비통편';
          creatorName = 'Ⓒ조성황/김일민';
          explain = '명품은 만들어지는 것. 처음부터 명품인 것은 없다. 도대체 명품이 무엇이기에 이토록 사람들을 미치고 환장하게 만드는가?';
        }
        break;

      case '000002':
        {
          title = '명품열전 샤넬편';
          creatorName = 'Ⓒ조성황/이경렬';
          explain = '명품은 만들어지는 것. 처음부터 명품인 것은 없다. 도대체 명품이 무엇이기에 이토록 사람들을 미치고 환장하게 만드는가?';
        }
        break;

      case '000003':
        {
          title = '명품열전 페라가모편';
          creatorName = 'Ⓒ조성황/이경렬';
          explain = '명품은 만들어지는 것. 처음부터 명품인 것은 없다. 도대체 명품이 무엇이기에 이토록 사람들을 미치고 환장하게 만드는가?';
        }
        break;

      default:
        break;
    }

    modelReference.child('1566811403000_$comicId').update({
      'creator_name': creatorName,
      'title':title,
    }).then((_) {
      // ...
    });



  }

  static void updateModelRealTimeTrendComicInfo(String comicId)
  {
    //String comicId = '000003';
    DatabaseReference modelReference = reference.child('model_real_time_trend_comic_info');

    String title;
    String creatorName;
    String explain;
    switch(comicId)
    {
      case '000001':
        {
          title = '명품열전 루비통편';
          creatorName = 'Ⓒ조성황/김일민';
          explain = '명품은 만들어지는 것. 처음부터 명품인 것은 없다. 도대체 명품이 무엇이기에 이토록 사람들을 미치고 환장하게 만드는가?';
        }
        break;

      case '000002':
        {
          title = '명품열전 샤넬편';
          creatorName = 'Ⓒ조성황/이경렬';
          explain = '명품은 만들어지는 것. 처음부터 명품인 것은 없다. 도대체 명품이 무엇이기에 이토록 사람들을 미치고 환장하게 만드는가?';
        }
        break;

      case '000003':
        {
          title = '명품열전 페라가모편';
          creatorName = 'Ⓒ조성황/이경렬';
          explain = '명품은 만들어지는 것. 처음부터 명품인 것은 없다. 도대체 명품이 무엇이기에 이토록 사람들을 미치고 환장하게 만드는가?';
        }
        break;

      default:
        break;
    }

    modelReference.child('1566811403000_$comicId').update({
      'creator_name': creatorName,
      'title':title,
    }).then((_) {
      // ...
    });



  }


  static void updateModelNewComicInfo(String comicId)
  {
    //String comicId = '000003';
    DatabaseReference modelReference = reference.child('model_new_comic_info');

    String title;
    String creatorName;
    String explain;
    switch(comicId)
    {
      case '000001':
        {
          title = '명품열전 루비통편';
          creatorName = 'Ⓒ조성황/김일민';
          explain = '명품은 만들어지는 것. 처음부터 명품인 것은 없다. 도대체 명품이 무엇이기에 이토록 사람들을 미치고 환장하게 만드는가?';
        }
        break;

      case '000002':
        {
          title = '명품열전 샤넬편';
          creatorName = 'Ⓒ조성황/이경렬';
          explain = '명품은 만들어지는 것. 처음부터 명품인 것은 없다. 도대체 명품이 무엇이기에 이토록 사람들을 미치고 환장하게 만드는가?';
        }
        break;

      case '000003':
        {
          title = '명품열전 페라가모편';
          creatorName = 'Ⓒ조성황/이경렬';
          explain = '명품은 만들어지는 것. 처음부터 명품인 것은 없다. 도대체 명품이 무엇이기에 이토록 사람들을 미치고 환장하게 만드는가?';
        }
        break;

      default:
        break;
    }

    modelReference.child('1566811403000_$comicId').update({
      'creator_name': creatorName,
      'title':title,
    }).then((_) {
      // ...
    });
  }


  static void updateModelTodayTrendComicInfo(String comicId)
  {
    //String comicId = '000003';
    DatabaseReference modelReference = reference.child('model_today_trend_comic_info');

    String title;
    String creatorName;
    String explain;
    switch (comicId) {
      case '000001':
        {
          title = '명품열전 루비통편';
          creatorName = 'Ⓒ조성황/김일민';
          explain =
          '명품은 만들어지는 것. 처음부터 명품인 것은 없다. 도대체 명품이 무엇이기에 이토록 사람들을 미치고 환장하게 만드는가?';
        }
        break;

      case '000002':
        {
          title = '명품열전 샤넬편';
          creatorName = 'Ⓒ조성황/이경렬';
          explain =
          '명품은 만들어지는 것. 처음부터 명품인 것은 없다. 도대체 명품이 무엇이기에 이토록 사람들을 미치고 환장하게 만드는가?';
        }
        break;

      case '000003':
        {
          title = '명품열전 페라가모편';
          creatorName = 'Ⓒ조성황/이경렬';
          explain =
          '명품은 만들어지는 것. 처음부터 명품인 것은 없다. 도대체 명품이 무엇이기에 이토록 사람들을 미치고 환장하게 만드는가?';
        }
        break;

      default:
        break;
    }

    modelReference.child('1566811403000_$comicId').update({
      'creator_name': creatorName,
      'title':title,
    }).then((_) {
      // ...
    });

  }


    static void updateModelWeeklyTrendComicInfo(String comicId)
    {
      //String comicId = '000003';
      DatabaseReference modelReference = reference.child('model_weekly_trend_comic_info');

      String title;
      String creatorName;
      String explain;
      switch(comicId)
      {
        case '000001':
          {
            title = '명품열전 루비통편';
            creatorName = 'Ⓒ조성황/김일민';
            explain = '명품은 만들어지는 것. 처음부터 명품인 것은 없다. 도대체 명품이 무엇이기에 이토록 사람들을 미치고 환장하게 만드는가?';
          }
          break;

        case '000002':
          {
            title = '명품열전 샤넬편';
            creatorName = 'Ⓒ조성황/이경렬';
            explain = '명품은 만들어지는 것. 처음부터 명품인 것은 없다. 도대체 명품이 무엇이기에 이토록 사람들을 미치고 환장하게 만드는가?';
          }
          break;

        case '000003':
          {
            title = '명품열전 페라가모편';
            creatorName = 'Ⓒ조성황/이경렬';
            explain = '명품은 만들어지는 것. 처음부터 명품인 것은 없다. 도대체 명품이 무엇이기에 이토록 사람들을 미치고 환장하게 만드는가?';
          }
          break;

        default:
          break;
      }

    modelReference.child('1566811403000_$comicId').update({
      'creator_name': creatorName,
      'title':title,
    }).then((_) {
      // ...
    });
  }


  static void updateModelLibraryContinueComicInfo(String comicId)
  {
    //String comicId = '000003';
    DatabaseReference modelReference = reference.child('model_library_continue_comic_info');

    String title;
    String creatorName;
    String explain;
    switch(comicId)
    {
      case '000001':
        {
          title = '명품열전 루비통편';
          creatorName = 'Ⓒ조성황/김일민';
          explain = '명품은 만들어지는 것. 처음부터 명품인 것은 없다. 도대체 명품이 무엇이기에 이토록 사람들을 미치고 환장하게 만드는가?';
        }
        break;

      case '000002':
        {
          title = '명품열전 샤넬편';
          creatorName = 'Ⓒ조성황/이경렬';
          explain = '명품은 만들어지는 것. 처음부터 명품인 것은 없다. 도대체 명품이 무엇이기에 이토록 사람들을 미치고 환장하게 만드는가?';
        }
        break;

      case '000003':
        {
          title = '명품열전 페라가모편';
          creatorName = 'Ⓒ조성황/이경렬';
          explain = '명품은 만들어지는 것. 처음부터 명품인 것은 없다. 도대체 명품이 무엇이기에 이토록 사람들을 미치고 환장하게 만드는가?';
        }
        break;

      default:
        break;
    }

    modelReference.child('1566811403000_$comicId').update({
      'creator_name': creatorName,
      'title':title,
    }).then((_) {
      // ...
    });
  }

  static void updateModelLibraryOwnedComicInfo(String comicId)
  {
    //String comicId = '000003';
    DatabaseReference modelReference = reference.child('model_library_owned_comic_info');

    String title;
    String creatorName;
    String explain;
    switch(comicId)
    {
      case '000001':
        {
          title = '명품열전 루비통편';
          creatorName = 'Ⓒ조성황/김일민';
          explain = '명품은 만들어지는 것. 처음부터 명품인 것은 없다. 도대체 명품이 무엇이기에 이토록 사람들을 미치고 환장하게 만드는가?';
        }
        break;

      case '000002':
        {
          title = '명품열전 샤넬편';
          creatorName = 'Ⓒ조성황/이경렬';
          explain = '명품은 만들어지는 것. 처음부터 명품인 것은 없다. 도대체 명품이 무엇이기에 이토록 사람들을 미치고 환장하게 만드는가?';
        }
        break;

      case '000003':
        {
          title = '명품열전 페라가모편';
          creatorName = 'Ⓒ조성황/이경렬';
          explain = '명품은 만들어지는 것. 처음부터 명품인 것은 없다. 도대체 명품이 무엇이기에 이토록 사람들을 미치고 환장하게 만드는가?';
        }
        break;

      default:
        break;
    }

    modelReference.child('1566811403000_$comicId').update({
      'creator_name': creatorName,
      'title':title,
    }).then((_) {
      // ...
    });
  }

  static void updateModelLibraryRecentComicInfo(String comicId)
  {
    //String comicId = '000003';
    DatabaseReference modelReference = reference.child('model_library_recent_comic_info');

    String title;
    String creatorName;
    String explain;
    switch(comicId)
    {
      case '000001':
        {
          title = '명품열전 루비통편';
          creatorName = 'Ⓒ조성황/김일민';
          explain = '명품은 만들어지는 것. 처음부터 명품인 것은 없다. 도대체 명품이 무엇이기에 이토록 사람들을 미치고 환장하게 만드는가?';
        }
        break;

      case '000002':
        {
          title = '명품열전 샤넬편';
          creatorName = 'Ⓒ조성황/이경렬';
          explain = '명품은 만들어지는 것. 처음부터 명품인 것은 없다. 도대체 명품이 무엇이기에 이토록 사람들을 미치고 환장하게 만드는가?';
        }
        break;

      case '000003':
        {
          title = '명품열전 페라가모편';
          creatorName = 'Ⓒ조성황/이경렬';
          explain = '명품은 만들어지는 것. 처음부터 명품인 것은 없다. 도대체 명품이 무엇이기에 이토록 사람들을 미치고 환장하게 만드는가?';
        }
        break;

      default:
        break;
    }

    modelReference.child('1566811403000_$comicId').update({
      'creator_name': creatorName,
      'title':title,
    }).then((_) {
      // ...
    });
  }

  static void updateModelLibraryViewListComicInfo(String comicId)
  {
    //String comicId = '000003';
    DatabaseReference modelReference = reference.child('model_library_view_list_comic_info');

    String title;
    String creatorName;
    String explain;
    switch(comicId)
    {
      case '000001':
        {
          title = '명품열전 루비통편';
          creatorName = 'Ⓒ조성황/김일민';
          explain = '명품은 만들어지는 것. 처음부터 명품인 것은 없다. 도대체 명품이 무엇이기에 이토록 사람들을 미치고 환장하게 만드는가?';
        }
        break;

      case '000002':
        {
          title = '명품열전 샤넬편';
          creatorName = 'Ⓒ조성황/이경렬';
          explain = '명품은 만들어지는 것. 처음부터 명품인 것은 없다. 도대체 명품이 무엇이기에 이토록 사람들을 미치고 환장하게 만드는가?';
        }
        break;

      case '000003':
        {
          title = '명품열전 페라가모편';
          creatorName = 'Ⓒ조성황/이경렬';
          explain = '명품은 만들어지는 것. 처음부터 명품인 것은 없다. 도대체 명품이 무엇이기에 이토록 사람들을 미치고 환장하게 만드는가?';
        }
        break;

      default:
        break;
    }

    modelReference.child('1566811403000_$comicId').update({
      'creator_name': creatorName,
      'title':title,
    }).then((_) {
      // ...
    });
  }

  static void setModelComicDetailInfo()
  {
    DatabaseReference modelReference = reference.child('model_comic_detail_info');


    String comicId = '000009';
    String title = '개구쟁이';


    modelReference.child('1566811403000_$comicId').set({
      'comic_id': comicId,
      'creator_id': '1566811403000',
      'creator_name': '묵검향',
      'explain':'explain',
      'part_id':'001',
      'point':4,
      'season_id':'001',
      'title':title,
      'user_id':'1566811403000',
    }).then((_) {
      // ...
    });

    setModelComicDetailInfoComics(1,35,comicId,title);


  }


  static void updateModelComicDetailInfo()
  {
    DatabaseReference modelReference = reference.child('model_comic_detail_info');

    String comicId = '000003';

    String title;
    String creatorName;
    String explain;
    switch(comicId)
    {
      case '000001':
        {
          title = '명품열전 루비통편';
          creatorName = 'Ⓒ조성황/김일민';
          explain = '명품은 만들어지는 것. 처음부터 명품인 것은 없다. 도대체 명품이 무엇이기에 이토록 사람들을 미치고 환장하게 만드는가?';
        }
        break;

      case '000002':
        {
          title = '명품열전 샤넬편';
          creatorName = 'Ⓒ조성황/이경렬';
          explain = '명품은 만들어지는 것. 처음부터 명품인 것은 없다. 도대체 명품이 무엇이기에 이토록 사람들을 미치고 환장하게 만드는가?';
        }
        break;

      case '000003':
        {
          title = '명품열전 페라가모편';
          creatorName = 'Ⓒ조성황/이경렬';
          explain = '명품은 만들어지는 것. 처음부터 명품인 것은 없다. 도대체 명품이 무엇이기에 이토록 사람들을 미치고 환장하게 만드는가?';
        }
        break;

      default:
        break;
    }



    modelReference.child('1566811403000_$comicId').update({
      'creator_name': creatorName,
      'explain':explain,
      'title':title,
    }).then((_) {
      // ...
    });

    updateModelComicDetailInfoComics(1,65,comicId,title);


  }


  static void updateModelComicDetailInfoComics(int startCountIndex,int finishCountIndex,String comicId,String title)
  {
    DatabaseReference modelReference = reference.child('model_comic_detail_info').child('1566811403000_$comicId').child('comics');

    int i = startCountIndex;
    for(;i<finishCountIndex+1;++i)
    {
      String t = i.toString();
      String j;
      if(i < 10)
        j = '0000$i';
      else if(9 < i && i < 100)
        j = '000$i';
      else if(99 < i && i < 1000)
        j = '00$i';

      modelReference.child('$j').update({
        'title': '$title$t',
      }).then((_) {

      });
    }
  }


  static void setModelComicDetailInfoComics(int startCountIndex,int finishCountIndex,String comicId,String title)
  {
    DatabaseReference modelReference = reference.child('model_comic_detail_info').child('1566811403000_$comicId').child('comics');

    int i = startCountIndex;
    for(;i<finishCountIndex+1;++i)
    {
      String t = i.toString();
      String j;
      if(i < 10)
        j = '0000$i';
      else if(9 < i && i < 100)
        j = '000$i';
      else if(99 < i && i < 1000)
        j = '00$i';

      modelReference.child('$j').set({
        'collected': 0,
        'episode_id': '$j',
        'title': '$title$t',
        'updated': 0,
      }).then((_) {

      });
    }
  }


  static void setModelViewComicInfo()
  {
    DatabaseReference modelReference = reference.child('model_view_comic_info');

    int i = 1;
    for(;i<36;++i)
    {
      String t = i.toString();
       String j;
       if(i < 10)
         j = '0000$i';
       else if(9 < i && i < 100)
         j = '000$i';
       else if(99 < i && i < 1000)
         j = '00$i';

        modelReference.child('1566811403000_000009_$j').set({
          'count': 6,
          'file_ext': 'jpg',
          'style': 0,
          'title': '개구쟁이$t',
        }).then((_) {

        });
    }
  }






  static void setModelWeeklyCreatorInfo()
  {
    DatabaseReference modelUserInfoReference = reference.child('model_weekly_creator_info');

    modelUserInfoReference.child('1566811403000_000001').set({
      'comic_id': '000001',
      'creator_id': '1566811403000',
      'creator_name': '묵검향',
      'title':'아비향',
      'user_id':'1566811403000',
    }).then((_) {
      // ...
    });

    modelUserInfoReference.child('1566811403000_000002').set({
      'comic_id': '000002',
      'creator_id': '1566811403000',
      'creator_name': '묵검향',
      'title':'반야',
      'user_id':'1566811403000',
    }).then((_) {
      // ...
    });

    modelUserInfoReference.child('1566811403000_000003').set({
      'comic_id': '000003',
      'creator_id': '1566811403000',
      'creator_name': '묵검향',
      'title':'개구쟁이',
      'user_id':'1566811403000',
    }).then((_) {
      // ...
    });

    modelUserInfoReference.child('1566811443000_000001').set({
      'comic_id': '000001',
      'creator_id': '1566811443000',
      'creator_name': 'sample',
      'title':'sample',
      'user_id':'1566811443000',
    }).then((_) {
      // ...
    });



  }


}