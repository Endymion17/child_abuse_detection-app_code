import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'homepage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FeedbackPage extends StatefulWidget {
  const FeedbackPage({Key? key}) : super(key: key);

  @override
  _FeedbackPageState createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
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
      'question': 'Question 1: How often does your child display low self-esteem or lack of confidence?',
      'type': 'option',
      'options': [
        'Never',
        'Rarely',
        'Occasionally',
        'Frequently',
        'Very often'
      ],
    },
    {
      'question': 'Question 2: To what extent does your child exhibit excessive fear or anxiety?',
      'type': 'option',
      'options': [
        'Never',
        'Rarely',
        'Occasionally',
        'Frequently',
        'Very often'
      ],
    },
    {
      'question': 'Question 3: How frequently does your child demonstrate withdrawal or isolation from social activities?',
      'type': 'option',
      'options': [
        'Never',
        'Rarely',
        'Occasionally',
        'Frequently',
        'Very often'
      ],
    },
    {
      'question': 'Question 4: How often does your child exhibit signs of depression, such as persistent sadness or loss of interest in previously enjoyed activities?',
      'type': 'option',
      'options': [
        'Never',
        'Rarely',
        'Occasionally',
        'Frequently',
        'Very often'
      ],
    },
    {
      'question': 'Question 5: Has your child exhibited excessive clinginess or a strong desire to avoid being alone with certain individuals?',
      'type': 'option',
      'options': [
        'Never',
        'Rarely',
        'Occasionally',
        'Frequently',
        'Very often'
      ],
    },
    {
      'question': 'Question 6: How often does your child have unexplained bruises, cuts, or injuries?',
      'type': 'option',
      'options': [
        'Never',
        'Rarely',
        'Occasionally',
        'Frequently',
        'Very often'
      ],
    },
    {
      'question': 'Question 7: To what extent does your child complain of physical pain without an apparent cause?',
      'type': 'option',
      'options': [
        'Never',
        'Rarely',
        'Occasionally',
        'Frequently',
        'Very often'
      ],
    },
    {
      'question': 'Question 8: How frequently does your child display flinching or a fear of physical contact?',
      'type': 'option',
      'options': [
        'Never',
        'Rarely',
        'Occasionally',
        'Frequently',
        'Very often'
      ],
    },
    {
      'question': 'Question 9: Have you observed any sudden changes in your child\'s sleep patterns, such as nightmares, difficulty falling asleep, or fear of sleeping alone?',
      'type': 'option',
      'options': [
        'Never',
        'Rarely',
        'Occasionally',
        'Frequently',
        'Very often'
      ],
    },
    {
      'question': 'Question 10: How frequently does your child engage in self-harming behaviors or display signs of self-blame or guilt?',
      'type': 'option',
      'options': [
        'Never',
        'Rarely',
        'Occasionally',
        'Frequently',
        'Very often'
      ],
    },
    {
      'question': 'Question 11: How often does your child exhibit sudden changes in behavior, mood, or personality without a clear explanation?',
      'type': 'option',
      'options': [
        'Never',
        'Rarely',
        'Occasionally',
        'Frequently',
        'Very often'
      ],
    },
    {
      'question': 'Question 12: Does your child demonstrate discomfort or fear when changing clothes or during bathing?',
      'type': 'option',
      'options': [
        'Never',
        'Rarely',
        'Occasionally',
        'Frequently',
        'Very often'
      ],
    },
    {
      'question': 'Question 13: Does your child exhibit unexplained aggression or violent behaviour towards others?',
      'type': 'option',
      'options': [
        'Never',
        'Rarely',
        'Occasionally',
        'Frequently',
        'Very often'
      ],
    },
    {
      'question': 'Question 14: Have you noticed any unexplained sexualised behaviours or knowledge beyond age-appropriate for your child?',
      'type': 'option',
      'options': [
        'Never',
        'Rarely',
        'Occasionally',
        'Frequently',
        'Very often'
      ],
    },
    {
      'question': 'Question 15: Does your child have difficulty trusting others or forming healthy relationships?',
      'type': 'option',
      'options': [
        'Never',
        'Rarely',
        'Occasionally',
        'Frequently',
        'Very often'
      ],
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
        title: Text(
            "Feedback Page", style: GoogleFonts.questrial(fontSize: 28)),
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
                  transitionsBuilder: (context, animation, secondaryAnimation,
                      child) {
                    const Offset begin = Offset(-1.0, 0.0);
                    const Offset end = Offset.zero;
                    const curve = Curves.ease;

                    final tween = Tween(begin: begin, end: end).chain(
                        CurveTween(curve: curve));

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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                "This questionnaire should not be used as a definitive abuse diagnosis but as an initial screening tool.",
                style: GoogleFonts.questrial(fontSize: 22,fontWeight: FontWeight.bold),
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
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
                            String option =
                            questions[index]['options'][optionIndex];
                            return ListTile(
                              title: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    answers[index]['answer'] = option;
                                  });
                                },
                                child: Text(
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

                                  _firestore
                                      .collection('answers')
                                      .doc(index.toString())
                                      .set({
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
                );
              },
            ),
          ],
        ),
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
    QuerySnapshot querySnapshot = await _firestore.collection('answers').get();
    List<QueryDocumentSnapshot> documents = querySnapshot.docs;

    int M = 0;
    int P = 0;
    int S = 0;
    String result = "";
    for (var document in documents) {
      Map<String, dynamic> data = document.data() as Map<String, dynamic>;
      String answer = data['answer'].toString();
      String question = data['question'];

      // Perform scoring logic based on the answer
      // Add score calculation code based on the question and answer format (option or text)
      if (question == 'Question 1: How often does your child display low self-esteem or lack of confidence?') {
        if (answer == 'Never') {
          M += 1 * 7;
          P += 1 * 3;
          S += 1 * 3;
        } else if (answer == 'Rarely') {
          M += 2 * 7;
          P += 2 * 3;
          S += 2 * 3;
        } else if (answer == 'Occasionally') {
          M += 3 * 7;
          P += 3 * 3;
          S += 3 * 3;
        } else if (answer == 'Frequently') {
          M += 4 * 7;
          P += 4 * 3;
          S += 4 * 3;
        } else if (answer == 'Very often') {
          M += 5 * 7;
          P += 5 * 3;
          S += 5 * 3;
        }
        } else if (question == 'Question 2: To what extent does your child exhibit excessive fear or anxiety?') {
          if (answer == 'Never') {
            M += 1 * 8;
            P += 1 * 3;
            S += 1 * 3;
          } else if (answer == 'Rarely') {
            M += 2 * 8;
            P += 2 * 3;
            S += 2 * 3;
          } else if (answer == 'Occasionally') {
            M += 3 * 8;
            P += 3 * 3;
            S += 3 * 3;
          } else if (answer == 'Frequently') {
            M += 4 * 8;
            P += 4 * 3;
            S += 4 * 3;
          } else if (answer == 'Very often') {
            M += 5 * 8;
            P += 5 * 3;
            S += 5 * 3;
          }
        }
        else if (question == 'Question 3: How frequently does your child demonstrate withdrawal or isolation from social activities?') {
          if (answer == 'Never') {
            M += 1 * 8;
            P += 1 * 3;
            S += 1 * 3;
          } else if (answer == 'Rarely') {
            M += 2 * 8;
            P += 2 * 3;
            S += 2 * 3;
          } else if (answer == 'Occasionally') {
            M += 3 * 8;
            P += 3 * 3;
            S += 3 * 3;
          } else if (answer == 'Frequently') {
            M += 4 * 8;
            P += 4 * 3;
            S += 4 * 3;
          } else if (answer == 'Very often') {
            M += 5 * 8;
            P += 5 * 3;
            S += 5 * 3;
          }
        }
        else if (question == 'Question 4: How often does your child exhibit signs of depression, such as persistent sadness or loss of interest in previously enjoyed activities?') {
          if (answer == 'Never') {
            M += 1 * 9;
            P += 1 * 3;
            S += 1 * 3;
          } else if (answer == 'Rarely') {
            M += 2 * 9;
            P += 2 * 3;
            S += 2 * 3;
          } else if (answer == 'Occasionally') {
            M += 3 * 9;
            P += 3 * 3;
            S += 3 * 3;
          } else if (answer == 'Frequently') {
            M += 4 * 9;
            P += 4 * 3;
            S += 4 * 3;
          } else if (answer == 'Very often') {
            M += 5 * 9;
            P += 5 * 3;
            S += 5 * 3;
          }
        }
        else if (question == 'Question 5: Has your child exhibited excessive clinginess or a strong desire to avoid being alone with certain individuals?') {
          if (answer == 'Never') {
            M += 1 * 6;
            P += 1 * 6;
            S += 1 * 6;
          } else if (answer == 'Rarely') {
            M += 2 * 6;
            P += 2 * 6;
            S += 2 * 6;
          } else if (answer == 'Occasionally') {
            M += 3 * 6;
            P += 3 * 6;
            S += 3 * 6;
          } else if (answer == 'Frequently') {
            M += 4 * 6;
            P += 4 * 6;
            S += 4 * 6;
          } else if (answer == 'Very often') {
            M += 5 * 6;
            P += 5 * 6;
            S += 5 * 6;
          }
        }
        else if (question == 'Question 6: How often does your child have unexplained bruises, cuts, or injuries?') {
          if (answer == 'Never') {
            M += 1 * 3;
            P += 1 * 10;
            S += 1 * 6;
          } else if (answer == 'Rarely') {
            M += 2 * 3;
            P += 2 * 10;
            S += 2 * 6;
          } else if (answer == 'Occasionally') {
            M += 3 * 3;
            P += 3 * 10;
            S += 3 * 6;
          } else if (answer == 'Frequently') {
            M += 4 * 3;
            P += 4 * 10;
            S += 4 * 6;
          } else if (answer == 'Very often') {
            M += 5 * 3;
            P += 5 * 10;
            S += 5 * 6;
          }
        }
        else if (question == 'Question 7: To what extent does your child complain of physical pain without an apparent cause?') {
          if (answer == 'Never') {
            M += 1 * 4;
            P += 1 * 8;
            S += 1 * 6;
          } else if (answer == 'Rarely') {
            M += 2 * 4;
            P += 2 * 8;
            S += 2 * 6;
          } else if (answer == 'Occasionally') {
            M += 3 * 4;
            P += 3 * 8;
            S += 3 * 6;
          } else if (answer == 'Frequently') {
            M += 4 * 4;
            P += 4 * 8;
            S += 4 * 6;
          } else if (answer == 'Very often') {
            M += 5 * 4;
            P += 5 * 8;
            S += 5 * 6;
          }
        }
        else if (question == 'Question 8: How frequently does your child display flinching or a fear of physical contact?') {
          if (answer == 'Never') {
            M += 1 * 4;
            P += 1 * 8;
            S += 1 * 8;
          } else if (answer == 'Rarely') {
            M += 2 * 4;
            P += 2 * 8;
            S += 2 * 8;
          } else if (answer == 'Occasionally') {
            M += 3 * 4;
            P += 3 * 8;
            S += 3 * 8;
          } else if (answer == 'Frequently') {
            M += 4 * 4;
            P += 4 * 8;
            S += 4 * 8;
          } else if (answer == 'Very often') {
            M += 5 * 4;
            P += 5 * 8;
            S += 5 * 8;
          }
        }
        else if (question == 'Question 9: Have you observed any sudden changes in your child\'s sleep patterns, such as nightmares, difficulty falling asleep, or fear of sleeping alone?') {
          if (answer == 'Never') {
            M += 1 * 7;
            P += 1 * 4;
            S += 1 * 5;
          } else if (answer == 'Rarely') {
            M += 2 * 7;
            P += 2 * 4;
            S += 2 * 5;
          } else if (answer == 'Occasionally') {
            M += 3 * 7;
            P += 3 * 4;
            S += 3 * 5;
          } else if (answer == 'Frequently') {
            M += 4 * 7;
            P += 4 * 4;
            S += 4 * 5;
          } else if (answer == 'Very often') {
            M += 5 * 7;
            P += 5 * 4;
            S += 5 * 5;
          }
        }
        else if (question == 'Question 10: How frequently does your child engage in self-harming behaviors or display signs of self-blame or guilt?') {
          if (answer == 'Never') {
            M += 1 * 8;
            P += 1 * 6;
            S += 1 * 8;
          } else if (answer == 'Rarely') {
            M += 2 * 8;
            P += 2 * 6;
            S += 2 * 8;
          } else if (answer == 'Occasionally') {
            M += 3 * 8;
            P += 3 * 6;
            S += 6 * 8;
          } else if (answer == 'Frequently') {
            M += 4 * 8;
            P += 4 * 6;
            S += 4 * 8;
          } else if (answer == 'Very often') {
            M += 5 * 8;
            P += 5 * 6;
            S += 5 * 8;
          }
        }
        else if (question == 'Question 11: How often does your child exhibit sudden changes in behavior, mood, or personality without a clear explanation?') {
          if (answer == 'Never') {
            M += 1 * 7;
            P += 1 * 3;
            S += 1 * 5;
          } else if (answer == 'Rarely') {
            M += 2 * 7;
            P += 2 * 3;
            S += 2 * 5;
          } else if (answer == 'Occasionally') {
            M += 3 * 7;
            P += 3 * 3;
            S += 3 * 5;
          } else if (answer == 'Frequently') {
            M += 4 * 7;
            P += 4 * 3;
            S += 4 * 5;
          } else if (answer == 'Very often') {
            M += 5 * 7;
            P += 5 * 3;
            S += 5 * 5;
          }
        } else if (question == 'Question 12: Does your child demonstrate discomfort or fear when changing clothes or during bathing?') {
          if (answer == 'Never') {
            M += 1 * 4;
            P += 1 * 3;
            S += 1 * 9;
          } else if (answer == 'Rarely') {
            M += 2 * 4;
            P += 2 * 3;
            S += 2 * 9;
          } else if (answer == 'Occasionally') {
            M += 3 * 4;
            P += 3 * 3;
            S += 3 * 9;
          } else if (answer == 'Frequently') {
            M += 4 * 4;
            P += 4 * 3;
            S += 4 * 9;
          } else if (answer == 'Very often') {
            M += 5 * 4;
            P += 5 * 3;
            S += 5 * 9;
          }
        } else if (question == 'Question 13: Does your child exhibit unexplained aggression or violent behaviour towards others?') {
          if (answer == 'Never') {
            M += 1 * 5;
            P += 1 * 9;
            S += 1 * 4;
          } else if (answer == 'Rarely') {
            M += 2 * 5;
            P += 2 * 9;
            S += 2 * 4;
          } else if (answer == 'Occasionally') {
            M += 3 * 5;
            P += 3 * 9;
            S += 3 * 4;
          } else if (answer == 'Frequently') {
            M += 4 * 5;
            P += 4 * 9;
            S += 4 * 4;
          } else if (answer == 'Very often') {
            M += 5 * 5;
            P += 5 * 9;
            S += 5 * 4;
          }
        }
        else if (question == 'Question 14: Have you noticed any unexplained sexualised behaviours or knowledge beyond age-appropriate for your child?') {
          if (answer == 'Never') {
            M += 1 * 3;
            P += 1 * 4;
            S += 1 * 10;
          } else if (answer == 'Rarely') {
            M += 2 * 3;
            P += 2 * 4;
            S += 2 * 10;
          } else if (answer == 'Occasionally') {
            M += 3 * 3;
            P += 3 * 4;
            S += 3 * 10;
          } else if (answer == 'Frequently') {
            M += 4 * 3;
            P += 4 * 4;
            S += 4 * 10;
          } else if (answer == 'Very often') {
            M += 5 * 3;
            P += 5 * 4;
            S += 5 * 10;
          }
        }
        else if (question == 'Question 15: Does your child have difficulty trusting others or forming healthy relationships?') {
          if (answer == 'Never') {
            M += 1 * 8;
            P += 1 * 3;
            S += 1 * 3;
          } else if (answer == 'Rarely') {
            M += 2 * 8;
            P += 2 * 3;
            S += 2 * 3;
          } else if (answer == 'Occasionally') {
            M += 3 * 8;
            P += 3 * 3;
            S += 3 * 3;
          } else if (answer == 'Frequently') {
            M += 4 * 8;
            P += 4 * 3;
            S += 4 * 3;
          } else if (answer == 'Very often') {
            M += 5 * 8;
            P += 5 * 3;
            S += 5 * 3;
          }
        }
      }
    if (S>270 && P>230) {
      result="The child’s behavioural patterns suggest that the child may be facing physical and sexual abuse. Further investigation and visiting a child abuse paediatrician are highly recommended.";
    }
    if (S>270 && P<230) {
      result = 'The child’s behavioural patterns suggest that the child may be facing sexual abuse. Further investigation and visiting a child abuse paediatrician is highly recommended.';
    }
    if (S<270 && P>230) {
      result = 'The child’s behavioural patterns suggest that the child may be facing physical abuse. Further investigation and visiting a child abuse paediatrician is highly recommended.';
    }
    if ((S > 220 && S < 270) && (P > 170 && P < 230)) {
      result = 'The child’s behavioural patterns suggest that the child may be facing physical and sexual abuse. We recommend visiting a child abuse paediatrician.';
    }
    if ((S > 220 && S < 270) && (P < 170)) {
      result = 'The child’s behavioural patterns suggest that the child may be facing sexual abuse. We recommend visiting a child abuse paediatrician.';
    }
    if ((S < 220) && (P > 170 && P < 230)) {
      result = 'The child’s behavioural patterns suggest that the child may be facing physical abuse. We recommend visiting a child abuse paediatrician.';
    }
    if (S<220 && P < 170) {
      if (M>230) {
        result = 'The child’s behavioural patterns suggest that the child may be facing mental abuse. Further investigation and visiting a child psychiatrist are highly recommended.';
      }
      if (M > 170 && M < 230) {
        result = 'The child’s behavioural patterns suggest that the child may be facing mental abuse. We recommend visiting a child psychiatrist.';
      }
      if (M<170) {
        result = 'So far, so good! The child’s behavioral patterns are free from the symptoms of any kind of abuse.';
      }
    }
    return {'result':result};
    }
  void resetTest() {
    setState(() {
      answers.clear();
      answers = List.generate(questions.length, (index) => {});
    });
    _firestore.collection('answers').get().then((snapshot) {
      for (DocumentSnapshot doc in snapshot.docs) {
        doc.reference.delete();
      }
    });
  }
}