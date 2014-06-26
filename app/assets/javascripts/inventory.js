$(function(){
  Dropzone.options.myDropzone = {
    paramName: "file", // The name that will be used to transfer the file
    acceptedFiles: ".csv",
    dictDefaultMessage: "Drop spreadsheets here to upload",
    maxFilesize: 2, // MB
    accept: function(file,done){
      done();
    },
    success: function(file,resp) {
      var alert_type = 'success';
      
      if(resp.text == 'No items to clearance'){
       alert_type = 'danger';
      }
      
      var html = '<div data-no-turbo-link class="alert alert-'+alert_type+'"><button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>'+resp.text+'</div>';
      $(".container").append(html);
      var elem = $(".dz-preview").last();
      elem.find(".dz-success-mark").css("opacity","1");
      elem.find('.dz-upload').remove();
    }

  };
});