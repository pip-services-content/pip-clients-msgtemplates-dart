import 'dart:async';

import 'package:pip_services3_components/pip_services3_components.dart';
import 'package:pip_services_msgtemplates/pip_services_msgtemplates.dart';
import 'package:test/test.dart';
import 'package:pip_services3_commons/pip_services3_commons.dart';
import 'package:pip_clients_msgtemplates/pip_clients_msgtemplates.dart';
import './MessageTemplatesClientFixtureV1.dart';

void main() {
  group('MessageTemplatesDirectClientV1', () {
    MessageTemplatesDirectClientV1 client;
    MessageTemplatesClientFixtureV1 fixture;
    MessageTemplatesMemoryPersistence persistence;
    MessageTemplatesController controller;

    setUp(() async {
      var logger = ConsoleLogger();
      persistence = MessageTemplatesMemoryPersistence();
      controller = MessageTemplatesController();
      var references = References.fromTuples([
        Descriptor('pip-services', 'logger', 'console', 'default', '1.0'),
        logger,
        Descriptor('pip-services-msgtemplates', 'persistence', 'memory',
            'default', '1.0'),
        persistence,
        Descriptor('pip-services-msgtemplates', 'controller', 'default',
            'default', '1.0'),
        controller
      ]);
      controller.setReferences(references);

      client = MessageTemplatesDirectClientV1();
      client.setReferences(references);

      fixture = MessageTemplatesClientFixtureV1(client);
      await client.open(null);
    });

    tearDown(() async {
      await client.close(null);
      await Future.delayed(Duration(milliseconds: 2000));
    });

    test('CRUD Operations', () async {
      await fixture.testCrudOperations();
    });
  });
}
