import 'package:flutter/material.dart';
// import 'package:kommunicate_flutter/kommunicate_flutter.dart';
import 'package:link_refurb/ui/widgets/loader.dart';

class SupportPage extends StatefulWidget {
  const SupportPage({Key? key}) : super(key: key);

  @override
  _SupportPageState createState() => _SupportPageState();
}

class _SupportPageState extends State<SupportPage> {
  bool loading = true;

  @override
  void initState() {
    // TODO: implement initState
    launchChat();
  }

  void launchChat() async {
    // try {
    //   dynamic conversationObject = {
    //     'appId':
    //         'f3c4c2f287ea7d5cff005b4e64bc1765' // The [APP_ID](https://dashboard.kommunicate.io/settings/install) obtained from kommunicate dashboard.
    //   };
    //   dynamic result =
    //       await KommunicateFlutterPlugin.buildConversation(conversationObject);
    //   setState(() {
    //     loading = false;
    //   });
    //   print("Conversation builder success : " + result.toString());
    // } on Exception catch (e) {
    //   print("Conversation builder error occurred : " + e.toString());
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('links Support'),
          backgroundColor: Color(0XFFF7931E),
          elevation: 0,
        ),
        body: loading ? Loader() : rejoinConversation());
  }

  Widget rejoinConversation() {
    return Center(
      child: Padding(
          padding: EdgeInsets.fromLTRB(8, 40, 8, 8),
          child: Column(
            children: <Widget>[
              Text('Welcome to support'),
              SizedBox(height: 15),
              SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: () {
                  launchChat();
                  setState(() {
                    loading = true;
                  });
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(vertical: 15),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                            color: Colors.grey.shade200,
                            offset: Offset(2, 4),
                            blurRadius: 5,
                            spreadRadius: 2)
                      ],
                      gradient: LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [Color(0xfffbb448), Color(0xfff7892b)])),
                  child: Text(
                    'Click Here To Start Chat',
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
// f3c4c2f287ea7d5cff005b4e64bc1765 appID
// 79PutByK65iPDzNpnoRUNIjVGs6Rg5Fl api key