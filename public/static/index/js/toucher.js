! function (t, e, n) {
    var a = function (t, e) {
        var u = e.createElement("div").classList ? function (t, e) {
                return t && t.classList && t.classList.contains(e)
            } : function (t, e) {
                return !(!t || "string" != typeof t.className) && !!t.className.match(new RegExp("(\\s|^)" + e + "(\\s|$)"))
            },
            g = "ontouchend" in e;

        function m(t, e) {
            if (this._events = this._events || {}, this._events[t])
                for (var n = this._events[t], a = e.target;;) {
                    if (0 == n.length) return;
                    if (a == this.dom || !a) {
                        for (var i = 0, s = n.length; i < s; i++) {
                            var o = n[i].className,
                                r = n[i].fn;
                            null == o && c(t, r, a, e)
                        }
                        return
                    }
                    var l = n;
                    n = [];
                    for (var i = 0, s = l.length; i < s; i++) {
                        var o = l[i].className,
                            r = l[i].fn;
                        if (u(a, o)) {
                            if (0 == c(t, r, a, e)) return
                        } else n.push(l[i])
                    }
                    a = a.parentNode
                }
        }

        function c(t, e, n, a) {
            var i = a.plugTouches || a.touches,
                s = i.length ? i[0] : {},
                o = {
                    type: t,
                    target: a.target,
                    pageX: s.pageX,
                    pageY: s.pageY,
                    clientX: s.clientX || 0,
                    clientY: s.clientY || 0
                };
            t.match(/^swipe/) && a.plugStartPosition && (o.startX = a.plugStartPosition.pageX, o.startY = a.plugStartPosition.pageY, o.moveX = o.pageX - o.startX, o.moveY = o.pageY - o.startY);
            var r = e.call(n, o);
            return 0 == r && (a.preventDefault(), a.stopPropagation()), r
        }

        function n(t) {
            var o, r, l, u, n, e, c = this,
                a = 0,
                p = !1,
                h = null;

            function v(t) {
                p = !1, clearTimeout(e), clearTimeout(n)
            }

            function f() {
                v(), m.call(c, "singleTap", h)
            }

            function i(t) {
                o = (h = t).touches[0].pageX, r = t.touches[0].pageY, p = !(u = l = 0), new Date, m.call(c, "swipeStart", t), clearTimeout(e), e = setTimeout(function () {
                    v(t), m.call(c, "longTap", t)
                }, 500)
            }

            function s(t) {
                if (t.plugStartPosition = h.plugStartPosition, t.plugTouches = h.touches, m.call(c, "swipeEnd", t), p) {
                    var e = new Date;
                    c._events.doubleTap && 0 != c._events.doubleTap.length ? 200 < e - a ? n = setTimeout(f, 190) : (clearTimeout(n), v(t), m.call(c, "doubleTap", h)) : f(), a = e
                }
            }

            function d(t) {
                if ((h = t).plugStartPosition = {
                        pageX: o,
                        pageY: r
                    }, m.call(c, "swipe", t), p) {
                    if (l = t.touches[0].pageX, u = t.touches[0].pageY, 2 < Math.abs(o - l) || 2 < Math.abs(r - u)) {
                        var e = (n = o, a = l, i = r, s = u, Math.abs(n - a) >= Math.abs(i - s) ? 0 < n - a ? "Left" : "Right" : 0 < i - s ? "Up" : "Down");
                        m.call(c, "swipe" + e, t)
                    } else f();
                    var n, a, i, s;
                    v(t)
                }
            }
            g ? (t.addEventListener("touchstart", i), t.addEventListener("touchend", s), t.addEventListener("touchmove", d), t.addEventListener("touchcancel", v)) : (t.addEventListener("MSPointerDown", i), t.addEventListener("pointerdown", i), t.addEventListener("MSPointerUp", s), t.addEventListener("pointerup", s), t.addEventListener("MSPointerMove", d), t.addEventListener("pointermove", d), t.addEventListener("MSPointerCancel", v), t.addEventListener("pointercancel", v))
        }

        function a(t, e) {
            this.dom = t, this._events = {}, n.call(this, this.dom)
        }
        return a.prototype.on = function (t, e, n) {
                var a, i;
                if ("function" == typeof (i = "string" == typeof e ? (a = e.replace(/^\./, ""), n) : (a = null, e)) && t && t.length)
                    for (var s = t.split(/\s+/), o = 0, r = s.length; o < r; o++) {
                        var l = s[o];
                        this._events[l] || (this._events[l] = []), this._events[l].push({
                            className: a,
                            fn: i
                        })
                    }
                return this
            },
            function (t) {
                return new a(t)
            }
    }(0, document);
    t.util = t.util || {}, t.util.toucher = t.util.toucher || a, t.define && define(function (t, e, n) {
        return a
    })
}(this);