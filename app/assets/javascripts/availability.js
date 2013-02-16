$(function() {
	$('.datepicker').datepicker({format: 'yyyy-mm-dd'});
	$('#availability_datatable').dataTable({
		"sDom": "<'row'<'span6'l><'span6'f>r>t<'row'<'span6'i><'span6'p>>",
		sPaginationType: "bootstrap",
		aLengthMenu: [[5, 25, 50, -1], [5, 25, 50, "All"]],
		iDisplayLength: 5,
		bProcessing: true,
		bJQueryUI: true
	});
});