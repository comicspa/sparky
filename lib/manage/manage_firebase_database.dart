
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


  static void ddd()
  {
    DatabaseReference modelUserInfoReference = ManageFirebaseDatabase.reference.child('model_user_info');
    modelUserInfoReference.child('LLbvFPwodlVYswjqI05xleBjvLf1').child('creators').update({
      '0':'oooooo',
    }).then((_) {

      //});

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


    String comicId = '000006';
    String title = '성형술사';


    modelReference.child('1566811403000_$comicId').set({
      'comic_id': comicId,
      'creator_id': '1566811403000',
      'creator_name': 'ⓒRIU',
      'explain':'explain',
      'part_id':'001',
      'point':4,
      'season_id':'001',
      'title':title,
      'user_id':'1566811403000',
    }).then((_) {
      // ...
    });

    setModelComicDetailInfoComics(1,309,comicId,title);


  }


  static Map getTitleCreatorNameExplain(String comicId)
  {
    Map newMap = new Map();

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

      case '000004':
        {
          title = '불의나라';
          creatorName = 'Ⓒ조성황/김일민';
          explain = '지도를 만들기 위해 분투하는 김정호와 인동숙. 그리고 그들이 지도를 만들지 못하게 방해하는 명과 일본. 대동여지도를 만들기 위해 벌어지는 처절하고도 장엄한 이야기.';
        }
        break;

      case '000005':
        {
          title = '성형술사';
          creatorName = 'Ⓒ조성황/김일민';
          explain = '천재 성형외과의 현진우, 전후무후한 추녀 허설지. 일련의 목표를 위해 두 사람이 모였다. 과연 그들의 목표는 무엇일까?';
        }
        break;

      case '000006':
        {
          title = '성공CLUB';
          creatorName = 'ⓒRIU';
          explain = '별자리의 저주를 단서로 벌어지는 사건들.요리사가 되고 싶은 피아노 소녀는 일자리를 위해 남장을 하고 위장 취업을 하지만, 그녀를 기다리는 것은 신비로운 대저택과 천 년 동안 저주를 받고 있는 12성좌의 소년들이었다.소녀와 소년들은 운명이 걸린 별 하늘에서 어떤 궤적을 그리게 될 것인가.';
        }
        break;

      case '000007':
        {
          title = '아적묘미상선';
          creatorName = '유야오치/유야오치';
          explain = '신선계 인호신궁의 아들이 운명의 사람을 찾아 인간계로 내려왔다.하지만 인간이 아닌 고양이로 변하게 될 줄은 누가 알았을까…?억겁의 응보를 이겨낼 운명의 사람, 그리고 그를 둘러싼 수많은 음모와 함정.고양이 신령은 운명의 사람과 함께 무사히 시험을 이겨낼 수 있을 것인가… ';
        }
        break;

      case '000008':
        {
          title = '한번만하자';
          creatorName = 'ⓒ조성황/박광진';
          explain = '저승사자의 실수로 내가 대신 죽었다고?!마른 하늘에 날벼락이 치던 날, 날벼락처럼 내 인생이 사라졌다.그냥 죽는 것도 억울한데 처녀로 죽어야 하다니. 나 한 번만 하게 해줘!!';
        }
        break;

      case '000009':
        {
          title = '혈족금역';
          creatorName = 'ⓒAKI.7/AKI.7';
          explain = '유전자 복제로 태어난 세 자매. 쌍둥이를 복제하려 했으나 박사의 실수로 세 쌍둥이가 태어난다.막내는 배신당하고, 첫째는 피투성이가 되었으며, 둘째는 혈족(뱀파이어)의 함정에 빠지고 만다. 끊이지 않는 사건들은 세 자매의 운명을 어떻게 바꿀 것인가.그리고 그들은 운명을 이길 수 있을 것인가.';
        }
        break;

      default:
        break;
    }

    newMap['title'] = title;
    newMap['creatorName'] = creatorName;
    newMap['explain'] = explain;

    return newMap;
  }


  static void setModelInfo(String name,String creatorId,String comicId)
  {
    Map map = getTitleCreatorNameExplain(comicId);
    DatabaseReference modelReference = reference.child(name);

    modelReference.child('${creatorId}_${comicId}').set({
      'comic_id':comicId,
      'creator_id':creatorId,
      'creator_name': map['creatorName'] ,
      'part_id':'001',
      'season_id':'001',
      'title':map['title'],
      'user_id':creatorId,
    }).then((_) {
      // ...
    });

  }


  static void updateModelComicDetailInfoSubscribe()
  {
    DatabaseReference modelReference = reference.child('model_comic_detail_info').child('1566811403000_000001');
    modelReference.child('subscribers').update({
      '44444': 1
    }).then((_) {
      // ...
    });
  }

  static void searchModelComicDetailInfoSubscribe()
  {
    DatabaseReference modelUserInfoReference = reference.child('model_comic_detail_info').child('1566811403000_000001').child('subscribers');
    modelUserInfoReference.once().then((DataSnapshot snapshot)
    {
      print('[searchModelComicDetailInfoSubscribe] - ${snapshot.value}');

      //Map map = snapshot.value;
      //print(map['22222']);

    });
  }

  static void deleteModelComicDetailInfoSubscribe()
  {

    DatabaseReference modelUserInfoReference = ManageFirebaseDatabase.reference.child('model_comic_detail_info').child('1566811403000_000001').child('subscribers');
    modelUserInfoReference.child('44444').remove().then((_) {
      // ...
    });



  }



  static void updateModelComicDetailInfo()
  {
    DatabaseReference modelReference = reference.child('model_comic_detail_info');

    String comicId = '000009';

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

      case '000004':
        {
          title = '불의나라';
          creatorName = 'Ⓒ조성황/김일민';
          explain = '지도를 만들기 위해 분투하는 김정호와 인동숙. 그리고 그들이 지도를 만들지 못하게 방해하는 명과 일본. 대동여지도를 만들기 위해 벌어지는 처절하고도 장엄한 이야기.';
        }
        break;

      case '000005':
        {
          title = '성형술사';
          creatorName = 'Ⓒ조성황/김일민';
          explain = '천재 성형외과의 현진우, 전후무후한 추녀 허설지. 일련의 목표를 위해 두 사람이 모였다. 과연 그들의 목표는 무엇일까?';
        }
        break;

      case '000006':
        {
          title = '성공CLUB';
          creatorName = 'ⓒRIU';
          explain = '별자리의 저주를 단서로 벌어지는 사건들.요리사가 되고 싶은 피아노 소녀는 일자리를 위해 남장을 하고 위장 취업을 하지만, 그녀를 기다리는 것은 신비로운 대저택과 천 년 동안 저주를 받고 있는 12성좌의 소년들이었다.소녀와 소년들은 운명이 걸린 별 하늘에서 어떤 궤적을 그리게 될 것인가.';
        }
        break;

      case '000007':
        {
          title = '아적묘미상선';
          creatorName = '유야오치/유야오치';
          explain = '신선계 인호신궁의 아들이 운명의 사람을 찾아 인간계로 내려왔다.하지만 인간이 아닌 고양이로 변하게 될 줄은 누가 알았을까…?억겁의 응보를 이겨낼 운명의 사람, 그리고 그를 둘러싼 수많은 음모와 함정.고양이 신령은 운명의 사람과 함께 무사히 시험을 이겨낼 수 있을 것인가… ';
        }
        break;

      case '000008':
        {
          title = '한번만하자';
          creatorName = 'ⓒ조성황/박광진';
          explain = '저승사자의 실수로 내가 대신 죽었다고?!마른 하늘에 날벼락이 치던 날, 날벼락처럼 내 인생이 사라졌다.그냥 죽는 것도 억울한데 처녀로 죽어야 하다니. 나 한 번만 하게 해줘!!';
        }
        break;

      case '000009':
        {
          title = '혈족금역';
          creatorName = 'ⓒAKI.7/AKI.7';
          explain = '유전자 복제로 태어난 세 자매. 쌍둥이를 복제하려 했으나 박사의 실수로 세 쌍둥이가 태어난다.막내는 배신당하고, 첫째는 피투성이가 되었으며, 둘째는 혈족(뱀파이어)의 함정에 빠지고 만다. 끊이지 않는 사건들은 세 자매의 운명을 어떻게 바꿀 것인가.그리고 그들은 운명을 이길 수 있을 것인가.';
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

    updateModelComicDetailInfoComics(1,35,comicId,title);


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


  static void updateModelViewComicInfo(String creatorId,String comicId,String title,int episodeTotalCount)
  {
    DatabaseReference modelReference = reference.child('model_view_comic_info');

    int i = 1;
    for(;i<episodeTotalCount+1;++i)
    {
      String t = i.toString();
      String j;
      if(i < 10)
        j = '0000$i';
      else if(9 < i && i < 100)
        j = '000$i';
      else if(99 < i && i < 1000)
        j = '00$i';

      modelReference.child('${creatorId}_${comicId}_${j}').update({
        'count': 6,
        'file_ext': 'jpg',
        'style': 0,
        'title': '$title$t',
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