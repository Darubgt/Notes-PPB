import 'dart:math';

import 'package:flutter/material.dart';
import 'package:notessss/components/Tag.dart';
import 'package:notessss/screens/NoteScreen.dart';
import 'package:notessss/types/note.dart';

class NotesScreen extends StatefulWidget {
  static const route = '/notes';
  const NotesScreen({super.key});

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  String activeTag = '';
  bool canAnimate = false;
  List<Note> notes = [];
  List<String> tags = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAllNotes();
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        canAnimate = true;
      });
    });
  }

  getAllNotes() async {
    tags = await Note.getTags();
    if (tags.isNotEmpty) activeTag = tags[0];
    notes = await Note.getNotes(tag: activeTag);
    setState(() {});
  }

  void editNote({Note? note}) async {
    await Navigator.push(context,
        MaterialPageRoute(builder: (context) => NoteScreen(note: note)));
    getAllNotes();
  }

  List<Widget> getNotes() {
    Size deviceSize = MediaQuery.of(context).size;
    List<Widget> widgets = [];

    for (var (ind, note) in notes.indexed) {
      ind++;
      widgets.add(Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: InkWell(
            child: Column(children: [
              Container(
                height: 1,
                color: Colors.white,
                margin: const EdgeInsets.symmetric(vertical: 16),
              ),
              Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                AnimatedSize(
                  curve: Curves.ease,
                  duration: Duration(milliseconds: 800 + (200 * ind)),
                  child: Container(width: canAnimate ? 0 : deviceSize.width),
                ),
                Column(
                    // crossAxisAlignment: CrossAxisAlignment.s,
                    children: [
                      Container(
                        color: const Color(0xFFF5F5F5),
                        height: 1,
                      ),
                      Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              ind < 10 ? '0$ind /' : '$ind /',
                              style: const TextStyle(
                                  fontSize: 20, color: Color(0x76F5F5F5)),
                            ),
                            const SizedBox(
                              width: 16,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  note.title,
                                  style: const TextStyle(fontSize: 32),
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  '${note.content.substring(
                                          0, min(note.content.length, 50))}...',
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  softWrap: false,
                                  style: const TextStyle(
                                      fontSize: 14, color: Color(0x76F5F5F5)),
                                )
                              ],
                            )
                          ])
                    ])
              ])
            ]),
            onTap: () => editNote(note: note),
          )));
    }

    return widgets;
  }

  void selectTag(tag) async {
    if (tag == activeTag) return;
    setState(() {
      canAnimate = false;
    });
    Future.delayed(const Duration(milliseconds: 1000), () async {
      activeTag = tag;
      notes = await Note.getNotes(tag: activeTag);
      setState(() {});
      setState(() {
        canAnimate = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Size deviceSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Stack(children: [
        Positioned(
          bottom: 0,
          left: 0,
          top: 0,
          right: 0,
          child: SingleChildScrollView(
            physics:
                BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
            scrollDirection: Axis.vertical,
            child: Column(children: [
              AnimatedOpacity(
                curve: Curves.ease,
                opacity: canAnimate ? 1 : 0,
                duration: Duration(milliseconds: 300),
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                  child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Start Taking Notes',
                          style:
                              TextStyle(fontSize: 16, color: Color(0x76F5F5F5)),
                        ),
                        Expanded(child: Container()),
                        InkWell(
                          onTap: () => editNote(),
                          child: Icon(Icons.add),
                        )
                      ]),
                ),
              ),
              AnimatedSize(
                  curve: Curves.ease,
                  duration: Duration(milliseconds: 400),
                  child: Container(
                    color: Color(0xFFF5F5F5),
                    height: 1,
                    width: canAnimate ? null : 0,
                    margin: EdgeInsets.symmetric(horizontal: 16),
                  )),
              AnimatedOpacity(
                curve: Curves.ease,
                opacity: canAnimate ? 1 : 0,
                duration: Duration(milliseconds: 600),
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.only(left: 64, bottom: 16),
                      margin: EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text('Notes', style: TextStyle(fontSize: 62)),
                            Expanded(child: Container()),
                            Text('/${notes.length}',
                                style: TextStyle(
                                    fontSize: 48,
                                    color: Color.fromARGB(118, 245, 245, 245))),
                          ]),
                    ),
                  ],
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics()),
                  scrollDirection: Axis.horizontal,
                  child: Row(children: [
                    AnimatedSize(
                      duration: Duration(milliseconds: 600),
                      curve: Curves.ease,
                      child:
                          Container(width: canAnimate ? 0 : deviceSize.width),
                    ),
                    SizedBox(
                      width: 32,
                    ),
                    ...tags
                        .map((tag) => Row(children: [
                              InkWell(
                                  borderRadius: BorderRadius.circular(999),
                                  onTap: () => selectTag(tag),
                                  child: TagComponent(
                                    label: tag,
                                    active: activeTag == tag,
                                  )),
                              SizedBox(
                                width: 16,
                              ),
                            ]))
                        ,
                    SizedBox(
                      width: 32,
                    ),
                  ]),
                ),
              ),
              Column(
                children: getNotes(),
              )
            ]),
          ),
        )
      ]),
    );
  }
}
