import 'package:flutter/material.dart';

class VacinasPage extends StatelessWidget {
  const VacinasPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context); // Volta para a tela anterior
          },
        ),
        title: const Text('Vacinas', style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: Container(
        color: const Color(0xFFF2EAEA),
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            const SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                hintText: 'Informe sua cidade',
                prefixIcon: const Icon(Icons.location_city),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                fillColor: Colors.white,
                filled: true,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Próximas vacinas da sua cidade:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            const VacinaCard(
              nome: 'COVID-19',
              local: 'Hospital Santa Luzia',
              data: '12/12/2024',
              disponivel: true,
            ),
            const VacinaCard(
              nome: 'INFLUENZA',
              local: 'Hospital Santa Luzia',
              data: '11/10/2024',
              disponivel: true,
            ),
            const VacinaCard(
              nome: 'H1N1',
              local: 'Hospital Tramandaí',
              data: '07/08/2024',
              disponivel: true,
            ),
          ],
        ),
      ),
    );
  }
}

class VacinaCard extends StatelessWidget {
  final String nome;
  final String local;
  final String data;
  final bool disponivel;

  const VacinaCard({
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
          child: Icon(Icons.vaccines, color: Colors.white),
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


