import 'package:flutter/material.dart';
import 'card_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _cardNoController = TextEditingController();
  final TextEditingController _fullNameController = TextEditingController();
  List<CardModel> listCard = [];

  @override
  void dispose() {
    // TODO: implement dispose
    _cardNoController.dispose();
    _fullNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text('Danh sách thẻ'),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Image.asset("asset/images/card.png"),
                  Positioned(
                    bottom: 40,
                    left: 20,
                    child: Text(
                      _cardNoController.text,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 40,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  Positioned(
                    bottom: 20,
                    left: 20,
                    child: Text(
                      _fullNameController.text,
                      style: const TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                ],
              ),
              TextField(
                controller: _cardNoController,
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(
                  labelText: 'Card No',
                  hintText: 'Enter your card no',
                  contentPadding: EdgeInsets.symmetric(vertical: 15),
                ),
                onChanged: (value) {
                  setState(() {
                    _cardNoController.text;
                  });
                },
              ),
              TextField(
                controller: _fullNameController,
                keyboardType: TextInputType.text,
                textCapitalization: TextCapitalization.words,
                textInputAction: TextInputAction.done,
                decoration: const InputDecoration(
                  labelText: 'Full name',
                  hintText: 'Enter your full name',
                  contentPadding: EdgeInsets.symmetric(vertical: 15),
                ),
                onChanged: (value) {
                  setState(() {
                    _fullNameController.text;
                  });
                },
              ),
              const SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    if (_fullNameController.text != "" &&
                        _cardNoController.text != "") {
                      listCard.add(CardModel(
                          cardNo: _cardNoController.text,
                          fullName: _fullNameController.text,
                          cardInvisible: true));
                      _fullNameController.text = "";
                      _cardNoController.text = "";
                    }
                  });
                },
                child: Container(
                  width: double.infinity,
                  color: Colors.blue,
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: const Text(
                    'Thêm',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w600),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Danh sách thẻ của\ntechmaster',
                style: TextStyle(fontSize: 27, fontWeight: FontWeight.w700),
              ),
              Expanded(
                child: ListView.separated(
                  separatorBuilder: (BuildContext context, index) {
                    return const SizedBox(
                      width: 30,
                    );
                  },
                  itemCount: listCard.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    listCard[index].cardNoInvisible =
                        "${listCard[index].cardNo.substring(0, 2)}***${listCard[index].cardNo.substring(listCard[index].cardNo.length - 1)}";
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 17),
                      child: Stack(
                        children: [
                          Image.asset(
                            "asset/images/card.png",
                          ),
                          Positioned(
                            top: 15,
                            right: 13,
                            child: GestureDetector(
                              child: Icon(
                                listCard[index].cardInvisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: Colors.white,
                              ),
                              onTap: () {
                                setState(() {
                                  listCard[index].cardInvisible =
                                      !listCard[index].cardInvisible;
                                });
                              },
                            ),
                          ),
                          Positioned(
                            bottom: 30,
                            left: 13,
                            child: Text(
                              listCard[index].cardInvisible
                                  ? listCard[index].cardNo
                                  : listCard[index].cardNoInvisible,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 17,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                          Positioned(
                            bottom: 15,
                            left: 13,
                            child: Text(
                              listCard[index].fullName,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
