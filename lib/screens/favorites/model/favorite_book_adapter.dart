part of 'favorite_book_model.dart';

class FavoriteBookAdapter extends TypeAdapter<FavoriteBookModel> {
  @override
  final int typeId = 0;

  @override
  FavoriteBookModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FavoriteBookModel(
      id: fields[0] as String,
      title: fields[1] as String,
      authors: fields[2] as String,
      thumbnail: fields[3] as String?,
      publishedDate: fields[4] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, FavoriteBookModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.authors)
      ..writeByte(3)
      ..write(obj.thumbnail)
      ..writeByte(4)
      ..write(obj.publishedDate);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FavoriteBookAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
