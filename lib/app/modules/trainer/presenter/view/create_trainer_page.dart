import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:try_catch_em_all/app/modules/trainer/presenter/controllers/trainer_controller.dart';

class CreateTrainerPage extends StatelessWidget {
  CreateTrainerPage({Key? key}) : super(key: key);

  final controller = Modular.get<TrainerController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SizedBox(
        child: Column(
          children: [
            const Text("Digite seu nome de treinador:"),
            TextFormField(
              decoration: const InputDecoration(
                hintText: '(Ex: Ash)',
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () async {
                await controller.createTrainer("name", 20, "gender", "region");
              },
              child: const Text("Concluir"),
            ),
          ],
        ),
      ),
    );
  }
}
