import 'package:flutter/material.dart';
import 'package:projeto_final/Consulta.dart';
import 'package:projeto_final/database/database_helper.dart';

class EditarConsultaPage extends StatefulWidget {
  final int? id;
  final String especialidade;
  final String local;
  final String data;
  final String hora;
  final String status;

  const EditarConsultaPage({
    super.key,
    this.id,
    required this.especialidade,
    required this.local,
    required this.data,
    required this.hora,
    required this.status,
  });

  @override
  State<EditarConsultaPage> createState() => _EditarConsultaPageState();
}

class _EditarConsultaPageState extends State<EditarConsultaPage> {
  late TextEditingController _especialidadeController;
  late TextEditingController _localController;
  late TextEditingController _dataController;
  late TextEditingController _horaController;

  @override
  void initState() {
    super.initState();
    _especialidadeController = TextEditingController(text: widget.especialidade);
    _localController = TextEditingController(text: widget.local);
    _dataController = TextEditingController(text: widget.data);
    _horaController = TextEditingController(text: widget.hora);
  }

  @override
  void dispose() {
    _especialidadeController.dispose();
    _localController.dispose();
    _dataController.dispose();
    _horaController.dispose();
    super.dispose();
  }

  // Método para salvar as alterações
  Future<void> _salvarAlteracoes() async {
    final id = widget.id;

    if (id == null) {
      print('ID não encontrado');
      return;
    }

    // Verificação dos campos
    if (_especialidadeController.text.isEmpty ||
        _localController.text.isEmpty ||
        _dataController.text.isEmpty ||
        _horaController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Preencha todos os campos')),
      );
      return;
    }

    final db = await DatabaseHelper.instance.database;

    // Verifique se o ID existe
    final result = await db.query(
      'consultas',
      where: 'id = ?',
      whereArgs: [id],
    );

    if (result.isNotEmpty) {
      final updatedConsulta = Consulta(
        id: id,
        especialidade: _especialidadeController.text,
        local: _localController.text,
        data: _dataController.text,
        hora: _horaController.text,
        status: widget.status, // Não altera o status
      );

      final rowsAffected = await DatabaseHelper.instance.updateConsulta(updatedConsulta);
      print('Registros afetados: $rowsAffected');

      if (rowsAffected > 0) {
        Navigator.pop(context); // Volta para a tela anterior
      } else {
        print('Erro ao atualizar a consulta');
      }
    } else {
      print('Consulta não encontrada com o ID: $id');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: const Text('Editar Consulta'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _especialidadeController,
              decoration: const InputDecoration(labelText: 'Especialidade'),
            ),
            TextField(
              controller: _localController,
              decoration: const InputDecoration(labelText: 'Local'),
            ),
            TextField(
              controller: _dataController,
              decoration: const InputDecoration(labelText: 'Data'),
            ),
            TextField(
              controller: _horaController,
              decoration: const InputDecoration(labelText: 'Hora'),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _salvarAlteracoes,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
              ),
              child: const Text('Salvar Alterações'),
            )
          ],
        ),
      ),
    );
  }
}






