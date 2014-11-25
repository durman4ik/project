$(function () {
    var checkedId = $('form.rating_ballot > input:checked').attr('id');
    $('form.rating_ballot > label[for=' + checkedId + ']').prevAll().andSelf().addClass('bright');
});

$(document).ready(function() {
    $('form.rating_ballot > label').hover(
        function() {
            $(this).prevAll().andSelf().addClass('glow');
        },function() {
            $(this).siblings().andSelf().removeClass('glow');
    });

    $('form.rating_ballot > label').click(function() {
        $(this).siblings().removeClass("bright");
        $(this).prevAll().andSelf().addClass("bright");
    });

    $('form.rating_ballot').change(function() {
        $('form.rating_ballot').submit();
    });
});