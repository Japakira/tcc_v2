import 'package:flutter/material.dart';

class NovaTarefa extends StatefulWidget {
  const NovaTarefa({super.key});

  @override
  State<NovaTarefa> createState() => _NovaTarefaState();
}

class _NovaTarefaState extends State<NovaTarefa> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Text(
              "Nova Tarefa",
              style: TextStyle(fontSize: 30, color: Colors.white),
            ),
            SizedBox(
              height: 70,
              child: TextFormField(
                maxLines: null,
                expands: true,
                decoration: InputDecoration(
                  hintText: "Nome da nova Tarefa",
                  hintStyle: TextStyle(color: Colors.white),
                ),
                style: TextStyle(color: Colors.white),
              ),
            ),
            SizedBox(
              height: 200,
              child: TextFormField(
                maxLines: null,
                expands: true,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(vertical: 40),
                  hintText: "Descrição da Tarefa",
                  hintStyle: TextStyle(color: Colors.white),
                ),
                style: TextStyle(color: Colors.white),
              ),
            ),

            SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
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
