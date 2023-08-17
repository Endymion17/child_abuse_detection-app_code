import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'homepage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PsychologyTestPage extends StatefulWidget {
  const PsychologyTestPage({Key? key}) : super(key: key);

  @override
  _PsychologyTestPageState createState() => _PsychologyTestPageState();
}

class _PsychologyTestPageState extends State<PsychologyTestPage> {
  List<Map<String, dynamic>> questions = [
    /*{
      'question': 'Question 1: What is your favorite fruit?',
      'type': 'option',
      'options': ['Apple', 'Kiwi', 'Watermelon', 'Banana'],
    },
    {
      'question': 'Question 2: How many friends do you have?',
      'type': 'option',
      'options': ['0', '1-2', '6-8', '10+'],
    },
    {
      'question': 'Question 3: Does bullying happen in your school? Have you seen anyone being bullied?',
      'type': 'text',
    },
    {
      'question': 'Question 4: Do you have any problem paying attention?',
      'type': 'text',
    },
    {
      'question': 'Question 5: What are you doing during recess? Who are you spending time with?',
      'type': 'text',
    },*/
    {
      'question': 'Question 1: Hi there! Can you see this picture? How do you feel about it?',
      'type': 'image-option',
      'image': 'images/q1.png',
      'options': ['😃', '🙂', '🙁', '😫'],
    },
    {
      'question': 'Question 2: Good! Now, can you pick the picture that you like the best among the following? Which one would tell me the most about how you spend your time?',
      'type': 'option-images',
      'options': ['images/q21.png', 'images/q22.png', 'images/123.png', 'images/q24.png'],
    },
    {
      'question': 'Question 3: See this girl? How often do you feel how she’s feeling in the picture too?',
      'type': 'image-option',
      'image': 'images/q3.png',
      'options': ['All the time!', 'Most of the time', 'Umm, sometimes', 'Not a lot of times..'],
    },
    {
      'question': 'Question 4: Okay. How about this boy? How many times have you been this way too?',
      'type': 'image-option',
      'image': 'images/q4.png',
      'options': ['All the time', 'Most of the time', 'Sometimes', 'Never!'],
    },
    {
      'question': 'Question 5: And this boy standing here? Do you also feel how he’s feeling? How often?',
      'type': 'image-option',
      'image': 'images/image5.png',
      'options': ['All the time', 'Most of the time', 'Sometimes', 'Never!'],
    },
    {
      'question': 'Question 6: Yet another kid! Shouting angrily! Do you also do this? How often?',
      'type': 'image-option',
      'image': 'images/q6.png',
      'options': ['All the time', 'Most of the time', 'Sometimes', 'Never!'],
    },
    {
      'question': 'Question 7: Now, make a choice! If all of the following people ask you to play with them, who would you play with? Hmm, tough choice!',
      'type': 'option-images-text',
      'options': ['images/q71.png', 'images/q72.png', 'images/q73.png', 'images/q74.png'],
      'texts':['Your friend','Your parents','Your school teacher','No one! You would rather play by yourself']
    },
    {
      'question': 'Question 8: Okay, going good! You go to school, right? You must be having meal times at school! Which of the following images best represent those meal times?',
      'type': 'option-images',
      'options': ['images/q81.png', 'images/q82.png', 'images/q83.png', 'images/q84.png'],
    },
    {
      'question': 'Question 9: Imagine your friend dropping your favourite food on the floor during mealtime! You really wanted to eat it, but cannot anymore. Will you get angry at your friend? How will your anger look like? (pics depicting anger)',
      'type': 'option-images',
      'options': ['images/q91.png', 'images/q92.png', 'images/q93.png', 'images/q94.png'],
    },
    {
      'question': 'Question 10: When you go to sleep at night, which of the following pictures best shows how you look when you sleep?',
      'type': 'option-images',
      'options': ['images/q101.png', 'images/q102.png', 'images/q103.png', 'images/q104.png'],
    },
    {
      'question': 'Question 11: When you fall asleep, you must have dreams, right? What do you usually dream about?',
      'type': 'option-images-text',
      'options': ['images/q111.png', 'images/q112.png', 'images/q113.png', 'images/q114.png'],
      'texts':['Happy things, things I want!','Me and my friends playing!','Scary things…','Nothing at all.']
    },
    {
      'question': 'Question 12: Have a look at this picture, and tell me how it makes you feel!',
      'type': 'image-option',
      'image': 'images/q12.png',
      'options': ['😃', '🙂', '🙁', '😫'],
    },
    // Add more questions here
  ];

