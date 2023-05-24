import 'dart:async';
import 'package:conduit/conduit.dart';

Future main() async {
  final app = Application<EmptyChannel>()
    ..options.configurationFilePath = "config.yaml"
    ..options.port = 8080;

  await app.start(numberOfInstances: 1);
  print("Server started on port ${app.options.port}.");
}

class EmptyChannel extends ApplicationChannel {
  @override
  Future prepare() async {
    logger.onRecord.listen((record) {
      print("$record");
    });
  }

  @override
  Controller get entryPoint {
    final router = Router();

    router.route("/").linkFunction((request) async {
      return Response.ok({"message": "Bienvenue dans l'API!"});
    });

    router.route("/users/:id").linkFunction((request) async {
      final id = int.tryParse(request.path.variables["id"] ?? "");
      if (id == null) {
        return Response.notFound();
      }
      return Response.ok({"id": id, "name": "User $id"});
    });

    router.route("/users").linkFunction((request) async {
      return Response.ok([
        {"id": 1, "name": "Alice"},
        {"id": 2, "name": "Bob"},
        {"id": 3, "name": "Claire"}
      ]);
    });

    return router;
  }
}
