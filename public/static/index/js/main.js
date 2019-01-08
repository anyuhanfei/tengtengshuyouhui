function showToast(o, s) {
    $("body").css('height', '100%');
    $("body").toast({
        content: o,
        duration: s
    })
}

function openMb() {
    var o = $("#common_bg");
    if (o.hasClass("show")) return !1;
    o.addClass("show"), $("body").addClass("noscroll")
}

function closeMb() {
    $("body").removeClass("noscroll"), $(".show").removeClass("show")
}
$(function () {
    $(window).scrollTop();
    $("#goToTop").hide(), $(window).scroll(function () {
        100 < $(this).scrollTop() ? $("#goToTop").fadeIn() : $("#goToTop").fadeOut()
    }), $("#goToTop").click(function () {
        return $("html ,body").animate({
            scrollTop: 0
        }, 300), !1
    });
    $("#nav_btn");
    var o = $("#common_bg"),
        s = $("#common_nav");
    $("#common_bg").click(function () {
        closeMb()
    }), $("[data-togglebtn='mytoggle']").click(function () {
        var o = $("#" + $(this).data("triggermy"));
        o.hasClass("show") ? (o.removeClass("show"), closeMb()) : ($(".show:not(#common_bg)").removeClass("show"), openMb(), o.addClass("show"))
    }), $(".tab-hd ul li").click(function () {
        var o = $(this),
            s = Number;
        o.addClass("active").siblings().removeClass("active"), s = o.index(), o.parents(".tab").children(".tab-bd").find("li").removeClass("active").eq(s).addClass("active")
    }), $(".kind-clas").on("click", ".kind-cell", function () {
        var o = $(this);
        o.hasClass("active") || (o.addClass("active").siblings().removeClass("active"))
    })
});