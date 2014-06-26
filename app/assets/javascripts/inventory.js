$(function(){
  Dropzone.options.myDropzone = {
    paramName: "file", // The name that will be used to transfer the file
    acceptedFiles: ".csv",
    dictDefaultMessage: "Drop spreadsheets here to upload",
    maxFilesize: 2, // MB
    accept: function(file, done) {
      if (file.name == "justinbieber.jpg") {
        done("Naha, you don't.");
      }
      else { done(); }
    }
  };
})