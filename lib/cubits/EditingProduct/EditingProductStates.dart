// ignore_for_file: file_names

class Edit {}

class EditNotFinish extends Edit {}

class StoringSuccess extends Edit {
  late String message;
  StoringSuccess() {
    message = 'Product Added Successfully';
  }
}

class StoringFailed extends Edit {
  late String message;
  StoringFailed() {
    message = 'Error, try again';
  }
}
