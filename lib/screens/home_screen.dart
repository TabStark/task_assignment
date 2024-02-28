import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:task_assignment/main.dart';
import 'package:task_assignment/screens/login_screen.dart';
import 'package:task_assignment/services/api.dart';
import 'package:task_assignment/utils/reusable_for_movie_name.dart';
import 'package:task_assignment/utils/timeconverter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<dynamic> movies = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final response = await http.post(
      Uri.parse('https://hoblist.com/api/movieList'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'category': 'movies',
        'language': 'kannada',
        'genre': 'all',
        'sort': 'voting'
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print('Response Data: $data'); // Print the response data
      if (data['result'] != null && data['result'] is List) {
        setState(() {
          movies = List.from(data['result']);
        });
      } else {
        print(
            'Invalid data format: ${data['result']}'); // Print the invalid data
        throw Exception('Invalid data format');
      }
    } else {
      print(
          'Failed to load data: ${response.statusCode}'); // Print the failure status code
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Geeksynergy Movies"),
        actions: [
          IconButton(
              onPressed: () {
                showAlertDialog(context);
              },
              icon: Icon(Icons.info))
        ],
      ),
      body: ListView.builder(
        itemCount: movies.length,
        itemBuilder: (context, index) {
          return Container(
            width: mq.width * 1,
            height: mq.height * 0.3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    //  Votes
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.arrow_drop_up,
                          size: 60,
                        ),
                        Text(
                          movies[index]['totalVoted'].toString(),
                          style: const TextStyle(fontSize: 20),
                        ),
                        const Icon(Icons.arrow_drop_down, size: 60),
                        const Text(
                          'Votes',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
                        )
                      ],
                    ),

                    // Movie Image
                    SizedBox(
                      width: mq.width * 0.3,
                      height: mq.height * 0.2,
                      child: Image.network(
                        movies[index]['poster'],
                      ),
                    ),

                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: mq.height * 0.03,
                          width: mq.width * 0.45,
                          child: Text(
                            movies[index]['title'],
                            maxLines: 2,
                            overflow: TextOverflow.fade,
                            style: TextStyle(
                                fontSize: 19, fontWeight: FontWeight.w500),
                          ),
                        ),

                        // Genre
                        ResuableForMovieName(
                            moviekey: 'Genre',
                            movieValue: movies[index]['genre']),

                        //  Director
                        ResuableForMovieName(
                          moviekey: 'Director',
                          movieValue: movies[index]['director'][0].toString(),
                        ),

                        // Stars
                        ResuableForMovieName(
                            moviekey: "Starring",
                            movieValue: movies[index]['stars'][0]),

                        // Language and Release Date
                        Row(
                          children: [
                            Text("Mins | "),
                            Text("${movies[index]['language'].toString()} | "),
                            Text(
                              DateTimeFormat.getFormattedTime(
                                  context: context,
                                  time: movies[index]['releasedDate']),
                              overflow: TextOverflow.ellipsis,
                            )
                          ],
                        ),

                        // Views and Voted
                        Row(
                          children: [
                            const Text(
                              "130 Views",
                              style: TextStyle(color: Colors.blue),
                            ),
                            Text(
                                " | Voted by ${movies[index]['totalVoted']} People",
                                style: TextStyle(color: Colors.blue))
                          ],
                        )
                      ],
                    ),
                  ],
                ),

                // Watch Trailer
                SizedBox(
                  width: mq.width * 0.9,
                  height: mq.height * 0.05,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        backgroundColor: Colors.blue[300]),
                    child: const Text(
                      "View Trailer",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w500),
                    ),
                    onPressed: () {},
                  ),
                )
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.grey[100],
        onPressed: () => Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginPage()),
        ),
        child: Icon(Icons.logout),
      ),
    );
  }

  showAlertDialog(BuildContext context) {
    // set up the button
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () => Navigator.pop(context),
    );

    // set up the AlertDialog
    Widget alertDialogContent = SingleChildScrollView(
      child: ConstrainedBox(
        constraints:
            BoxConstraints(maxWidth: 300), // Adjust the width as needed
        child: const Column(
          children: [
            Row(
              children: [
                Text(
                  'Company :',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text('Geeksynergy Technologies')
              ],
            ),
            Row(
              children: [
                Text(
                  'Address :',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text('Sanjayanagar, Bengaluru-56')
              ],
            ),
            Row(
              children: [
                Text(
                  'Phone :',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text('XXXXXXXXX09')
              ],
            ),
            Row(
              children: [
                Text(
                  'Email :',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text('XXXXXX@gmail.com')
              ],
            )
          ],
        ),
      ),
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("About"),
      content: alertDialogContent,
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
