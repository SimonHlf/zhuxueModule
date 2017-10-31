$(document).ready(function () {
  $('#imgID').imgAreaSelect({ 
	  keys:true,
	  aspectRatio: '1:1',
	  handles: true ,
	  onSelectEnd:preView
	});
});
function preView(img,selection){
	$('#x1').val(selection.x1);
	$('#y1').val(selection.y1);
	$('#w').val(selection.width);
	$('#h').val(selection.height);
}