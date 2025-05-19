import 'package:flutter/material.dart';

class ExamesPage extends StatelessWidget {
  const ExamesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text('Exames', style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: Container(
        color: const Color(0xFFF2EAEA),
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
            ),
            const SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                hintText: 'Pesquise por exame ou local',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                fillColor: Colors.white,
                filled: true,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Exames disponíveis na sua cidade:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            const ExameCard(
              nome: 'Hemograma completo',
              local: 'Laboratório Vida',
              data: '15/05/2025',
              disponivel: true,
            ),
            const ExameCard(
              nome: 'Raio-X de Tórax',
              local: 'Clínica Diagnóstica Sul',
              data: '18/05/2025',
              disponivel: false,
            ),
            const ExameCard(
              nome: 'Ultrassom abdominal',
              local: 'Hospital Municipal',
              data: '20/05/2025',
              disponivel: true,
            ),
          ],
        ),
      ),
    );
  }
}

class ExameCard extends StatelessWidget {
  final String nome;
  final String local;
  final String data;
  final bool disponivel;

  const ExameCard({
    super.key,
    required this.nome,
    required this.local,
    required this.data,
    required this.disponivel,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 3,
      child: ListTile(
        leading: const CircleAvatar(
          backgroundColor: Colors.redAccent,
          child: Icon(Icons.biotech, color: Colors.white),
        ),
        title: Text(nome, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Local: $local"),
            Text("Data: $data"),
            Text("Disponível: ${disponivel ? 'SIM' : 'NÃO'}"),
          ],
        ),
      ),
    );
  }
}
