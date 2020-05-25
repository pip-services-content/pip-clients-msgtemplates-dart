import 'dart:async';
import 'package:pip_services3_commons/pip_services3_commons.dart';
import './MessageTemplateV1.dart';
import './IMessageTemplatesClientV1.dart';

class MessageTemplatesNullClientV1 implements IMessageTemplatesClientV1 {
  @override
  Future<DataPage<MessageTemplateV1>> getTemplates(
      String correlationId, FilterParams filter, PagingParams paging) async {
    return DataPage<MessageTemplateV1>([], 0);
  }

  @override
  Future<MessageTemplateV1> getTemplateById(
      String correlationId, String id) async {
    return null;
  }

  @override
  Future<MessageTemplateV1> getTemplateByIdOrName(
      String correlationId, String idOrName) async {
    return null;
  }

  @override
  Future<MessageTemplateV1> createTemplate(
      String correlationId, MessageTemplateV1 template) {
    return null;
  }

  @override
  Future<MessageTemplateV1> updateTemplate(
      String correlationId, MessageTemplateV1 template) {
    return null;
  }

  @override
  Future<MessageTemplateV1> deleteTemplateById(
      String correlationId, String id) {
    return null;
  }
}
