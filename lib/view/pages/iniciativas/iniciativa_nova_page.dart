import 'package:flutter/material.dart';

class NovaIniciativa extends StatefulWidget {
  const NovaIniciativa({super.key});

  @override
  State<NovaIniciativa> createState() => _NovaIniciativaState();
}

class _NovaIniciativaState extends State<NovaIniciativa> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Text(
              "Nova Iniciativa",
              style: TextStyle(
                fontFamily: 'Alegreya',
                fontWeight: FontWeight.w500,
                fontSize: 30,
                color: Colors.white,
              ),
            ),
            SizedBox(
              height: 70,
              child: TextField(
                maxLines: null,
                expands: true,
                decoration: InputDecoration(
                  hintText: "Nome da Iniciativa",
                  hintStyle: TextStyle(color: Colors.white),
                ),
                style: TextStyle(color: Colors.white),
              ),
            ),
            SizedBox(
              height: 200,
              child: TextField(
                maxLines: null,
                expands: true,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(vertical: 40),
                  hintText: "Descrição da Iniciativa",
                  hintStyle: TextStyle(color: Colors.white),
                ),
                style: TextStyle(color: Colors.white),
              ),
            ),

            SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  height: 50,
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color(0xFF7C9A92),
                  ),
                  child: Text(
                    "Cancelar",
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: "Alegreya",
                      fontWeight: FontWeight.normal,
                      fontSize: 25,
                    ),
                  ),
                ),

                Container(
                  height: 50,
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color(0xFF7C9A92),
                  ),
                  child: Text(
                    "Criar",
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: "Alegreya",
                      fontWeight: FontWeight.normal,
                      fontSize: 25,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
