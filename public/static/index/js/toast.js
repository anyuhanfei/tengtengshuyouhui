"use strict";
! function (r, s) {
    ! function (t) {
        for (var e = !1, n = r("link"), a = 0; a < n.length; a++)
            if (n.eq(a).attr("href") == t) return e = !0;
        // if (!e) {
        //     var o = document.createElement("link");
        //     o.type = "text/css", o.rel = "stylesheet", o.href = t, document.getElementsByTagName("head")[0].appendChild(o)
        // }
    }("../css/animate.css"), r.fn.toast = function (o) {
        var i = r(this);
        return this.each(function () {
            r(this).css({
                position: "relative"
            });
            var t, e = "",
                n = {
                    position: "absolute",
                    animateIn: "fadeIn",
                    animateOut: "fadeOut",
                    padding: "10px 20px",
                    background: "rgba(7,17,27,0.66)",
                    borderRadius: "6px",
                    duration: 3e3,
                    animateDuration: 500,
                    fontSize: 14,
                    content: "这是一个提示信息",
                    color: "#fff",
                    top: "80%",
                    zIndex: 1000001,
                    isCenter: !0,
                    closePrev: !0
                },
                a = r.extend(n, o || {});
            t = !0 === a.isCenter ? "50%" : a.top, n.isLowerIe9 = function () {
                return !s.FormData
            }, n.createMessage = function () {
                a.closePrev && r(".cpt-toast").remove(), e = r("<span class='animated " + a.animateIn + " cpt-toast'></span>").css({
                    position: a.position,
                    padding: a.padding,
                    background: a.background,
                    "font-size": a.fontSize,
                    "-webkit-border-radius": a.borderRadius,
                    "-moz-border-radius": a.borderRadius,
                    "border-radius": a.borderRadius,
                    color: a.color,
                    top: t,
                    "z-index": a.zIndex,
                    "-webkit-transform": "translate3d(-50%,-50%,0)",
                    "-moz-transform": "translate3d(-50%,-50%,0)",
                    transform: "translate3d(-50%,-50%,0)",
                    "-webkit-animation-duration": a.animateDuration / 1e3 + "s",
                    "-moz-animation-duration": a.animateDuration / 1e3 + "s",
                    "animation-duration": a.animateDuration / 1e3 + "s"
                }).html(a.content).appendTo(i), n.colseMessage()
            }, n.colseMessage = function () {
                var t = n.isLowerIe9();
                t ? setTimeout(function () {
                    e.remove()
                }, a.duration) : setTimeout(function () {
                    e.removeClass(a.animateIn).addClass(a.animateOut).on("webkitAnimationEnd mozAnimationEnd MSAnimationEnd oanimationend animationend", function () {
                        e.remove()
                    })
                }, a.duration)
            }, n.createMessage()
        })
    }
}(jQuery, window);
var showMessage = function (t, e, n, a, o) {
    a = a || "fadeIn", o = o || "fadeOut", t = t || "这是一个提示信息", e = e || "3000", n = n || !1;
    $("body").toast({
        position: "fixed",
        animateIn: a,
        animateOut: o,
        content: t,
        duration: e,
        isCenter: n
    })
};