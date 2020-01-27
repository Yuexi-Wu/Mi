(function (window) {
    var svgSprite = '<svg><symbol id="icon-sousuo" viewBox="0 0 1025 1024"><path d="M1017.749333 987.52 720.746667 690.538667c66.24-73.386667 106.965333-170.24 106.965333-276.672 0-228.202667-185.621333-413.866667-413.866667-413.866667C185.664 0 0 185.664 0 413.866667c0 228.224 185.664 413.866667 413.845333 413.866667 106.453333 0 203.306667-40.725333 276.693333-106.965333L987.52 1017.749333C991.701333 1021.909333 997.162667 1024 1002.624 1024c5.482667 0 10.965333-2.090667 15.125333-6.250667C1026.090667 1009.365333 1026.090667 995.882667 1017.749333 987.52zM42.730667 413.866667c0-204.650667 166.485333-371.136 371.114667-371.136 204.650667 0 371.157333 166.485333 371.136 371.136 0 204.629333-166.485333 371.136-371.136 371.136C209.216 785.002667 42.730667 618.496 42.730667 413.866667z"  ></path></symbol>'+
        '<symbol id="icon-right" viewBox="0 0 1024 1024"><path d="M765.7 486.8L314.9 134.7c-5.3-4.1-12.9-0.4-12.9 6.3v77.3c0 4.9 2.3 9.6 6.1 12.6l360 281.1-360 281.1c-3.9 3-6.1 7.7-6.1 12.6V883c0 6.7 7.7 10.4 12.9 6.3l450.8-352.1c16.4-12.8 16.4-37.6 0-50.4z"  ></path></symbol><symbol id="icon-left" viewBox="0 0 1024 1024"><path d="M724 218.3V141c0-6.7-7.7-10.4-12.9-6.3L260.3 486.8c-16.4 12.8-16.4 37.5 0 50.3l450.8 352.1c5.3 4.1 12.9 0.4 12.9-6.3v-77.3c0-4.9-2.3-9.6-6.1-12.6l-360-281 360-281.1c3.8-3 6.1-7.7 6.1-12.6z"  ></path></symbol><symbol id="icon-shangjiantou" viewBox="0 0 1024 1024"><path d="M558.545455 801.303273V332.055273l170.565818 184.785454a34.909091 34.909091 0 1 0 51.293091-47.383272L549.282909 219.066182a34.955636 34.955636 0 0 0-51.293091 0l-231.121454 250.414545a34.862545 34.862545 0 0 0 1.954909 49.338182 34.909091 34.909091 0 0 0 49.338182-2.001454L488.727273 332.055273v469.248a34.909091 34.909091 0 1 0 69.818182 0"  ></path></symbol>' +
    '<symbol id="icon-xiajiantou" viewBox="0 0 1024 1024"><path d="M488.727273 242.757818v469.248l-170.565818-184.762182a34.909091 34.909091 0 1 0-51.293091 47.36l231.121454 250.414546a34.955636 34.955636 0 0 0 51.293091 0l231.121455-250.414546a34.862545 34.862545 0 0 0-1.954909-49.338181 34.909091 34.909091 0 0 0-49.338182 1.978181L558.545455 712.029091V242.734545a34.909091 34.909091 0 1 0-69.818182 0"  ></path></symbol></svg>';
    var script = function () {
        var scripts = document.getElementsByTagName("script");
        return scripts[scripts.length - 1]
    }();
    var shouldInjectCss = script.getAttribute("data-injectcss");
    var ready = function (fn) {
        if (document.addEventListener) {
            if (~["complete", "loaded", "interactive"].indexOf(document.readyState)) {
                setTimeout(fn, 0)
            } else {
                var loadFn = function () {
                    document.removeEventListener("DOMContentLoaded", loadFn, false);
                    fn()
                };
                document.addEventListener("DOMContentLoaded", loadFn, false)
            }
        } else if (document.attachEvent) {
            IEContentLoaded(window, fn)
        }

        function IEContentLoaded(w, fn) {
            var d = w.document, done = false, init = function () {
                if (!done) {
                    done = true;
                    fn()
                }
            };
            var polling = function () {
                try {
                    d.documentElement.doScroll("left")
                } catch (e) {
                    setTimeout(polling, 50);
                    return
                }
                init()
            };
            polling();
            d.onreadystatechange = function () {
                if (d.readyState == "complete") {
                    d.onreadystatechange = null;
                    init()
                }
            }
        }
    };
    var before = function (el, target) {
        target.parentNode.insertBefore(el, target)
    };
    var prepend = function (el, target) {
        if (target.firstChild) {
            before(el, target.firstChild)
        } else {
            target.appendChild(el)
        }
    };

    function appendSvg() {
        var div, svg;
        div = document.createElement("div");
        div.innerHTML = svgSprite;
        svgSprite = null;
        svg = div.getElementsByTagName("svg")[0];
        if (svg) {
            svg.setAttribute("aria-hidden", "true");
            svg.style.position = "absolute";
            svg.style.width = 0;
            svg.style.height = 0;
            svg.style.overflow = "hidden";
            prepend(svg, document.body)
        }
    }

    if (shouldInjectCss && !window.__iconfont__svg__cssinject__) {
        window.__iconfont__svg__cssinject__ = true;
        try {
            document.write("<style>.svgfont {display: inline-block;width: 1em;height: 1em;fill: currentColor;vertical-align: -0.1em;font-size:16px;}</style>")
        } catch (e) {
            console && console.log(e)
        }
    }
    ready(appendSvg)
})(window)