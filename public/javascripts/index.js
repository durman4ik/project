$(document).ready(function() {
    $('form.rating > label').hover(
        function() {
            $(this).prevAll().andSelf().addClass('glow');
        },function() {
            $(this).siblings().andSelf().removeClass('glow');
    });

    $('form.rating').change(function() {
        $('form.rating').submit();
    });
});