  late List<Map<String, dynamic>> answers;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    answers = List.generate(questions.length, (index) => {});
    Firebase.initializeApp();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Psychology Test", style: GoogleFonts.questrial(fontSize: 28)),
        centerTitle: true,
        backgroundColor: Colors.pinkAccent,
        systemOverlayStyle: SystemUiOverlayStyle.light,
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) {
                    return const MyHomePage(title: "Home Page");
                  },
                  transitionsBuilder: (context, animation, secondaryAnimation, child) {
                    const Offset begin = Offset(-1.0, 0.0);
                    const Offset end = Offset.zero;
                    const curve = Curves.ease;

                    final tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

                    return SlideTransition(
                      position: animation.drive(tween),
                      child: child,
                    );
                  },
                  transitionDuration: const Duration(milliseconds: 500),
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: Image.asset(
                'images/LOGO.png',
                width: 34,
                height: 34,
              ),
            ),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: questions.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  questions[index]['question'],
                  style: GoogleFonts.questrial(fontSize: 22),
                ),
                const SizedBox(height: 8),
                if (questions[index]['type'] == 'option')
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: questions[index]['options'].length,
                    itemBuilder: (context, optionIndex) {
                      String option = questions[index]['options'][optionIndex];
                      return ListTile(
                        title: GestureDetector(
                          onTap: () {
                            setState(() {
                              answers[index]['answer'] = option;
                            });
                          },
                        child:Text(
                          option,
                          style: GoogleFonts.questrial(fontSize: 20),
                        ),
                      ),
                        leading: Radio(
                          value: option,
                          groupValue: answers[index]['answer'],
                          onChanged: (value) {
                            setState(() {
                              answers[index] = {
                                'question': questions[index]['question'],
                                'answer': value,
                              };
                            });

                            _firestore.collection('psych').doc(index.toString()).set({
                              'question': questions[index]['question'],
                              'answer': value,
                            });
                          },
                        ),
                      );
                    },
                  ),
                if (questions[index]['type'] == 'text')
                  TextField(
                    onChanged: (value) {
                      setState(() {
                        answers[index] = {
                          'question': questions[index]['question'],
                          'answer': value,
                        };
                      });

                      _firestore.collection('psych').doc(index.toString()).set({
                        'question': questions[index]['question'],
                        'answer': value,
                      });
                    },
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Answer',
                    ),
                  ),
                if (questions[index]['type'] == 'image-option')
                  Column(
                    children: [
                      Image.asset(
                        questions[index]['image'],
                        width: 150,
                        height: 150,
                      ),
                      const SizedBox(height: 8),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: questions[index]['options'].length,
                        itemBuilder: (context, optionIndex) {
                          String option = questions[index]['options'][optionIndex];
                          return ListTile(
                            title: GestureDetector(
                              onTap: () {
                                setState(() {
                                  answers[index]['answer'] = option;
                                });
                              },
                              child:Text(
                                option,
                                style: GoogleFonts.questrial(fontSize: 20),
                              ),
                            ),
                            leading: Radio(
                              value: option,
                              groupValue: answers[index]['answer'],
                              onChanged: (value) {
                                setState(() {
                                  answers[index] = {
                                    'question': questions[index]['question'],
                                    'answer': value,
                                  };
                                });

                                _firestore.collection('psych').doc(index.toString()).set({
                                  'question': questions[index]['question'],
                                  'answer': value,
                                });
                              },
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                if (questions[index]['type'] == 'option-images')
                  Column(
                    children: [
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: questions[index]['options'].length,
                        itemBuilder: (context, optionIndex) {
                          String option = questions[index]['options'][optionIndex];
                          return ListTile(
                            title: GestureDetector(
                              onTap: () {
                                setState(() {
                                  answers[index]['answer'] = option;
                                });
                              },
                              child: Image.asset(
                                option,
                                width: 150,
                                height: 150,
                              ),
                            ),
                            leading: Radio(
                              value: option,
                              groupValue: answers[index]['answer'],
                              onChanged: (value) {
                                setState(() {
                                  answers[index] = {
                                    'question': questions[index]['question'],
                                    'answer': value,
                                  };
                                });

                                _firestore.collection('psych').doc(index.toString()).set({
                                  'question': questions[index]['question'],
                                  'answer': value,
                                });
                              },
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                if (questions[index]['type'] == 'option-images-text')
                  Column(
                    children: [
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: questions[index]['options'].length,
                        itemBuilder: (context, optionIndex) {
                          String option = questions[index]['options'][optionIndex];
                          String text = questions[index]['texts'][optionIndex];
                          return ListTile(
                            title: GestureDetector(
                              onTap: () {
                                setState(() {
                                  answers[index]['answer'] = option;
                                });
                              },
                              child: Column(
                                children: [
                                  Image.asset(
                                    option,
                                    width: 150,
                                    height: 150,
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    text,
                                    style: GoogleFonts.questrial(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            leading: Radio(
                              value: option,
                              groupValue: answers[index]['answer'],
                              onChanged: (value) {
                                setState(() {
                                  answers[index] = {
                                    'question': questions[index]['question'],
                                    'answer': value,
                                  };
                                });

                                _firestore.collection('psych').doc(index.toString()).set({
                                  'question': questions[index]['question'],
                                  'answer': value,
                                });
                              },
                            ),
                          );
                        },
                      ),
                    ],
                  ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Map<String, String> score = await calculateScore();
          String result = score['result'] ?? 'Error';
          String resultText = result;

          // ignore: use_build_context_synchronously
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Analysis',style: GoogleFonts.questrial(fontSize: 22,fontWeight: FontWeight.bold)),
                content: Text(resultText,style: GoogleFonts.questrial(fontSize: 24)),
                actions: [
                  TextButton(
                    child: Text('OK',style: GoogleFonts.questrial(fontSize: 18)),
                    onPressed: () {
                      resetTest();
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const MyHomePage(
                            title: 'Home Page',
                          ),
                        ),
                      );
                    },
                  ),
                ],
              );
            },
          );
        },
        backgroundColor: Colors.pinkAccent,
        child: const Icon(Icons.check),
      ),
    );
  }


  Future<Map<String, String>> calculateScore() async {
    QuerySnapshot querySnapshot = await _firestore.collection('psych').get();
    List<QueryDocumentSnapshot> documents = querySnapshot.docs;

    int score = 0;
    String result = "";
    for (var document in documents) {
      Map<String, dynamic> data = document.data() as Map<String, dynamic>;
      String answer = data['answer'].toString();
      String question = data['question'];

      // Perform scoring logic based on the answer
      // Add score calculation code based on the question and answer format (option or text)
      if (question ==
          'Question 1: Hi there! Can you see this picture? How do you feel about it?') {
        if (answer == '😃' ) {
          score += 10;
        } else if (answer == '🙂') {
          score += 9;
        } else if (answer == '🙁') {
          score += 3;
        } else if (answer == '😫') {
          score += 1;
        }
      } else if (question ==
          'Question 2: Good! Now, can you pick the picture that you like the best among the following? Which one would tell me the most about how you spend your time?') {
        if (answer == 'images/q21.png') {
          score += 8;
        } else if (answer == 'images/q22.png') {
          score += 10;
        } else if (answer == 'images/123.png') {
          score += 7;
        } else if (answer == 'images/q24.png') {
          score += 1;
        }
      } else if (question ==
          'Question 3: See this girl? How often do you feel how she’s feeling in the picture too?') {
        if (answer == 'All the time!') {
          score += 10;
        } else if (answer == 'Most of the time') {
          score += 9;
        } else if (answer == 'Umm, sometimes') {
          score += 6;
        } else if (answer == 'Not a lot of times..') {
          score += 3;
        }
      } else if (question ==
          'Question 4: Okay. How about this boy? How many times have you been this way too?') {
        if (answer == 'All the time') {
          score += 1;
        } else if (answer == 'Most of the time') {
          score += 3;
        } else if (answer == 'Sometimes') {
          score += 7;
        } else if (answer == 'Never!') {
          score += 10;
        }
      } else if (question ==
          'Question 5: And this boy standing here? Do you also feel how he’s feeling? How often?') {
        if (answer == 'All the time') {
          score += 5;
        } else if (answer == 'Most of the time') {
          score += 5;
        } else if (answer == 'Sometimes') {
          score += 7;
        } else if (answer == 'Never!') {
          score += 8;
        }
      } else if (question ==
          'Question 6: Yet another kid! Shouting angrily! Do you also do this? How often?') {
        if (answer == 'All the time') {
          score += 1;
        } else if (answer == 'Most of the time') {
          score += 2;
        } else if (answer == 'Sometimes') {
          score += 6;
        } else if (answer == 'Never!') {
          score += 9;
        }
      } else if (question ==
          'Question 7: Now, make a choice! If all of the following people ask you to play with them, who would you play with? Hmm, tough choice!') {
        if (answer == 'images/q71.png') {
          score += 10;
        } else if (answer == 'images/q72.png') {
          score += 8;
        } else if (answer == 'images/q73.png') {
          score += 7;
        } else if (answer == 'images/q74.png') {
          score += 5;
        }
      } else if (question ==
          'Question 8: Okay, going good! You go to school, right? You must be having meal times at school! Which of the following images best represent those meal times?') {
        if (answer == 'images/q81.png') {
          score += 10;
        } else if (answer == 'images/q82.png') {
          score += 8;
        } else if (answer == 'images/q83.png') {
          score += 7;
        } else if (answer == 'images/q84.png') {
          score += 3;
        }
      } else if (question ==
          'Question 9: Imagine your friend dropping your favourite food on the floor during mealtime! You really wanted to eat it, but cannot anymore. Will you get angry at your friend? How will your anger look like? (pics depicting anger)') {
        if (answer == 'images/q91.png') {
          score += 3;
        } else if (answer == 'images/q92.png') {
          score += 1;
        } else if (answer == 'images/q93.png') {
          score += 8;
        } else if (answer == 'images/q94.png') {
          score += 5;
        }
      } else if (question ==
          'Question 10: When you go to sleep at night, which of the following pictures best shows how you look when you sleep?') {
        if (answer == 'images/q101.png') {
          score += 10;
        } else if (answer == 'images/q102.png') {
          score += 5;
        } else if (answer == 'images/q103.png') {
          score += 2;
        } else if (answer == 'images/q104.png') {
          score += 7;
        }
      } else if (question ==
          'Question 11: When you fall asleep, you must have dreams, right? What do you usually dream about?') {
        if (answer == 'images/q111.png') {
          score += 9;
        } else if (answer == 'images/q112.png') {
          score += 10;
        } else if (answer == 'images/113.png') {
          score += 3;
        } else if (answer == 'images/q114.png') {
          score += 6;
        }
      } else if (question ==
          'Question 12: Have a look at this picture, and tell me how it makes you feel!') {
        if (answer == '😃' ) {
          score += 10;
        } else if (answer == '🙂') {
          score += 8;
        } else if (answer == '🙁') {
          score += 6;
        } else if (answer == '😫') {
          score += 4;
        }
      }
    }
    if (score>=29 && score<=45) {
      result="The child’s mental health is not in the best state possible, as indicated by most of his/her preferences. We recommend consulting a mental health professional.";
    }
    if (score>=46 && score<=70) {
      result = 'Based on some of his/her preferences, the child’s mental health could be better. It can improve with more attention and care.';
    }
    if (score>=71 && score<=115) {
      result = 'So far, so good! Everything looks fine. The child’s mental health is normal.';
    }
    return {'result':result};
  }
  void resetTest() {
    setState(() {
      answers.clear();
      answers = List.generate(questions.length, (index) => {});
    });
    _firestore.collection('psych').get().then((snapshot) {
      for (DocumentSnapshot doc in snapshot.docs) {
        doc.reference.delete();
      }
    });
  }
}
