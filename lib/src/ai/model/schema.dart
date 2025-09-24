import "package:freezed_annotation/freezed_annotation.dart";

part "schema.freezed.dart";
part "schema.g.dart";

enum SchemaType {
  @JsonValue("string")
  string,
  @JsonValue("integer")
  integer,
  @JsonValue("number")
  number,
  @JsonValue("boolean")
  boolean,
  @JsonValue("array")
  array,
  @JsonValue("object")
  object,
}

@freezed
abstract class Schema with _$Schema {
  const Schema._();

  const factory Schema({
    required SchemaType type,
    String? format,
    String? description,
    bool? nullable,
    @JsonKey(name: "enum") List<String>? enumValues,
    double? minimum,
    double? maximum,
    int? minItems,
    int? maxItems,
    Schema? items,
    Map<String, Schema>? properties,
    List<String>? required,
    List<String>? propertyOrdering,
  }) = _Schema;

  factory Schema.fromJson(Map<String, dynamic> json) => _$SchemaFromJson(json);

  factory Schema.string({
    String? format,
    String? description,
    bool? nullable,
    List<String>? enumValues,
  }) {
    return Schema(
      type: SchemaType.string,
      format: format,
      description: description,
      nullable: nullable,
      enumValues: enumValues,
    );
  }

  factory Schema.integer({
    String? format,
    String? description,
    bool? nullable,
    List<String>? enumValues,
    double? minimum,
    double? maximum,
  }) {
    return Schema(
      type: SchemaType.integer,
      format: format,
      description: description,
      nullable: nullable,
      enumValues: enumValues,
      minimum: minimum,
      maximum: maximum,
    );
  }

  factory Schema.number({
    String? format,
    String? description,
    bool? nullable,
    List<String>? enumValues,
    double? minimum,
    double? maximum,
  }) {
    return Schema(
      type: SchemaType.number,
      format: format,
      description: description,
      nullable: nullable,
      enumValues: enumValues,
      minimum: minimum,
      maximum: maximum,
    );
  }

  factory Schema.boolean({
    String? description,
    bool? nullable,
  }) {
    return Schema(
      type: SchemaType.boolean,
      description: description,
      nullable: nullable,
    );
  }

  factory Schema.array({
    required Schema items,
    String? description,
    bool? nullable,
    int? minItems,
    int? maxItems,
  }) {
    return Schema(
      type: SchemaType.array,
      items: items,
      description: description,
      nullable: nullable,
      minItems: minItems,
      maxItems: maxItems,
    );
  }

  factory Schema.object({
    required Map<String, Schema> properties,
    List<String>? required,
    String? description,
    bool? nullable,
    List<String>? propertyOrdering,
  }) {
    return Schema(
      type: SchemaType.object,
      properties: properties,
      required: required,
      description: description,
      nullable: nullable,
      propertyOrdering: propertyOrdering,
    );
  }
}

