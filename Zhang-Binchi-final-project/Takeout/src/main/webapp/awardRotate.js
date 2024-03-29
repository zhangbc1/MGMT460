! function($) {
    for (var supportedCSS, styles = document.getElementsByTagName("head")[0].style, toCheck = "transformProperty WebkitTransform OTransform msTransform MozTransform".split(" "), a = 0; a < toCheck.length; a++) void 0 !== styles[toCheck[a]] && (supportedCSS = toCheck[a])
    var IE = eval('"v"=="\x0B"')
    jQuery.fn.extend({
        rotate: function(t) {
            if (0 !== this.length && void 0 !== t) {
                "number" == typeof t && (t = { angle: t })
                for (var i = [], e = 0, s = this.length; s > e; e++) {
                    var h = this.get(e)
                    if (h.Wilq32 && h.Wilq32.PhotoEffect) h.Wilq32.PhotoEffect._handleRotation(t)
                    else {
                        var a = $.extend(!0, {}, t),
                            n = new Wilq32.PhotoEffect(h, a)._rootObj
                        i.push($(n))
                    }
                }
                return i
            }
        },
        getRotateAngle: function() {
            for (var t = [], i = 0, e = this.length; e > i; i++) {
                var s = this.get(i)
                s.Wilq32 && s.Wilq32.PhotoEffect && (t[i] = s.Wilq32.PhotoEffect._angle)
            }
            return t
        },
        stopRotate: function() {
            for (var t = 0, i = this.length; i > t; t++) {
                var e = this.get(t)
                e.Wilq32 && e.Wilq32.PhotoEffect && clearTimeout(e.Wilq32.PhotoEffect._timer)
            }
        }
    }), Wilq32 = window.Wilq32 || {}, Wilq32.PhotoEffect = function() {
        return supportedCSS ? function(t, i) { t.Wilq32 = { PhotoEffect: this }, this._img = this._rootObj = this._eventObj = t, this._handleRotation(i) } : function(t, i) {
            if (this._img = t, this._rootObj = document.createElement("span"), this._rootObj.style.display = "inline-block", this._rootObj.Wilq32 = { PhotoEffect: this }, t.parentNode.insertBefore(this._rootObj, t), t.complete) this._Loader(i)
            else {
                var e = this
                jQuery(this._img).bind("load", function() { e._Loader(i) })
            }
        }
    }(), Wilq32.PhotoEffect.prototype = {
        _setupParameters: function(t) { this._parameters = this._parameters || {}, "number" != typeof this._angle && (this._angle = 0), "number" == typeof t.angle && (this._angle = t.angle), this._parameters.animateTo = "number" == typeof t.animateTo ? t.animateTo : this._angle, this._parameters.step = t.step || this._parameters.step || null, this._parameters.easing = t.easing || this._parameters.easing || function(t, i, e, s, h) { return -s * ((i = i / h - 1) * i * i * i - 1) + e }, this._parameters.duration = t.duration || this._parameters.duration || 1e3, this._parameters.callback = t.callback || this._parameters.callback || function() {}, t.bind && t.bind != this._parameters.bind && this._BindEvents(t.bind) },
        _handleRotation: function(t) { this._setupParameters(t), this._angle == this._parameters.animateTo ? this._rotate(this._angle) : this._animateStart() },
        _BindEvents: function(t) {
            if (t && this._eventObj) {
                if (this._parameters.bind) {
                    var i = this._parameters.bind
                    for (var e in i) i.hasOwnProperty(e) && jQuery(this._eventObj).unbind(e, i[e])
                }
                this._parameters.bind = t
                for (var e in t) t.hasOwnProperty(e) && jQuery(this._eventObj).bind(e, t[e])
            }
        },
        _Loader: function() {
            return IE ? function(t) {
                var i = this._img.width,
                    e = this._img.height
                this._img.parentNode.removeChild(this._img), this._vimage = this.createVMLNode("image"), this._vimage.src = this._img.src, this._vimage.style.height = e + "px", this._vimage.style.width = i + "px", this._vimage.style.position = "absolute", this._vimage.style.top = "0px", this._vimage.style.left = "0px", this._container = this.createVMLNode("group"), this._container.style.width = i, this._container.style.height = e, this._container.style.position = "absolute", this._container.setAttribute("coordsize", i - 1 + "," + (e - 1)), this._container.appendChild(this._vimage), this._rootObj.appendChild(this._container), this._rootObj.style.position = "relative", this._rootObj.style.width = i + "px", this._rootObj.style.height = e + "px", this._rootObj.setAttribute("id", this._img.getAttribute("id")), this._rootObj.className = this._img.className, this._eventObj = this._rootObj, this._handleRotation(t)
            } : function(t) {
                this._rootObj.setAttribute("id", this._img.getAttribute("id")), this._rootObj.className = this._img.className, this._width = this._img.width, this._height = this._img.height, this._widthHalf = this._width / 2, this._heightHalf = this._height / 2
                var i = Math.sqrt(this._height * this._height + this._width * this._width)
                this._widthAdd = i - this._width, this._heightAdd = i - this._height, this._widthAddHalf = this._widthAdd / 2, this._heightAddHalf = this._heightAdd / 2, this._img.parentNode.removeChild(this._img), this._aspectW = (parseInt(this._img.style.width, 10) || this._width) / this._img.width, this._aspectH = (parseInt(this._img.style.height, 10) || this._height) / this._img.height, this._canvas = document.createElement("canvas"), this._canvas.setAttribute("width", this._width), this._canvas.style.position = "relative", this._canvas.style.left = -this._widthAddHalf + "px", this._canvas.style.top = -this._heightAddHalf + "px", this._canvas.Wilq32 = this._rootObj.Wilq32, this._rootObj.appendChild(this._canvas), this._rootObj.style.width = this._width + "px", this._rootObj.style.height = this._height + "px", this._eventObj = this._canvas, this._cnv = this._canvas.getContext("2d"), this._handleRotation(t)
            }
        }(),
        _animateStart: function() { this._timer && clearTimeout(this._timer), this._animateStartTime = +new Date, this._animateStartAngle = this._angle, this._animate() },
        _animate: function() {
            var t = +new Date,
                i = t - this._animateStartTime > this._parameters.duration
            if (i && !this._parameters.animatedGif) clearTimeout(this._timer)
            else {
                if (this._canvas || this._vimage || this._img) {
                    var e = this._parameters.easing(0, t - this._animateStartTime, this._animateStartAngle, this._parameters.animateTo - this._animateStartAngle, this._parameters.duration)
                    this._rotate(~~(10 * e) / 10)
                }
                this._parameters.step && this._parameters.step(this._angle)
                var s = this
                this._timer = setTimeout(function() { s._animate.call(s) }, 10)
            }
            this._parameters.callback && i && (this._angle = this._parameters.animateTo, this._rotate(this._angle), this._parameters.callback.call(this._rootObj))
        },
        _rotate: function() {
            var t = Math.PI / 180
            return IE ? function(t) { this._angle = t, this._container.style.rotation = t % 360 + "deg" } : supportedCSS ? function(t) { this._angle = t, this._img.style[supportedCSS] = "rotate(" + t % 360 + "deg)" } : function(i) { this._angle = i, i = i % 360 * t, this._canvas.width = this._width + this._widthAdd, this._canvas.height = this._height + this._heightAdd, this._cnv.translate(this._widthAddHalf, this._heightAddHalf), this._cnv.translate(this._widthHalf, this._heightHalf), this._cnv.rotate(i), this._cnv.translate(-this._widthHalf, -this._heightHalf), this._cnv.scale(this._aspectW, this._aspectH), this._cnv.drawImage(this._img, 0, 0) }
        }()
    }, IE && (Wilq32.PhotoEffect.prototype.createVMLNode = function() {
        document.createStyleSheet().addRule(".rvml", "behavior:url(#default#VML)")
        try {
            return !document.namespaces.rvml && document.namespaces.add("rvml", "urn:schemas-microsoft-com:vml"),
                function(t) { return document.createElement("<rvml:" + t + ' class="rvml">') }
        } catch (t) { return function(t) { return document.createElement("<" + t + ' xmlns="urn:schemas-microsoft.com:vml" class="rvml">') } }
    }())
}(jQuery)