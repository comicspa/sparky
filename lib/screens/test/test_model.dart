class TestData {
  int albumId;
  int id;
  String title;
  String url;
  String thumbnailUrl;

  TestData({
    this.albumId,
    this.id,
    this.title,
    this.url,
    this.thumbnailUrl,
  });

  factory TestData.fromJson(Map<String, dynamic> json) => new TestData(
        albumId: json["albumId"],
        id: json["id"],
        title: json["title"],
        url: json["url"],
        thumbnailUrl: json["thumbnailUrl"],
      );

  Map<String, dynamic> toJson() => {
        "albumId": albumId,
        "id": id,
        "title": title,
        "url": url,
        "thumbnailUrl": thumbnailUrl,
      };
}

//widget test() {
//  return ListView.builder(
//    shrinkWrap: true,
//    scrollDirection: Axis.vertical,
//    itemCount: textBlockList.length,
//    itemBuilder: (context, index) {
//      return Stack(
//        children: <Widget>[
//          FittedBox(
//            child: SizedBox(
//              width: ManageDeviceInfo.resolutionWidth *
//                  (manageImage.width /
//                      ManageDeviceInfo.resolutionWidth),
//              height: ManageDeviceInfo.resolutionHeight *
//                  (manageImage.height /
//                      ManageDeviceInfo.resolutionHeight),
//              child: _buildImage(),
//            ),
//          ),
//          GestureDetector(
//            onTap: () {
//              showDialog(
//                context: context,
//                builder: (BuildContext context) {
//                  return AlertDialog(
//                    backgroundColor: Colors.transparent,
//                    content: Form(
//                      key: _formKey,
//                      child: SizedBox(
//                        height: ManageDeviceInfo.resolutionHeight * 0.38,
//                        child: Column(
//                          crossAxisAlignment: CrossAxisAlignment.start,
//                          children: <Widget>[
//                            Container(
//                              decoration: BoxDecoration(
//                                color: Colors.white,
//                                borderRadius: BorderRadius.circular(5.0),
//                              ),
//                              height:
//                              ManageDeviceInfo.resolutionHeight * 0.2,
//                              child: TextFormField(
//                                textInputAction: TextInputAction.send,
//                                autofocus: true,
//                                textAlign: TextAlign.left,
//                                style: TextStyle(
//                                  fontFamily: 'Lato',
//                                  color: Colors.black87,
//                                ),
//                                decoration: InputDecoration(
//                                    hintText: 'You may start typing',
//                                    contentPadding: EdgeInsets.all(
//                                        ManageDeviceInfo.resolutionHeight *
//                                            0.01)
//
////                              border: OutlineInputBorder(),
////                              focusedBorder: OutlineInputBorder(
////                                borderSide: BorderSide(
////                                  color: Colors.greenAccent,
////                                ),
////                              ),
////                              enabledBorder: OutlineInputBorder(
////                                borderSide: BorderSide(
////                                  color: Colors.redAccent,
////                                ),
////                              ),
////                              contentPadding: EdgeInsets.all(
////                                  ManageDeviceInfo.resolutionWidth * 0.02),
//                                ),
//                                keyboardType: TextInputType.multiline,
//                                maxLines: null,
//                                validator: (value) {
//                                  if (value.isEmpty) {
//                                    return 'Please enter some text';
//                                  }
//                                  return null;
//                                },
//                              ),
//                            ),
//                            Row(
//                              mainAxisAlignment: MainAxisAlignment.center,
//                              children: <Widget>[
//                                Padding(
//                                  padding: const EdgeInsets.symmetric(
//                                      vertical: 15),
//                                  child: SizedBox(
//                                    height:
//                                    ManageDeviceInfo.resolutionHeight *
//                                        0.035,
//                                    child: RaisedButton(
//                                      shape: StadiumBorder(),
//                                      onPressed: () {
//// Validate will return true if the form is valid, or false if
//// the form is invalid.
//                                        Navigator.pop(context);
//                                      },
//                                      child: Text('Cancel'),
//                                    ),
//                                  ),
//                                ),
//                                SizedBox(
//                                  width: ManageDeviceInfo.resolutionWidth *
//                                      0.1,
//                                ),
//                                Padding(
//                                  padding: const EdgeInsets.symmetric(
//                                      vertical: 15.0),
//                                  child: SizedBox(
//                                    height:
//                                    ManageDeviceInfo.resolutionHeight *
//                                        0.035,
//                                    child: RaisedButton(
//                                      shape: StadiumBorder(),
//                                      onPressed: () {
//// Validate will return true if the form is valid, or false if
//// the form is invalid.
//                                        if (_formKey.currentState
//                                            .validate()) {
//// Process data.
//                                        }
//                                      },
//                                      child: Text('Submit'),
//                                    ),
//                                  ),
//                                ),
//                              ],
//                            ),
//                            Row(
//                              mainAxisAlignment: MainAxisAlignment.center,
//                              children: <Widget>[
//                                Padding(
//                                  padding: EdgeInsets.all(
//                                      ManageDeviceInfo.resolutionHeight *
//                                          0.02),
//                                  child: SizedBox(
//                                    height:
//                                    ManageDeviceInfo.resolutionHeight *
//                                        0.035,
//                                    child: RaisedButton(
//                                      shape: StadiumBorder(),
//                                      onPressed: () {
//// Validate will return true if the form is valid, or false if
//// the form is invalid.
//                                        if (_formKey.currentState
//                                            .validate()) {
//// Process data.
//                                        }
//                                      },
//                                      child: Text('Language'),
//                                    ),
//                                  ),
//                                ),
//                              ],
//                            )
//                          ],
//                        ),
//                      ),
//                    ),
//                  );
//                },
//              );
//              debugPrint("hello");
//            },
//            child: Stack(
//              children: <Widget>[
//                Positioned(
//                  left: ManageDeviceInfo.resolutionWidth /
//                      (manageImage.width /
//                          textBlockList[index].boundingBox.left),
//                  top: ManageDeviceInfo.resolutionHeight /
//                      (manageImage.height /
//                          textBlockList[index].boundingBox.top),
//                  child: Container(
//                    width: ManageDeviceInfo.resolutionWidth /
//                        (manageImage.width /
//                            textBlockList[index]
//                                .boundingBox
//                                .width),
//                    height: ManageDeviceInfo.resolutionHeight /
//                        (manageImage.height /
//                            textBlockList[index].boundingBox.height),
//                    color: Colors.yellow,
//                    child: CustomPaint(
//                      painter: (MyRect()),
//                    ),
//                  ),
//                ),
//              ],
//            ),
//          ),
//        ],
//      );
//    },
//  )
//  ,
//}
