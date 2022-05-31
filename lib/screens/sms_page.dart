// ignore_for_file: must_be_immutable, unused_local_variable
import 'package:calculator/core/method/sms_method.dart';
import 'package:calculator/core/services/sms_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class SmsPage extends StatefulWidget {
  int _id;
  SmsPage(
    this._id,
  ) {
    // There's a better way to do this, stay tuned.
    this._id = _id;
  }

  @override
  State<SmsPage> createState() => _SmsPageState(_id);
}

class _SmsPageState extends State<SmsPage> {
  int _id;

  _SmsPageState(
    this._id,
  ) {
    // There's a better way to do this, stay tuned.
    this._id = _id;
  }

  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    final _textController = TextEditingController();

    var length = 0;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50.0),
        child: AppBar(
          backgroundColor: Color.fromARGB(255, 95, 26, 244),
        ),
      ),
      body: SafeArea(
        bottom: true,
        child: SizedBox(
          child: Column(
            children: [
              Expanded(
                  flex: 1,
                  child: FutureBuilder<List<dynamic>>(
                    future: SmsServices.fetSms(),
                    builder: ((context, AsyncSnapshot<List<dynamic>> snapshot) {
                      if (snapshot.hasData) {
                        final data = snapshot.data!;
                        return ListView.builder(
                          itemBuilder: ((context, index) {
                            var item = data[index];
                            return SmsMethod(item);
                          }),
                          itemCount: data.length,
                        );
                      } else if (snapshot.hasError) {
                        return Center(
                          child: Text(
                            'ERROR',
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 22.sp,
                            ),
                          ),
                        );
                      } else {
                        return Center(
                          child: CupertinoActivityIndicator(),
                        );
                      }
                    }),
                  )),
              Expanded(
                flex: 0,
                child: Input(_textController),
              ),
            ],
          ),
        ),
      ),
    );
    
  }

  Padding Input(TextEditingController _textController) {
    return Padding(
      padding: EdgeInsets.all(15.0.px),
      child: TextField(
        controller: _textController,
        textInputAction: TextInputAction.done,
        maxLines: 6,
        minLines: 1,
        onSubmitted: (V) {
          on(_textController, _id);
          setState(() {});
        },
        decoration: InputDecoration(
          constraints: BoxConstraints(),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color.fromARGB(255, 120, 61, 248)),
              borderRadius: BorderRadius.circular(25.0)),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25.0.px),
          ),
          hintText: "Type massage ...",
          hintStyle: TextStyle(
              color: Color.fromARGB(255, 120, 61, 248), fontSize: 15.sp),
          prefixIcon: IconButton(
            icon: Icon(
              Icons.refresh,
              color: Color.fromARGB(255, 120, 61, 248),
              size: 20.0.sp,
            ),
            onPressed: () {
              setState(() {});
            },
          ),
          suffixIcon: IconButton(
            icon: Icon(
              Icons.send,
              color: Color.fromARGB(255, 120, 61, 248),
              size: 18.0.sp,
            ),
            onPressed: () {
              on(_textController, _id);
              setState(() {});
            },
          ),
        ),
      ),
    );
  }
}

on(_textController, _id) async {
  final now = new DateTime.now();
  if (_textController.text.trim() != '') {
    var obj = {
      'text': "${_textController.text.trim()}",
      "type": _id,
      'time': new DateFormat('Hm').format(now).toString()
    };

    var res = SmsServices.postSms(obj).toString();
    debugPrint(res.toString());
    _textController.text = '';
  }
}
