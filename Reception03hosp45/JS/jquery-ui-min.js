﻿/*!
* jQuery UI 1.8.13
*
* Copyright 2011, AUTHORS.txt (http://jqueryui.com/about)
* Dual licensed under the MIT or GPL Version 2 licenses.
* http://jquery.org/license
*
* http://docs.jquery.com/UI
*/
(function(a, d) {
    function c(g, e) { var i = g.nodeName.toLowerCase(); if ("area" === i) { e = g.parentNode; i = e.name; if (!g.href || !i || e.nodeName.toLowerCase() !== "map") return false; g = a("img[usemap=#" + i + "]")[0]; return !!g && f(g) } return (/input|select|textarea|button|object/.test(i) ? !g.disabled : "a" == i ? g.href || e : e) && f(g) } function f(g) { return !a(g).parents().andSelf().filter(function() { return a.curCSS(this, "visibility") === "hidden" || a.expr.filters.hidden(this) }).length } a.ui = a.ui || {}; if (!a.ui.version) {
        a.extend(a.ui, { version: "1.8.13",
            keyCode: { ALT: 18, BACKSPACE: 8, CAPS_LOCK: 20, COMMA: 188, COMMAND: 91, COMMAND_LEFT: 91, COMMAND_RIGHT: 93, CONTROL: 17, DELETE: 46, DOWN: 40, END: 35, ENTER: 13, ESCAPE: 27, HOME: 36, INSERT: 45, LEFT: 37, MENU: 93, NUMPAD_ADD: 107, NUMPAD_DECIMAL: 110, NUMPAD_DIVIDE: 111, NUMPAD_ENTER: 108, NUMPAD_MULTIPLY: 106, NUMPAD_SUBTRACT: 109, PAGE_DOWN: 34, PAGE_UP: 33, PERIOD: 190, RIGHT: 39, SHIFT: 16, SPACE: 32, TAB: 9, UP: 38, WINDOWS: 91}
        }); a.fn.extend({ _focus: a.fn.focus, focus: function(g, e) {
            return typeof g === "number" ? this.each(function() {
                var i = this; setTimeout(function() {
                    a(i).focus();
                    e && e.call(i)
                }, g)
            }) : this._focus.apply(this, arguments)
        }, scrollParent: function() {
            var g; g = a.browser.msie && /(static|relative)/.test(this.css("position")) || /absolute/.test(this.css("position")) ? this.parents().filter(function() { return /(relative|absolute|fixed)/.test(a.curCSS(this, "position", 1)) && /(auto|scroll)/.test(a.curCSS(this, "overflow", 1) + a.curCSS(this, "overflow-y", 1) + a.curCSS(this, "overflow-x", 1)) }).eq(0) : this.parents().filter(function() {
                return /(auto|scroll)/.test(a.curCSS(this, "overflow", 1) + a.curCSS(this,
"overflow-y", 1) + a.curCSS(this, "overflow-x", 1))
            }).eq(0); return /fixed/.test(this.css("position")) || !g.length ? a(document) : g
        }, zIndex: function(g) { if (g !== d) return this.css("zIndex", g); if (this.length) { g = a(this[0]); for (var e; g.length && g[0] !== document; ) { e = g.css("position"); if (e === "absolute" || e === "relative" || e === "fixed") { e = parseInt(g.css("zIndex"), 10); if (!isNaN(e) && e !== 0) return e } g = g.parent() } } return 0 }, disableSelection: function() {
            return this.bind((a.support.selectstart ? "selectstart" : "mousedown") + ".ui-disableSelection",
function(g) { g.preventDefault() })
        }, enableSelection: function() { return this.unbind(".ui-disableSelection") } 
        }); a.each(["Width", "Height"], function(g, e) {
            function i(l, o, n, k) { a.each(b, function() { o -= parseFloat(a.curCSS(l, "padding" + this, true)) || 0; if (n) o -= parseFloat(a.curCSS(l, "border" + this + "Width", true)) || 0; if (k) o -= parseFloat(a.curCSS(l, "margin" + this, true)) || 0 }); return o } var b = e === "Width" ? ["Left", "Right"] : ["Top", "Bottom"], h = e.toLowerCase(), j = { innerWidth: a.fn.innerWidth, innerHeight: a.fn.innerHeight, outerWidth: a.fn.outerWidth,
                outerHeight: a.fn.outerHeight
            }; a.fn["inner" + e] = function(l) { if (l === d) return j["inner" + e].call(this); return this.each(function() { a(this).css(h, i(this, l) + "px") }) }; a.fn["outer" + e] = function(l, o) { if (typeof l !== "number") return j["outer" + e].call(this, l); return this.each(function() { a(this).css(h, i(this, l, true, o) + "px") }) } 
        }); a.extend(a.expr[":"], { data: function(g, e, i) { return !!a.data(g, i[3]) }, focusable: function(g) { return c(g, !isNaN(a.attr(g, "tabindex"))) }, tabbable: function(g) {
            var e = a.attr(g, "tabindex"), i = isNaN(e);
            return (i || e >= 0) && c(g, !i)
        } 
        }); a(function() { var g = document.body, e = g.appendChild(e = document.createElement("div")); a.extend(e.style, { minHeight: "100px", height: "auto", padding: 0, borderWidth: 0 }); a.support.minHeight = e.offsetHeight === 100; a.support.selectstart = "onselectstart" in e; g.removeChild(e).style.display = "none" }); a.extend(a.ui, { plugin: { add: function(g, e, i) { g = a.ui[g].prototype; for (var b in i) { g.plugins[b] = g.plugins[b] || []; g.plugins[b].push([e, i[b]]) } }, call: function(g, e, i) {
            if ((e = g.plugins[e]) && g.element[0].parentNode) for (var b =
0; b < e.length; b++) g.options[e[b][0]] && e[b][1].apply(g.element, i)
        } 
        }, contains: function(g, e) { return document.compareDocumentPosition ? g.compareDocumentPosition(e) & 16 : g !== e && g.contains(e) }, hasScroll: function(g, e) { if (a(g).css("overflow") === "hidden") return false; e = e && e === "left" ? "scrollLeft" : "scrollTop"; var i = false; if (g[e] > 0) return true; g[e] = 1; i = g[e] > 0; g[e] = 0; return i }, isOverAxis: function(g, e, i) { return g > e && g < e + i }, isOver: function(g, e, i, b, h, j) { return a.ui.isOverAxis(g, i, h) && a.ui.isOverAxis(e, b, j) } 
        })
    } 
})(jQuery);
(function(a, d) {
    if (a.cleanData) { var c = a.cleanData; a.cleanData = function(g) { for (var e = 0, i; (i = g[e]) != null; e++) a(i).triggerHandler("remove"); c(g) } } else { var f = a.fn.remove; a.fn.remove = function(g, e) { return this.each(function() { if (!e) if (!g || a.filter(g, [this]).length) a("*", this).add([this]).each(function() { a(this).triggerHandler("remove") }); return f.call(a(this), g, e) }) } } a.widget = function(g, e, i) {
        var b = g.split(".")[0], h; g = g.split(".")[1]; h = b + "-" + g; if (!i) { i = e; e = a.Widget } a.expr[":"][h] = function(j) {
            return !!a.data(j,
g)
        }; a[b] = a[b] || {}; a[b][g] = function(j, l) { arguments.length && this._createWidget(j, l) }; e = new e; e.options = a.extend(true, {}, e.options); a[b][g].prototype = a.extend(true, e, { namespace: b, widgetName: g, widgetEventPrefix: a[b][g].prototype.widgetEventPrefix || g, widgetBaseClass: h }, i); a.widget.bridge(g, a[b][g])
    }; a.widget.bridge = function(g, e) {
        a.fn[g] = function(i) {
            var b = typeof i === "string", h = Array.prototype.slice.call(arguments, 1), j = this; i = !b && h.length ? a.extend.apply(null, [true, i].concat(h)) : i; if (b && i.charAt(0) === "_") return j;
            b ? this.each(function() { var l = a.data(this, g), o = l && a.isFunction(l[i]) ? l[i].apply(l, h) : l; if (o !== l && o !== d) { j = o; return false } }) : this.each(function() { var l = a.data(this, g); l ? l.option(i || {})._init() : a.data(this, g, new e(i, this)) }); return j
        } 
    }; a.Widget = function(g, e) { arguments.length && this._createWidget(g, e) }; a.Widget.prototype = { widgetName: "widget", widgetEventPrefix: "", options: { disabled: false }, _createWidget: function(g, e) {
        a.data(e, this.widgetName, this); this.element = a(e); this.options = a.extend(true, {}, this.options,
this._getCreateOptions(), g); var i = this; this.element.bind("remove." + this.widgetName, function() { i.destroy() }); this._create(); this._trigger("create"); this._init()
    }, _getCreateOptions: function() { return a.metadata && a.metadata.get(this.element[0])[this.widgetName] }, _create: function() { }, _init: function() { }, destroy: function() { this.element.unbind("." + this.widgetName).removeData(this.widgetName); this.widget().unbind("." + this.widgetName).removeAttr("aria-disabled").removeClass(this.widgetBaseClass + "-disabled ui-state-disabled") },
        widget: function() { return this.element }, option: function(g, e) { var i = g; if (arguments.length === 0) return a.extend({}, this.options); if (typeof g === "string") { if (e === d) return this.options[g]; i = {}; i[g] = e } this._setOptions(i); return this }, _setOptions: function(g) { var e = this; a.each(g, function(i, b) { e._setOption(i, b) }); return this }, _setOption: function(g, e) { this.options[g] = e; if (g === "disabled") this.widget()[e ? "addClass" : "removeClass"](this.widgetBaseClass + "-disabled ui-state-disabled").attr("aria-disabled", e); return this },
        enable: function() { return this._setOption("disabled", false) }, disable: function() { return this._setOption("disabled", true) }, _trigger: function(g, e, i) { var b = this.options[g]; e = a.Event(e); e.type = (g === this.widgetEventPrefix ? g : this.widgetEventPrefix + g).toLowerCase(); i = i || {}; if (e.originalEvent) { g = a.event.props.length; for (var h; g; ) { h = a.event.props[--g]; e[h] = e.originalEvent[h] } } this.element.trigger(e, i); return !(a.isFunction(b) && b.call(this.element[0], e, i) === false || e.isDefaultPrevented()) } }
    })(jQuery);
    (function(a) {
        var d = false; a(document).mousedown(function() { d = false }); a.widget("ui.mouse", { options: { cancel: ":input,option", distance: 1, delay: 0 }, _mouseInit: function() { var c = this; this.element.bind("mousedown." + this.widgetName, function(f) { return c._mouseDown(f) }).bind("click." + this.widgetName, function(f) { if (true === a.data(f.target, c.widgetName + ".preventClickEvent")) { a.removeData(f.target, c.widgetName + ".preventClickEvent"); f.stopImmediatePropagation(); return false } }); this.started = false }, _mouseDestroy: function() {
            this.element.unbind("." +
this.widgetName)
        }, _mouseDown: function(c) {
            if (!d) {
                this._mouseStarted && this._mouseUp(c); this._mouseDownEvent = c; var f = this, g = c.which == 1, e = typeof this.options.cancel == "string" ? a(c.target).parents().add(c.target).filter(this.options.cancel).length : false; if (!g || e || !this._mouseCapture(c)) return true; this.mouseDelayMet = !this.options.delay; if (!this.mouseDelayMet) this._mouseDelayTimer = setTimeout(function() { f.mouseDelayMet = true }, this.options.delay); if (this._mouseDistanceMet(c) && this._mouseDelayMet(c)) {
                    this._mouseStarted =
this._mouseStart(c) !== false; if (!this._mouseStarted) { c.preventDefault(); return true } 
                } true === a.data(c.target, this.widgetName + ".preventClickEvent") && a.removeData(c.target, this.widgetName + ".preventClickEvent"); this._mouseMoveDelegate = function(i) { return f._mouseMove(i) }; this._mouseUpDelegate = function(i) { return f._mouseUp(i) }; a(document).bind("mousemove." + this.widgetName, this._mouseMoveDelegate).bind("mouseup." + this.widgetName, this._mouseUpDelegate); c.preventDefault(); return d = true
            } 
        }, _mouseMove: function(c) {
            if (a.browser.msie &&
!(document.documentMode >= 9) && !c.button) return this._mouseUp(c); if (this._mouseStarted) { this._mouseDrag(c); return c.preventDefault() } if (this._mouseDistanceMet(c) && this._mouseDelayMet(c)) (this._mouseStarted = this._mouseStart(this._mouseDownEvent, c) !== false) ? this._mouseDrag(c) : this._mouseUp(c); return !this._mouseStarted
        }, _mouseUp: function(c) {
            a(document).unbind("mousemove." + this.widgetName, this._mouseMoveDelegate).unbind("mouseup." + this.widgetName, this._mouseUpDelegate); if (this._mouseStarted) {
                this._mouseStarted =
false; c.target == this._mouseDownEvent.target && a.data(c.target, this.widgetName + ".preventClickEvent", true); this._mouseStop(c)
            } return false
        }, _mouseDistanceMet: function(c) { return Math.max(Math.abs(this._mouseDownEvent.pageX - c.pageX), Math.abs(this._mouseDownEvent.pageY - c.pageY)) >= this.options.distance }, _mouseDelayMet: function() { return this.mouseDelayMet }, _mouseStart: function() { }, _mouseDrag: function() { }, _mouseStop: function() { }, _mouseCapture: function() { return true } 
        })
    })(jQuery);
    (function(a) {
        a.widget("ui.draggable", a.ui.mouse, { widgetEventPrefix: "drag", options: { addClasses: true, appendTo: "parent", axis: false, connectToSortable: false, containment: false, cursor: "auto", cursorAt: false, grid: false, handle: false, helper: "original", iframeFix: false, opacity: false, refreshPositions: false, revert: false, revertDuration: 500, scope: "default", scroll: true, scrollSensitivity: 20, scrollSpeed: 20, snap: false, snapMode: "both", snapTolerance: 20, stack: false, zIndex: false }, _create: function() {
            if (this.options.helper ==
"original" && !/^(?:r|a|f)/.test(this.element.css("position"))) this.element[0].style.position = "relative"; this.options.addClasses && this.element.addClass("ui-draggable"); this.options.disabled && this.element.addClass("ui-draggable-disabled"); this._mouseInit()
        }, destroy: function() { if (this.element.data("draggable")) { this.element.removeData("draggable").unbind(".draggable").removeClass("ui-draggable ui-draggable-dragging ui-draggable-disabled"); this._mouseDestroy(); return this } }, _mouseCapture: function(d) {
            var c =
this.options; if (this.helper || c.disabled || a(d.target).is(".ui-resizable-handle")) return false; this.handle = this._getHandle(d); if (!this.handle) return false; a(c.iframeFix === true ? "iframe" : c.iframeFix).each(function() { a('<div class="ui-draggable-iframeFix" style="background: #fff;"></div>').css({ width: this.offsetWidth + "px", height: this.offsetHeight + "px", position: "absolute", opacity: "0.001", zIndex: 1E3 }).css(a(this).offset()).appendTo("body") }); return true
        }, _mouseStart: function(d) {
            var c = this.options; this.helper =
this._createHelper(d); this._cacheHelperProportions(); if (a.ui.ddmanager) a.ui.ddmanager.current = this; this._cacheMargins(); this.cssPosition = this.helper.css("position"); this.scrollParent = this.helper.scrollParent(); this.offset = this.positionAbs = this.element.offset(); this.offset = { top: this.offset.top - this.margins.top, left: this.offset.left - this.margins.left }; a.extend(this.offset, { click: { left: d.pageX - this.offset.left, top: d.pageY - this.offset.top }, parent: this._getParentOffset(), relative: this._getRelativeOffset() });
            this.originalPosition = this.position = this._generatePosition(d); this.originalPageX = d.pageX; this.originalPageY = d.pageY; c.cursorAt && this._adjustOffsetFromHelper(c.cursorAt); c.containment && this._setContainment(); if (this._trigger("start", d) === false) { this._clear(); return false } this._cacheHelperProportions(); a.ui.ddmanager && !c.dropBehaviour && a.ui.ddmanager.prepareOffsets(this, d); this.helper.addClass("ui-draggable-dragging"); this._mouseDrag(d, true); return true
        }, _mouseDrag: function(d, c) {
            this.position = this._generatePosition(d);
            this.positionAbs = this._convertPositionTo("absolute"); if (!c) { c = this._uiHash(); if (this._trigger("drag", d, c) === false) { this._mouseUp({}); return false } this.position = c.position } if (!this.options.axis || this.options.axis != "y") this.helper[0].style.left = this.position.left + "px"; if (!this.options.axis || this.options.axis != "x") this.helper[0].style.top = this.position.top + "px"; a.ui.ddmanager && a.ui.ddmanager.drag(this, d); return false
        }, _mouseStop: function(d) {
            var c = false; if (a.ui.ddmanager && !this.options.dropBehaviour) c =
a.ui.ddmanager.drop(this, d); if (this.dropped) { c = this.dropped; this.dropped = false } if ((!this.element[0] || !this.element[0].parentNode) && this.options.helper == "original") return false; if (this.options.revert == "invalid" && !c || this.options.revert == "valid" && c || this.options.revert === true || a.isFunction(this.options.revert) && this.options.revert.call(this.element, c)) { var f = this; a(this.helper).animate(this.originalPosition, parseInt(this.options.revertDuration, 10), function() { f._trigger("stop", d) !== false && f._clear() }) } else this._trigger("stop",
d) !== false && this._clear(); return false
        }, _mouseUp: function(d) { this.options.iframeFix === true && a("div.ui-draggable-iframeFix").each(function() { this.parentNode.removeChild(this) }); return a.ui.mouse.prototype._mouseUp.call(this, d) }, cancel: function() { this.helper.is(".ui-draggable-dragging") ? this._mouseUp({}) : this._clear(); return this }, _getHandle: function(d) {
            var c = !this.options.handle || !a(this.options.handle, this.element).length ? true : false; a(this.options.handle, this.element).find("*").andSelf().each(function() {
                if (this ==
d.target) c = true
            }); return c
        }, _createHelper: function(d) { var c = this.options; d = a.isFunction(c.helper) ? a(c.helper.apply(this.element[0], [d])) : c.helper == "clone" ? this.element.clone().removeAttr("id") : this.element; d.parents("body").length || d.appendTo(c.appendTo == "parent" ? this.element[0].parentNode : c.appendTo); d[0] != this.element[0] && !/(fixed|absolute)/.test(d.css("position")) && d.css("position", "absolute"); return d }, _adjustOffsetFromHelper: function(d) {
            if (typeof d == "string") d = d.split(" "); if (a.isArray(d)) d =
{ left: +d[0], top: +d[1] || 0 }; if ("left" in d) this.offset.click.left = d.left + this.margins.left; if ("right" in d) this.offset.click.left = this.helperProportions.width - d.right + this.margins.left; if ("top" in d) this.offset.click.top = d.top + this.margins.top; if ("bottom" in d) this.offset.click.top = this.helperProportions.height - d.bottom + this.margins.top
        }, _getParentOffset: function() {
            this.offsetParent = this.helper.offsetParent(); var d = this.offsetParent.offset(); if (this.cssPosition == "absolute" && this.scrollParent[0] != document &&
a.ui.contains(this.scrollParent[0], this.offsetParent[0])) { d.left += this.scrollParent.scrollLeft(); d.top += this.scrollParent.scrollTop() } if (this.offsetParent[0] == document.body || this.offsetParent[0].tagName && this.offsetParent[0].tagName.toLowerCase() == "html" && a.browser.msie) d = { top: 0, left: 0 }; return { top: d.top + (parseInt(this.offsetParent.css("borderTopWidth"), 10) || 0), left: d.left + (parseInt(this.offsetParent.css("borderLeftWidth"), 10) || 0)}
        }, _getRelativeOffset: function() {
            if (this.cssPosition == "relative") {
                var d =
this.element.position(); return { top: d.top - (parseInt(this.helper.css("top"), 10) || 0) + this.scrollParent.scrollTop(), left: d.left - (parseInt(this.helper.css("left"), 10) || 0) + this.scrollParent.scrollLeft()}
            } else return { top: 0, left: 0}
        }, _cacheMargins: function() { this.margins = { left: parseInt(this.element.css("marginLeft"), 10) || 0, top: parseInt(this.element.css("marginTop"), 10) || 0, right: parseInt(this.element.css("marginRight"), 10) || 0, bottom: parseInt(this.element.css("marginBottom"), 10) || 0} }, _cacheHelperProportions: function() {
            this.helperProportions =
{ width: this.helper.outerWidth(), height: this.helper.outerHeight()}
        }, _setContainment: function() {
            var d = this.options; if (d.containment == "parent") d.containment = this.helper[0].parentNode; if (d.containment == "document" || d.containment == "window") this.containment = [(d.containment == "document" ? 0 : a(window).scrollLeft()) - this.offset.relative.left - this.offset.parent.left, (d.containment == "document" ? 0 : a(window).scrollTop()) - this.offset.relative.top - this.offset.parent.top, (d.containment == "document" ? 0 : a(window).scrollLeft()) +
a(d.containment == "document" ? document : window).width() - this.helperProportions.width - this.margins.left, (d.containment == "document" ? 0 : a(window).scrollTop()) + (a(d.containment == "document" ? document : window).height() || document.body.parentNode.scrollHeight) - this.helperProportions.height - this.margins.top]; if (!/^(document|window|parent)$/.test(d.containment) && d.containment.constructor != Array) {
                d = a(d.containment); var c = d[0]; if (c) {
                    d.offset(); var f = a(c).css("overflow") != "hidden"; this.containment = [(parseInt(a(c).css("borderLeftWidth"),
10) || 0) + (parseInt(a(c).css("paddingLeft"), 10) || 0), (parseInt(a(c).css("borderTopWidth"), 10) || 0) + (parseInt(a(c).css("paddingTop"), 10) || 0), (f ? Math.max(c.scrollWidth, c.offsetWidth) : c.offsetWidth) - (parseInt(a(c).css("borderLeftWidth"), 10) || 0) - (parseInt(a(c).css("paddingRight"), 10) || 0) - this.helperProportions.width - this.margins.left - this.margins.right, (f ? Math.max(c.scrollHeight, c.offsetHeight) : c.offsetHeight) - (parseInt(a(c).css("borderTopWidth"), 10) || 0) - (parseInt(a(c).css("paddingBottom"), 10) || 0) - this.helperProportions.height -
this.margins.top - this.margins.bottom]; this.relative_container = d
                } 
            } else if (d.containment.constructor == Array) this.containment = d.containment
        }, _convertPositionTo: function(d, c) {
            if (!c) c = this.position; d = d == "absolute" ? 1 : -1; var f = this.cssPosition == "absolute" && !(this.scrollParent[0] != document && a.ui.contains(this.scrollParent[0], this.offsetParent[0])) ? this.offsetParent : this.scrollParent, g = /(html|body)/i.test(f[0].tagName); return { top: c.top + this.offset.relative.top * d + this.offset.parent.top * d - (a.browser.safari &&
a.browser.version < 526 && this.cssPosition == "fixed" ? 0 : (this.cssPosition == "fixed" ? -this.scrollParent.scrollTop() : g ? 0 : f.scrollTop()) * d), left: c.left + this.offset.relative.left * d + this.offset.parent.left * d - (a.browser.safari && a.browser.version < 526 && this.cssPosition == "fixed" ? 0 : (this.cssPosition == "fixed" ? -this.scrollParent.scrollLeft() : g ? 0 : f.scrollLeft()) * d)}
            }, _generatePosition: function(d) {
                var c = this.options, f = this.cssPosition == "absolute" && !(this.scrollParent[0] != document && a.ui.contains(this.scrollParent[0],
this.offsetParent[0])) ? this.offsetParent : this.scrollParent, g = /(html|body)/i.test(f[0].tagName), e = d.pageX, i = d.pageY; if (this.originalPosition) {
                    var b; if (this.containment) {
                        if (this.relative_container) { b = this.relative_container.offset(); b = [this.containment[0] + b.left, this.containment[1] + b.top, this.containment[2] + b.left, this.containment[3] + b.top] } else b = this.containment; if (d.pageX - this.offset.click.left < b[0]) e = b[0] + this.offset.click.left; if (d.pageY - this.offset.click.top < b[1]) i = b[1] + this.offset.click.top;
                        if (d.pageX - this.offset.click.left > b[2]) e = b[2] + this.offset.click.left; if (d.pageY - this.offset.click.top > b[3]) i = b[3] + this.offset.click.top
                    } if (c.grid) {
                        i = this.originalPageY + Math.round((i - this.originalPageY) / c.grid[1]) * c.grid[1]; i = b ? !(i - this.offset.click.top < b[1] || i - this.offset.click.top > b[3]) ? i : !(i - this.offset.click.top < b[1]) ? i - c.grid[1] : i + c.grid[1] : i; e = this.originalPageX + Math.round((e - this.originalPageX) / c.grid[0]) * c.grid[0]; e = b ? !(e - this.offset.click.left < b[0] || e - this.offset.click.left > b[2]) ? e : !(e - this.offset.click.left <
b[0]) ? e - c.grid[0] : e + c.grid[0] : e
                    } 
                } return { top: i - this.offset.click.top - this.offset.relative.top - this.offset.parent.top + (a.browser.safari && a.browser.version < 526 && this.cssPosition == "fixed" ? 0 : this.cssPosition == "fixed" ? -this.scrollParent.scrollTop() : g ? 0 : f.scrollTop()), left: e - this.offset.click.left - this.offset.relative.left - this.offset.parent.left + (a.browser.safari && a.browser.version < 526 && this.cssPosition == "fixed" ? 0 : this.cssPosition == "fixed" ? -this.scrollParent.scrollLeft() : g ? 0 : f.scrollLeft())}
            }, _clear: function() {
                this.helper.removeClass("ui-draggable-dragging");
                this.helper[0] != this.element[0] && !this.cancelHelperRemoval && this.helper.remove(); this.helper = null; this.cancelHelperRemoval = false
            }, _trigger: function(d, c, f) { f = f || this._uiHash(); a.ui.plugin.call(this, d, [c, f]); if (d == "drag") this.positionAbs = this._convertPositionTo("absolute"); return a.Widget.prototype._trigger.call(this, d, c, f) }, plugins: {}, _uiHash: function() { return { helper: this.helper, position: this.position, originalPosition: this.originalPosition, offset: this.positionAbs} } 
        }); a.extend(a.ui.draggable, { version: "1.8.13" });
        a.ui.plugin.add("draggable", "connectToSortable", { start: function(d, c) { var f = a(this).data("draggable"), g = f.options, e = a.extend({}, c, { item: f.element }); f.sortables = []; a(g.connectToSortable).each(function() { var i = a.data(this, "sortable"); if (i && !i.options.disabled) { f.sortables.push({ instance: i, shouldRevert: i.options.revert }); i.refreshPositions(); i._trigger("activate", d, e) } }) }, stop: function(d, c) {
            var f = a(this).data("draggable"), g = a.extend({}, c, { item: f.element }); a.each(f.sortables, function() {
                if (this.instance.isOver) {
                    this.instance.isOver =
0; f.cancelHelperRemoval = true; this.instance.cancelHelperRemoval = false; if (this.shouldRevert) this.instance.options.revert = true; this.instance._mouseStop(d); this.instance.options.helper = this.instance.options._helper; f.options.helper == "original" && this.instance.currentItem.css({ top: "auto", left: "auto" })
                } else { this.instance.cancelHelperRemoval = false; this.instance._trigger("deactivate", d, g) } 
            })
        }, drag: function(d, c) {
            var f = a(this).data("draggable"), g = this; a.each(f.sortables, function() {
                this.instance.positionAbs =
f.positionAbs; this.instance.helperProportions = f.helperProportions; this.instance.offset.click = f.offset.click; if (this.instance._intersectsWith(this.instance.containerCache)) {
                    if (!this.instance.isOver) {
                        this.instance.isOver = 1; this.instance.currentItem = a(g).clone().removeAttr("id").appendTo(this.instance.element).data("sortable-item", true); this.instance.options._helper = this.instance.options.helper; this.instance.options.helper = function() { return c.helper[0] }; d.target = this.instance.currentItem[0]; this.instance._mouseCapture(d,
true); this.instance._mouseStart(d, true, true); this.instance.offset.click.top = f.offset.click.top; this.instance.offset.click.left = f.offset.click.left; this.instance.offset.parent.left -= f.offset.parent.left - this.instance.offset.parent.left; this.instance.offset.parent.top -= f.offset.parent.top - this.instance.offset.parent.top; f._trigger("toSortable", d); f.dropped = this.instance.element; f.currentItem = f.element; this.instance.fromOutside = f
                    } this.instance.currentItem && this.instance._mouseDrag(d)
                } else if (this.instance.isOver) {
                    this.instance.isOver =
0; this.instance.cancelHelperRemoval = true; this.instance.options.revert = false; this.instance._trigger("out", d, this.instance._uiHash(this.instance)); this.instance._mouseStop(d, true); this.instance.options.helper = this.instance.options._helper; this.instance.currentItem.remove(); this.instance.placeholder && this.instance.placeholder.remove(); f._trigger("fromSortable", d); f.dropped = false
                } 
            })
        } 
        }); a.ui.plugin.add("draggable", "cursor", { start: function() {
            var d = a("body"), c = a(this).data("draggable").options; if (d.css("cursor")) c._cursor =
d.css("cursor"); d.css("cursor", c.cursor)
        }, stop: function() { var d = a(this).data("draggable").options; d._cursor && a("body").css("cursor", d._cursor) } 
        }); a.ui.plugin.add("draggable", "opacity", { start: function(d, c) { d = a(c.helper); c = a(this).data("draggable").options; if (d.css("opacity")) c._opacity = d.css("opacity"); d.css("opacity", c.opacity) }, stop: function(d, c) { d = a(this).data("draggable").options; d._opacity && a(c.helper).css("opacity", d._opacity) } }); a.ui.plugin.add("draggable", "scroll", { start: function() {
            var d = a(this).data("draggable");
            if (d.scrollParent[0] != document && d.scrollParent[0].tagName != "HTML") d.overflowOffset = d.scrollParent.offset()
        }, drag: function(d) {
            var c = a(this).data("draggable"), f = c.options, g = false; if (c.scrollParent[0] != document && c.scrollParent[0].tagName != "HTML") {
                if (!f.axis || f.axis != "x") if (c.overflowOffset.top + c.scrollParent[0].offsetHeight - d.pageY < f.scrollSensitivity) c.scrollParent[0].scrollTop = g = c.scrollParent[0].scrollTop + f.scrollSpeed; else if (d.pageY - c.overflowOffset.top < f.scrollSensitivity) c.scrollParent[0].scrollTop =
g = c.scrollParent[0].scrollTop - f.scrollSpeed; if (!f.axis || f.axis != "y") if (c.overflowOffset.left + c.scrollParent[0].offsetWidth - d.pageX < f.scrollSensitivity) c.scrollParent[0].scrollLeft = g = c.scrollParent[0].scrollLeft + f.scrollSpeed; else if (d.pageX - c.overflowOffset.left < f.scrollSensitivity) c.scrollParent[0].scrollLeft = g = c.scrollParent[0].scrollLeft - f.scrollSpeed
            } else {
                if (!f.axis || f.axis != "x") if (d.pageY - a(document).scrollTop() < f.scrollSensitivity) g = a(document).scrollTop(a(document).scrollTop() - f.scrollSpeed);
                else if (a(window).height() - (d.pageY - a(document).scrollTop()) < f.scrollSensitivity) g = a(document).scrollTop(a(document).scrollTop() + f.scrollSpeed); if (!f.axis || f.axis != "y") if (d.pageX - a(document).scrollLeft() < f.scrollSensitivity) g = a(document).scrollLeft(a(document).scrollLeft() - f.scrollSpeed); else if (a(window).width() - (d.pageX - a(document).scrollLeft()) < f.scrollSensitivity) g = a(document).scrollLeft(a(document).scrollLeft() + f.scrollSpeed)
            } g !== false && a.ui.ddmanager && !f.dropBehaviour && a.ui.ddmanager.prepareOffsets(c,
d)
        } 
        }); a.ui.plugin.add("draggable", "snap", { start: function() { var d = a(this).data("draggable"), c = d.options; d.snapElements = []; a(c.snap.constructor != String ? c.snap.items || ":data(draggable)" : c.snap).each(function() { var f = a(this), g = f.offset(); this != d.element[0] && d.snapElements.push({ item: this, width: f.outerWidth(), height: f.outerHeight(), top: g.top, left: g.left }) }) }, drag: function(d, c) {
            for (var f = a(this).data("draggable"), g = f.options, e = g.snapTolerance, i = c.offset.left, b = i + f.helperProportions.width, h = c.offset.top,
j = h + f.helperProportions.height, l = f.snapElements.length - 1; l >= 0; l--) {
                var o = f.snapElements[l].left, n = o + f.snapElements[l].width, k = f.snapElements[l].top, m = k + f.snapElements[l].height; if (o - e < i && i < n + e && k - e < h && h < m + e || o - e < i && i < n + e && k - e < j && j < m + e || o - e < b && b < n + e && k - e < h && h < m + e || o - e < b && b < n + e && k - e < j && j < m + e) {
                    if (g.snapMode != "inner") {
                        var p = Math.abs(k - j) <= e, q = Math.abs(m - h) <= e, s = Math.abs(o - b) <= e, r = Math.abs(n - i) <= e; if (p) c.position.top = f._convertPositionTo("relative", { top: k - f.helperProportions.height, left: 0 }).top - f.margins.top;
                        if (q) c.position.top = f._convertPositionTo("relative", { top: m, left: 0 }).top - f.margins.top; if (s) c.position.left = f._convertPositionTo("relative", { top: 0, left: o - f.helperProportions.width }).left - f.margins.left; if (r) c.position.left = f._convertPositionTo("relative", { top: 0, left: n }).left - f.margins.left
                    } var u = p || q || s || r; if (g.snapMode != "outer") {
                        p = Math.abs(k - h) <= e; q = Math.abs(m - j) <= e; s = Math.abs(o - i) <= e; r = Math.abs(n - b) <= e; if (p) c.position.top = f._convertPositionTo("relative", { top: k, left: 0 }).top - f.margins.top; if (q) c.position.top =
f._convertPositionTo("relative", { top: m - f.helperProportions.height, left: 0 }).top - f.margins.top; if (s) c.position.left = f._convertPositionTo("relative", { top: 0, left: o }).left - f.margins.left; if (r) c.position.left = f._convertPositionTo("relative", { top: 0, left: n - f.helperProportions.width }).left - f.margins.left
                    } if (!f.snapElements[l].snapping && (p || q || s || r || u)) f.options.snap.snap && f.options.snap.snap.call(f.element, d, a.extend(f._uiHash(), { snapItem: f.snapElements[l].item })); f.snapElements[l].snapping = p || q || s || r || u
                } else {
                    f.snapElements[l].snapping &&
f.options.snap.release && f.options.snap.release.call(f.element, d, a.extend(f._uiHash(), { snapItem: f.snapElements[l].item })); f.snapElements[l].snapping = false
                } 
            } 
        } 
        }); a.ui.plugin.add("draggable", "stack", { start: function() { var d = a(this).data("draggable").options; d = a.makeArray(a(d.stack)).sort(function(f, g) { return (parseInt(a(f).css("zIndex"), 10) || 0) - (parseInt(a(g).css("zIndex"), 10) || 0) }); if (d.length) { var c = parseInt(d[0].style.zIndex) || 0; a(d).each(function(f) { this.style.zIndex = c + f }); this[0].style.zIndex = c + d.length } } });
        a.ui.plugin.add("draggable", "zIndex", { start: function(d, c) { d = a(c.helper); c = a(this).data("draggable").options; if (d.css("zIndex")) c._zIndex = d.css("zIndex"); d.css("zIndex", c.zIndex) }, stop: function(d, c) { d = a(this).data("draggable").options; d._zIndex && a(c.helper).css("zIndex", d._zIndex) } })
    })(jQuery);
    (function(a) {
        a.widget("ui.droppable", { widgetEventPrefix: "drop", options: { accept: "*", activeClass: false, addClasses: true, greedy: false, hoverClass: false, scope: "default", tolerance: "intersect" }, _create: function() {
            var d = this.options, c = d.accept; this.isover = 0; this.isout = 1; this.accept = a.isFunction(c) ? c : function(f) { return f.is(c) }; this.proportions = { width: this.element[0].offsetWidth, height: this.element[0].offsetHeight }; a.ui.ddmanager.droppables[d.scope] = a.ui.ddmanager.droppables[d.scope] || []; a.ui.ddmanager.droppables[d.scope].push(this);
            d.addClasses && this.element.addClass("ui-droppable")
        }, destroy: function() { for (var d = a.ui.ddmanager.droppables[this.options.scope], c = 0; c < d.length; c++) d[c] == this && d.splice(c, 1); this.element.removeClass("ui-droppable ui-droppable-disabled").removeData("droppable").unbind(".droppable"); return this }, _setOption: function(d, c) { if (d == "accept") this.accept = a.isFunction(c) ? c : function(f) { return f.is(c) }; a.Widget.prototype._setOption.apply(this, arguments) }, _activate: function(d) {
            var c = a.ui.ddmanager.current; this.options.activeClass &&
this.element.addClass(this.options.activeClass); c && this._trigger("activate", d, this.ui(c))
        }, _deactivate: function(d) { var c = a.ui.ddmanager.current; this.options.activeClass && this.element.removeClass(this.options.activeClass); c && this._trigger("deactivate", d, this.ui(c)) }, _over: function(d) {
            var c = a.ui.ddmanager.current; if (!(!c || (c.currentItem || c.element)[0] == this.element[0])) if (this.accept.call(this.element[0], c.currentItem || c.element)) {
                this.options.hoverClass && this.element.addClass(this.options.hoverClass);
                this._trigger("over", d, this.ui(c))
            } 
        }, _out: function(d) { var c = a.ui.ddmanager.current; if (!(!c || (c.currentItem || c.element)[0] == this.element[0])) if (this.accept.call(this.element[0], c.currentItem || c.element)) { this.options.hoverClass && this.element.removeClass(this.options.hoverClass); this._trigger("out", d, this.ui(c)) } }, _drop: function(d, c) {
            var f = c || a.ui.ddmanager.current; if (!f || (f.currentItem || f.element)[0] == this.element[0]) return false; var g = false; this.element.find(":data(droppable)").not(".ui-draggable-dragging").each(function() {
                var e =
a.data(this, "droppable"); if (e.options.greedy && !e.options.disabled && e.options.scope == f.options.scope && e.accept.call(e.element[0], f.currentItem || f.element) && a.ui.intersect(f, a.extend(e, { offset: e.element.offset() }), e.options.tolerance)) { g = true; return false } 
            }); if (g) return false; if (this.accept.call(this.element[0], f.currentItem || f.element)) {
                this.options.activeClass && this.element.removeClass(this.options.activeClass); this.options.hoverClass && this.element.removeClass(this.options.hoverClass); this._trigger("drop",
d, this.ui(f)); return this.element
            } return false
        }, ui: function(d) { return { draggable: d.currentItem || d.element, helper: d.helper, position: d.position, offset: d.positionAbs} } 
        }); a.extend(a.ui.droppable, { version: "1.8.13" }); a.ui.intersect = function(d, c, f) {
            if (!c.offset) return false; var g = (d.positionAbs || d.position.absolute).left, e = g + d.helperProportions.width, i = (d.positionAbs || d.position.absolute).top, b = i + d.helperProportions.height, h = c.offset.left, j = h + c.proportions.width, l = c.offset.top, o = l + c.proportions.height;
            switch (f) {
                case "fit": return h <= g && e <= j && l <= i && b <= o; case "intersect": return h < g + d.helperProportions.width / 2 && e - d.helperProportions.width / 2 < j && l < i + d.helperProportions.height / 2 && b - d.helperProportions.height / 2 < o; case "pointer": return a.ui.isOver((d.positionAbs || d.position.absolute).top + (d.clickOffset || d.offset.click).top, (d.positionAbs || d.position.absolute).left + (d.clickOffset || d.offset.click).left, l, h, c.proportions.height, c.proportions.width); case "touch": return (i >= l && i <= o || b >= l && b <= o || i < l && b > o) && (g >=
h && g <= j || e >= h && e <= j || g < h && e > j); default: return false
            } 
        }; a.ui.ddmanager = { current: null, droppables: { "default": [] }, prepareOffsets: function(d, c) {
            var f = a.ui.ddmanager.droppables[d.options.scope] || [], g = c ? c.type : null, e = (d.currentItem || d.element).find(":data(droppable)").andSelf(), i = 0; a: for (; i < f.length; i++) if (!(f[i].options.disabled || d && !f[i].accept.call(f[i].element[0], d.currentItem || d.element))) {
                for (var b = 0; b < e.length; b++) if (e[b] == f[i].element[0]) { f[i].proportions.height = 0; continue a } f[i].visible = f[i].element.css("display") !=
"none"; if (f[i].visible) { g == "mousedown" && f[i]._activate.call(f[i], c); f[i].offset = f[i].element.offset(); f[i].proportions = { width: f[i].element[0].offsetWidth, height: f[i].element[0].offsetHeight} } 
            } 
        }, drop: function(d, c) {
            var f = false; a.each(a.ui.ddmanager.droppables[d.options.scope] || [], function() {
                if (this.options) {
                    if (!this.options.disabled && this.visible && a.ui.intersect(d, this, this.options.tolerance)) f = f || this._drop.call(this, c); if (!this.options.disabled && this.visible && this.accept.call(this.element[0], d.currentItem ||
d.element)) { this.isout = 1; this.isover = 0; this._deactivate.call(this, c) } 
                } 
            }); return f
        }, drag: function(d, c) {
            d.options.refreshPositions && a.ui.ddmanager.prepareOffsets(d, c); a.each(a.ui.ddmanager.droppables[d.options.scope] || [], function() {
                if (!(this.options.disabled || this.greedyChild || !this.visible)) {
                    var f = a.ui.intersect(d, this, this.options.tolerance); if (f = !f && this.isover == 1 ? "isout" : f && this.isover == 0 ? "isover" : null) {
                        var g; if (this.options.greedy) {
                            var e = this.element.parents(":data(droppable):eq(0)"); if (e.length) {
                                g =
a.data(e[0], "droppable"); g.greedyChild = f == "isover" ? 1 : 0
                            } 
                        } if (g && f == "isover") { g.isover = 0; g.isout = 1; g._out.call(g, c) } this[f] = 1; this[f == "isout" ? "isover" : "isout"] = 0; this[f == "isover" ? "_over" : "_out"].call(this, c); if (g && f == "isout") { g.isout = 0; g.isover = 1; g._over.call(g, c) } 
                    } 
                } 
            })
        } }
        })(jQuery);
        (function(a) {
            a.widget("ui.resizable", a.ui.mouse, { widgetEventPrefix: "resize", options: { alsoResize: false, animate: false, animateDuration: "slow", animateEasing: "swing", aspectRatio: false, autoHide: false, containment: false, ghost: false, grid: false, handles: "e,s,se", helper: false, maxHeight: null, maxWidth: null, minHeight: 10, minWidth: 10, zIndex: 1E3 }, _create: function() {
                var f = this, g = this.options; this.element.addClass("ui-resizable"); a.extend(this, { _aspectRatio: !!g.aspectRatio, aspectRatio: g.aspectRatio, originalElement: this.element,
                    _proportionallyResizeElements: [], _helper: g.helper || g.ghost || g.animate ? g.helper || "ui-resizable-helper" : null
                }); if (this.element[0].nodeName.match(/canvas|textarea|input|select|button|img/i)) {
                    /relative/.test(this.element.css("position")) && a.browser.opera && this.element.css({ position: "relative", top: "auto", left: "auto" }); this.element.wrap(a('<div class="ui-wrapper" style="overflow: hidden;"></div>').css({ position: this.element.css("position"), width: this.element.outerWidth(), height: this.element.outerHeight(),
                        top: this.element.css("top"), left: this.element.css("left")
                    })); this.element = this.element.parent().data("resizable", this.element.data("resizable")); this.elementIsWrapper = true; this.element.css({ marginLeft: this.originalElement.css("marginLeft"), marginTop: this.originalElement.css("marginTop"), marginRight: this.originalElement.css("marginRight"), marginBottom: this.originalElement.css("marginBottom") }); this.originalElement.css({ marginLeft: 0, marginTop: 0, marginRight: 0, marginBottom: 0 }); this.originalResizeStyle =
this.originalElement.css("resize"); this.originalElement.css("resize", "none"); this._proportionallyResizeElements.push(this.originalElement.css({ position: "static", zoom: 1, display: "block" })); this.originalElement.css({ margin: this.originalElement.css("margin") }); this._proportionallyResize()
                } this.handles = g.handles || (!a(".ui-resizable-handle", this.element).length ? "e,s,se" : { n: ".ui-resizable-n", e: ".ui-resizable-e", s: ".ui-resizable-s", w: ".ui-resizable-w", se: ".ui-resizable-se", sw: ".ui-resizable-sw", ne: ".ui-resizable-ne",
                    nw: ".ui-resizable-nw"
                }); if (this.handles.constructor == String) { if (this.handles == "all") this.handles = "n,e,s,w,se,sw,ne,nw"; var e = this.handles.split(","); this.handles = {}; for (var i = 0; i < e.length; i++) { var b = a.trim(e[i]), h = a('<div class="ui-resizable-handle ' + ("ui-resizable-" + b) + '"></div>'); /sw|se|ne|nw/.test(b) && h.css({ zIndex: ++g.zIndex }); "se" == b && h.addClass("ui-icon ui-icon-gripsmall-diagonal-se"); this.handles[b] = ".ui-resizable-" + b; this.element.append(h) } } this._renderAxis = function(j) {
                    j = j || this.element; for (var l in this.handles) {
                        if (this.handles[l].constructor ==
String) this.handles[l] = a(this.handles[l], this.element).show(); if (this.elementIsWrapper && this.originalElement[0].nodeName.match(/textarea|input|select|button/i)) { var o = a(this.handles[l], this.element), n = 0; n = /sw|ne|nw|se|n|s/.test(l) ? o.outerHeight() : o.outerWidth(); o = ["padding", /ne|nw|n/.test(l) ? "Top" : /se|sw|s/.test(l) ? "Bottom" : /^e$/.test(l) ? "Right" : "Left"].join(""); j.css(o, n); this._proportionallyResize() } a(this.handles[l])
                    } 
                }; this._renderAxis(this.element); this._handles = a(".ui-resizable-handle", this.element).disableSelection();
                this._handles.mouseover(function() { if (!f.resizing) { if (this.className) var j = this.className.match(/ui-resizable-(se|sw|ne|nw|n|e|s|w)/i); f.axis = j && j[1] ? j[1] : "se" } }); if (g.autoHide) { this._handles.hide(); a(this.element).addClass("ui-resizable-autohide").hover(function() { if (!g.disabled) { a(this).removeClass("ui-resizable-autohide"); f._handles.show() } }, function() { if (!g.disabled) if (!f.resizing) { a(this).addClass("ui-resizable-autohide"); f._handles.hide() } }) } this._mouseInit()
            }, destroy: function() {
                this._mouseDestroy();
                var f = function(e) { a(e).removeClass("ui-resizable ui-resizable-disabled ui-resizable-resizing").removeData("resizable").unbind(".resizable").find(".ui-resizable-handle").remove() }; if (this.elementIsWrapper) { f(this.element); var g = this.element; g.after(this.originalElement.css({ position: g.css("position"), width: g.outerWidth(), height: g.outerHeight(), top: g.css("top"), left: g.css("left") })).remove() } this.originalElement.css("resize", this.originalResizeStyle); f(this.originalElement); return this
            }, _mouseCapture: function(f) {
                var g =
false; for (var e in this.handles) if (a(this.handles[e])[0] == f.target) g = true; return !this.options.disabled && g
            }, _mouseStart: function(f) {
                var g = this.options, e = this.element.position(), i = this.element; this.resizing = true; this.documentScroll = { top: a(document).scrollTop(), left: a(document).scrollLeft() }; if (i.is(".ui-draggable") || /absolute/.test(i.css("position"))) i.css({ position: "absolute", top: e.top, left: e.left }); a.browser.opera && /relative/.test(i.css("position")) && i.css({ position: "relative", top: "auto", left: "auto" });
                this._renderProxy(); e = d(this.helper.css("left")); var b = d(this.helper.css("top")); if (g.containment) { e += a(g.containment).scrollLeft() || 0; b += a(g.containment).scrollTop() || 0 } this.offset = this.helper.offset(); this.position = { left: e, top: b }; this.size = this._helper ? { width: i.outerWidth(), height: i.outerHeight()} : { width: i.width(), height: i.height() }; this.originalSize = this._helper ? { width: i.outerWidth(), height: i.outerHeight()} : { width: i.width(), height: i.height() }; this.originalPosition = { left: e, top: b }; this.sizeDiff =
{ width: i.outerWidth() - i.width(), height: i.outerHeight() - i.height() }; this.originalMousePosition = { left: f.pageX, top: f.pageY }; this.aspectRatio = typeof g.aspectRatio == "number" ? g.aspectRatio : this.originalSize.width / this.originalSize.height || 1; g = a(".ui-resizable-" + this.axis).css("cursor"); a("body").css("cursor", g == "auto" ? this.axis + "-resize" : g); i.addClass("ui-resizable-resizing"); this._propagate("start", f); return true
            }, _mouseDrag: function(f) {
                var g = this.helper, e = this.originalMousePosition, i = this._change[this.axis];
                if (!i) return false; e = i.apply(this, [f, f.pageX - e.left || 0, f.pageY - e.top || 0]); if (this._aspectRatio || f.shiftKey) e = this._updateRatio(e, f); e = this._respectSize(e, f); this._propagate("resize", f); g.css({ top: this.position.top + "px", left: this.position.left + "px", width: this.size.width + "px", height: this.size.height + "px" }); !this._helper && this._proportionallyResizeElements.length && this._proportionallyResize(); this._updateCache(e); this._trigger("resize", f, this.ui()); return false
            }, _mouseStop: function(f) {
                this.resizing =
false; var g = this.options, e = this; if (this._helper) {
                    var i = this._proportionallyResizeElements, b = i.length && /textarea/i.test(i[0].nodeName); i = b && a.ui.hasScroll(i[0], "left") ? 0 : e.sizeDiff.height; b = b ? 0 : e.sizeDiff.width; b = { width: e.helper.width() - b, height: e.helper.height() - i }; i = parseInt(e.element.css("left"), 10) + (e.position.left - e.originalPosition.left) || null; var h = parseInt(e.element.css("top"), 10) + (e.position.top - e.originalPosition.top) || null; g.animate || this.element.css(a.extend(b, { top: h, left: i })); e.helper.height(e.size.height);
                    e.helper.width(e.size.width); this._helper && !g.animate && this._proportionallyResize()
                } a("body").css("cursor", "auto"); this.element.removeClass("ui-resizable-resizing"); this._propagate("stop", f); this._helper && this.helper.remove(); return false
            }, _updateCache: function(f) { this.offset = this.helper.offset(); if (c(f.left)) this.position.left = f.left; if (c(f.top)) this.position.top = f.top; if (c(f.height)) this.size.height = f.height; if (c(f.width)) this.size.width = f.width }, _updateRatio: function(f) {
                var g = this.position, e = this.size,
i = this.axis; if (f.height) f.width = e.height * this.aspectRatio; else if (f.width) f.height = e.width / this.aspectRatio; if (i == "sw") { f.left = g.left + (e.width - f.width); f.top = null } if (i == "nw") { f.top = g.top + (e.height - f.height); f.left = g.left + (e.width - f.width) } return f
            }, _respectSize: function(f) {
                var g = this.options, e = this.axis, i = c(f.width) && g.maxWidth && g.maxWidth < f.width, b = c(f.height) && g.maxHeight && g.maxHeight < f.height, h = c(f.width) && g.minWidth && g.minWidth > f.width, j = c(f.height) && g.minHeight && g.minHeight > f.height; if (h) f.width =
g.minWidth; if (j) f.height = g.minHeight; if (i) f.width = g.maxWidth; if (b) f.height = g.maxHeight; var l = this.originalPosition.left + this.originalSize.width, o = this.position.top + this.size.height, n = /sw|nw|w/.test(e); e = /nw|ne|n/.test(e); if (h && n) f.left = l - g.minWidth; if (i && n) f.left = l - g.maxWidth; if (j && e) f.top = o - g.minHeight; if (b && e) f.top = o - g.maxHeight; if ((g = !f.width && !f.height) && !f.left && f.top) f.top = null; else if (g && !f.top && f.left) f.left = null; return f
            }, _proportionallyResize: function() {
                if (this._proportionallyResizeElements.length) for (var f =
this.helper || this.element, g = 0; g < this._proportionallyResizeElements.length; g++) {
                    var e = this._proportionallyResizeElements[g]; if (!this.borderDif) { var i = [e.css("borderTopWidth"), e.css("borderRightWidth"), e.css("borderBottomWidth"), e.css("borderLeftWidth")], b = [e.css("paddingTop"), e.css("paddingRight"), e.css("paddingBottom"), e.css("paddingLeft")]; this.borderDif = a.map(i, function(h, j) { h = parseInt(h, 10) || 0; j = parseInt(b[j], 10) || 0; return h + j }) } a.browser.msie && (a(f).is(":hidden") || a(f).parents(":hidden").length) ||
e.css({ height: f.height() - this.borderDif[0] - this.borderDif[2] || 0, width: f.width() - this.borderDif[1] - this.borderDif[3] || 0 })
                } 
            }, _renderProxy: function() {
                var f = this.options; this.elementOffset = this.element.offset(); if (this._helper) {
                    this.helper = this.helper || a('<div style="overflow:hidden;"></div>'); var g = a.browser.msie && a.browser.version < 7, e = g ? 1 : 0; g = g ? 2 : -1; this.helper.addClass(this._helper).css({ width: this.element.outerWidth() + g, height: this.element.outerHeight() + g, position: "absolute", left: this.elementOffset.left -
e + "px", top: this.elementOffset.top - e + "px", zIndex: ++f.zIndex
                    }); this.helper.appendTo("body").disableSelection()
                } else this.helper = this.element
            }, _change: { e: function(f, g) { return { width: this.originalSize.width + g} }, w: function(f, g) { return { left: this.originalPosition.left + g, width: this.originalSize.width - g} }, n: function(f, g, e) { return { top: this.originalPosition.top + e, height: this.originalSize.height - e} }, s: function(f, g, e) { return { height: this.originalSize.height + e} }, se: function(f, g, e) {
                return a.extend(this._change.s.apply(this,
arguments), this._change.e.apply(this, [f, g, e]))
            }, sw: function(f, g, e) { return a.extend(this._change.s.apply(this, arguments), this._change.w.apply(this, [f, g, e])) }, ne: function(f, g, e) { return a.extend(this._change.n.apply(this, arguments), this._change.e.apply(this, [f, g, e])) }, nw: function(f, g, e) { return a.extend(this._change.n.apply(this, arguments), this._change.w.apply(this, [f, g, e])) } 
            }, _propagate: function(f, g) { a.ui.plugin.call(this, f, [g, this.ui()]); f != "resize" && this._trigger(f, g, this.ui()) }, plugins: {}, ui: function() {
                return { originalElement: this.originalElement,
                    element: this.element, helper: this.helper, position: this.position, size: this.size, originalSize: this.originalSize, originalPosition: this.originalPosition}
                } 
            }); a.extend(a.ui.resizable, { version: "1.8.13" }); a.ui.plugin.add("resizable", "alsoResize", { start: function() {
                var f = a(this).data("resizable").options, g = function(e) { a(e).each(function() { var i = a(this); i.data("resizable-alsoresize", { width: parseInt(i.width(), 10), height: parseInt(i.height(), 10), left: parseInt(i.css("left"), 10), top: parseInt(i.css("top"), 10), position: i.css("position") }) }) };
                if (typeof f.alsoResize == "object" && !f.alsoResize.parentNode) if (f.alsoResize.length) { f.alsoResize = f.alsoResize[0]; g(f.alsoResize) } else a.each(f.alsoResize, function(e) { g(e) }); else g(f.alsoResize)
            }, resize: function(f, g) {
                var e = a(this).data("resizable"); f = e.options; var i = e.originalSize, b = e.originalPosition, h = { height: e.size.height - i.height || 0, width: e.size.width - i.width || 0, top: e.position.top - b.top || 0, left: e.position.left - b.left || 0 }, j = function(l, o) {
                    a(l).each(function() {
                        var n = a(this), k = a(this).data("resizable-alsoresize"),
m = {}, p = o && o.length ? o : n.parents(g.originalElement[0]).length ? ["width", "height"] : ["width", "height", "top", "left"]; a.each(p, function(q, s) { if ((q = (k[s] || 0) + (h[s] || 0)) && q >= 0) m[s] = q || null }); if (a.browser.opera && /relative/.test(n.css("position"))) { e._revertToRelativePosition = true; n.css({ position: "absolute", top: "auto", left: "auto" }) } n.css(m)
                    })
                }; typeof f.alsoResize == "object" && !f.alsoResize.nodeType ? a.each(f.alsoResize, function(l, o) { j(l, o) }) : j(f.alsoResize)
            }, stop: function() {
                var f = a(this).data("resizable"), g = f.options,
e = function(i) { a(i).each(function() { var b = a(this); b.css({ position: b.data("resizable-alsoresize").position }) }) }; if (f._revertToRelativePosition) { f._revertToRelativePosition = false; typeof g.alsoResize == "object" && !g.alsoResize.nodeType ? a.each(g.alsoResize, function(i) { e(i) }) : e(g.alsoResize) } a(this).removeData("resizable-alsoresize")
            } 
            }); a.ui.plugin.add("resizable", "animate", { stop: function(f) {
                var g = a(this).data("resizable"), e = g.options, i = g._proportionallyResizeElements, b = i.length && /textarea/i.test(i[0].nodeName),
h = b && a.ui.hasScroll(i[0], "left") ? 0 : g.sizeDiff.height; b = { width: g.size.width - (b ? 0 : g.sizeDiff.width), height: g.size.height - h }; h = parseInt(g.element.css("left"), 10) + (g.position.left - g.originalPosition.left) || null; var j = parseInt(g.element.css("top"), 10) + (g.position.top - g.originalPosition.top) || null; g.element.animate(a.extend(b, j && h ? { top: j, left: h} : {}), { duration: e.animateDuration, easing: e.animateEasing, step: function() {
    var l = { width: parseInt(g.element.css("width"), 10), height: parseInt(g.element.css("height"),
10), top: parseInt(g.element.css("top"), 10), left: parseInt(g.element.css("left"), 10)
    }; i && i.length && a(i[0]).css({ width: l.width, height: l.height }); g._updateCache(l); g._propagate("resize", f)
} 
})
            } 
            }); a.ui.plugin.add("resizable", "containment", { start: function() {
                var f = a(this).data("resizable"), g = f.element, e = f.options.containment; if (g = e instanceof a ? e.get(0) : /parent/.test(e) ? g.parent().get(0) : e) {
                    f.containerElement = a(g); if (/document/.test(e) || e == document) {
                        f.containerOffset = { left: 0, top: 0 }; f.containerPosition = { left: 0,
                            top: 0
                        }; f.parentData = { element: a(document), left: 0, top: 0, width: a(document).width(), height: a(document).height() || document.body.parentNode.scrollHeight}
                    } else {
                        var i = a(g), b = []; a(["Top", "Right", "Left", "Bottom"]).each(function(l, o) { b[l] = d(i.css("padding" + o)) }); f.containerOffset = i.offset(); f.containerPosition = i.position(); f.containerSize = { height: i.innerHeight() - b[3], width: i.innerWidth() - b[1] }; e = f.containerOffset; var h = f.containerSize.height, j = f.containerSize.width; j = a.ui.hasScroll(g, "left") ? g.scrollWidth : j;
                        h = a.ui.hasScroll(g) ? g.scrollHeight : h; f.parentData = { element: g, left: e.left, top: e.top, width: j, height: h}
                    } 
                } 
            }, resize: function(f) {
                var g = a(this).data("resizable"), e = g.options, i = g.containerOffset, b = g.position; f = g._aspectRatio || f.shiftKey; var h = { top: 0, left: 0 }, j = g.containerElement; if (j[0] != document && /static/.test(j.css("position"))) h = i; if (b.left < (g._helper ? i.left : 0)) {
                    g.size.width += g._helper ? g.position.left - i.left : g.position.left - h.left; if (f) g.size.height = g.size.width / e.aspectRatio; g.position.left = e.helper ? i.left :
0
                } if (b.top < (g._helper ? i.top : 0)) { g.size.height += g._helper ? g.position.top - i.top : g.position.top; if (f) g.size.width = g.size.height * e.aspectRatio; g.position.top = g._helper ? i.top : 0 } g.offset.left = g.parentData.left + g.position.left; g.offset.top = g.parentData.top + g.position.top; e = Math.abs((g._helper ? g.offset.left - h.left : g.offset.left - h.left) + g.sizeDiff.width); i = Math.abs((g._helper ? g.offset.top - h.top : g.offset.top - i.top) + g.sizeDiff.height); b = g.containerElement.get(0) == g.element.parent().get(0); h = /relative|absolute/.test(g.containerElement.css("position"));
                if (b && h) e -= g.parentData.left; if (e + g.size.width >= g.parentData.width) { g.size.width = g.parentData.width - e; if (f) g.size.height = g.size.width / g.aspectRatio } if (i + g.size.height >= g.parentData.height) { g.size.height = g.parentData.height - i; if (f) g.size.width = g.size.height * g.aspectRatio } 
            }, stop: function() {
                var f = a(this).data("resizable"), g = f.options, e = f.containerOffset, i = f.containerPosition, b = f.containerElement, h = a(f.helper), j = h.offset(), l = h.outerWidth() - f.sizeDiff.width; h = h.outerHeight() - f.sizeDiff.height; f._helper &&
!g.animate && /relative/.test(b.css("position")) && a(this).css({ left: j.left - i.left - e.left, width: l, height: h }); f._helper && !g.animate && /static/.test(b.css("position")) && a(this).css({ left: j.left - i.left - e.left, width: l, height: h })
            } 
            }); a.ui.plugin.add("resizable", "ghost", { start: function() {
                var f = a(this).data("resizable"), g = f.options, e = f.size; f.ghost = f.originalElement.clone(); f.ghost.css({ opacity: 0.25, display: "block", position: "relative", height: e.height, width: e.width, margin: 0, left: 0, top: 0 }).addClass("ui-resizable-ghost").addClass(typeof g.ghost ==
"string" ? g.ghost : ""); f.ghost.appendTo(f.helper)
            }, resize: function() { var f = a(this).data("resizable"); f.ghost && f.ghost.css({ position: "relative", height: f.size.height, width: f.size.width }) }, stop: function() { var f = a(this).data("resizable"); f.ghost && f.helper && f.helper.get(0).removeChild(f.ghost.get(0)) } 
            }); a.ui.plugin.add("resizable", "grid", { resize: function() {
                var f = a(this).data("resizable"), g = f.options, e = f.size, i = f.originalSize, b = f.originalPosition, h = f.axis; g.grid = typeof g.grid == "number" ? [g.grid, g.grid] : g.grid;
                var j = Math.round((e.width - i.width) / (g.grid[0] || 1)) * (g.grid[0] || 1); g = Math.round((e.height - i.height) / (g.grid[1] || 1)) * (g.grid[1] || 1); if (/^(se|s|e)$/.test(h)) { f.size.width = i.width + j; f.size.height = i.height + g } else if (/^(ne)$/.test(h)) { f.size.width = i.width + j; f.size.height = i.height + g; f.position.top = b.top - g } else { if (/^(sw)$/.test(h)) { f.size.width = i.width + j; f.size.height = i.height + g } else { f.size.width = i.width + j; f.size.height = i.height + g; f.position.top = b.top - g } f.position.left = b.left - j } 
            } 
            }); var d = function(f) {
                return parseInt(f,
10) || 0
            }, c = function(f) { return !isNaN(parseInt(f, 10)) } 
        })(jQuery);
        (function(a) {
            a.widget("ui.selectable", a.ui.mouse, { options: { appendTo: "body", autoRefresh: true, distance: 0, filter: "*", tolerance: "touch" }, _create: function() {
                var d = this; this.element.addClass("ui-selectable"); this.dragged = false; var c; this.refresh = function() {
                    c = a(d.options.filter, d.element[0]); c.each(function() {
                        var f = a(this), g = f.offset(); a.data(this, "selectable-item", { element: this, $element: f, left: g.left, top: g.top, right: g.left + f.outerWidth(), bottom: g.top + f.outerHeight(), startselected: false, selected: f.hasClass("ui-selected"),
                            selecting: f.hasClass("ui-selecting"), unselecting: f.hasClass("ui-unselecting")
                        })
                    })
                }; this.refresh(); this.selectees = c.addClass("ui-selectee"); this._mouseInit(); this.helper = a("<div class='ui-selectable-helper'></div>")
            }, destroy: function() { this.selectees.removeClass("ui-selectee").removeData("selectable-item"); this.element.removeClass("ui-selectable ui-selectable-disabled").removeData("selectable").unbind(".selectable"); this._mouseDestroy(); return this }, _mouseStart: function(d) {
                var c = this; this.opos = [d.pageX,
d.pageY]; if (!this.options.disabled) {
                    var f = this.options; this.selectees = a(f.filter, this.element[0]); this._trigger("start", d); a(f.appendTo).append(this.helper); this.helper.css({ left: d.clientX, top: d.clientY, width: 0, height: 0 }); f.autoRefresh && this.refresh(); this.selectees.filter(".ui-selected").each(function() {
                        var g = a.data(this, "selectable-item"); g.startselected = true; if (!d.metaKey) {
                            g.$element.removeClass("ui-selected"); g.selected = false; g.$element.addClass("ui-unselecting"); g.unselecting = true; c._trigger("unselecting",
d, { unselecting: g.element })
                        } 
                    }); a(d.target).parents().andSelf().each(function() { var g = a.data(this, "selectable-item"); if (g) { var e = !d.metaKey || !g.$element.hasClass("ui-selected"); g.$element.removeClass(e ? "ui-unselecting" : "ui-selected").addClass(e ? "ui-selecting" : "ui-unselecting"); g.unselecting = !e; g.selecting = e; (g.selected = e) ? c._trigger("selecting", d, { selecting: g.element }) : c._trigger("unselecting", d, { unselecting: g.element }); return false } })
                } 
            }, _mouseDrag: function(d) {
                var c = this; this.dragged = true; if (!this.options.disabled) {
                    var f =
this.options, g = this.opos[0], e = this.opos[1], i = d.pageX, b = d.pageY; if (g > i) { var h = i; i = g; g = h } if (e > b) { h = b; b = e; e = h } this.helper.css({ left: g, top: e, width: i - g, height: b - e }); this.selectees.each(function() {
    var j = a.data(this, "selectable-item"); if (!(!j || j.element == c.element[0])) {
        var l = false; if (f.tolerance == "touch") l = !(j.left > i || j.right < g || j.top > b || j.bottom < e); else if (f.tolerance == "fit") l = j.left > g && j.right < i && j.top > e && j.bottom < b; if (l) {
            if (j.selected) { j.$element.removeClass("ui-selected"); j.selected = false } if (j.unselecting) {
                j.$element.removeClass("ui-unselecting");
                j.unselecting = false
            } if (!j.selecting) { j.$element.addClass("ui-selecting"); j.selecting = true; c._trigger("selecting", d, { selecting: j.element }) } 
        } else {
            if (j.selecting) if (d.metaKey && j.startselected) { j.$element.removeClass("ui-selecting"); j.selecting = false; j.$element.addClass("ui-selected"); j.selected = true } else { j.$element.removeClass("ui-selecting"); j.selecting = false; if (j.startselected) { j.$element.addClass("ui-unselecting"); j.unselecting = true } c._trigger("unselecting", d, { unselecting: j.element }) } if (j.selected) if (!d.metaKey &&
!j.startselected) { j.$element.removeClass("ui-selected"); j.selected = false; j.$element.addClass("ui-unselecting"); j.unselecting = true; c._trigger("unselecting", d, { unselecting: j.element }) } 
        } 
    } 
}); return false
                } 
            }, _mouseStop: function(d) {
                var c = this; this.dragged = false; a(".ui-unselecting", this.element[0]).each(function() { var f = a.data(this, "selectable-item"); f.$element.removeClass("ui-unselecting"); f.unselecting = false; f.startselected = false; c._trigger("unselected", d, { unselected: f.element }) }); a(".ui-selecting", this.element[0]).each(function() {
                    var f =
a.data(this, "selectable-item"); f.$element.removeClass("ui-selecting").addClass("ui-selected"); f.selecting = false; f.selected = true; f.startselected = true; c._trigger("selected", d, { selected: f.element })
                }); this._trigger("stop", d); this.helper.remove(); return false
            } 
            }); a.extend(a.ui.selectable, { version: "1.8.13" })
        })(jQuery);
        (function(a) {
            a.widget("ui.sortable", a.ui.mouse, { widgetEventPrefix: "sort", options: { appendTo: "parent", axis: false, connectWith: false, containment: false, cursor: "auto", cursorAt: false, dropOnEmpty: true, forcePlaceholderSize: false, forceHelperSize: false, grid: false, handle: false, helper: "original", items: "> *", opacity: false, placeholder: false, revert: false, scroll: true, scrollSensitivity: 20, scrollSpeed: 20, scope: "default", tolerance: "intersect", zIndex: 1E3 }, _create: function() {
                var d = this.options; this.containerCache = {}; this.element.addClass("ui-sortable");
                this.refresh(); this.floating = this.items.length ? d.axis === "x" || /left|right/.test(this.items[0].item.css("float")) || /inline|table-cell/.test(this.items[0].item.css("display")) : false; this.offset = this.element.offset(); this._mouseInit()
            }, destroy: function() { this.element.removeClass("ui-sortable ui-sortable-disabled").removeData("sortable").unbind(".sortable"); this._mouseDestroy(); for (var d = this.items.length - 1; d >= 0; d--) this.items[d].item.removeData("sortable-item"); return this }, _setOption: function(d, c) {
                if (d ===
"disabled") { this.options[d] = c; this.widget()[c ? "addClass" : "removeClass"]("ui-sortable-disabled") } else a.Widget.prototype._setOption.apply(this, arguments)
            }, _mouseCapture: function(d, c) {
                if (this.reverting) return false; if (this.options.disabled || this.options.type == "static") return false; this._refreshItems(d); var f = null, g = this; a(d.target).parents().each(function() { if (a.data(this, "sortable-item") == g) { f = a(this); return false } }); if (a.data(d.target, "sortable-item") == g) f = a(d.target); if (!f) return false; if (this.options.handle &&
!c) { var e = false; a(this.options.handle, f).find("*").andSelf().each(function() { if (this == d.target) e = true }); if (!e) return false } this.currentItem = f; this._removeCurrentsFromItems(); return true
            }, _mouseStart: function(d, c, f) {
                c = this.options; var g = this; this.currentContainer = this; this.refreshPositions(); this.helper = this._createHelper(d); this._cacheHelperProportions(); this._cacheMargins(); this.scrollParent = this.helper.scrollParent(); this.offset = this.currentItem.offset(); this.offset = { top: this.offset.top - this.margins.top,
                    left: this.offset.left - this.margins.left
                }; this.helper.css("position", "absolute"); this.cssPosition = this.helper.css("position"); a.extend(this.offset, { click: { left: d.pageX - this.offset.left, top: d.pageY - this.offset.top }, parent: this._getParentOffset(), relative: this._getRelativeOffset() }); this.originalPosition = this._generatePosition(d); this.originalPageX = d.pageX; this.originalPageY = d.pageY; c.cursorAt && this._adjustOffsetFromHelper(c.cursorAt); this.domPosition = { prev: this.currentItem.prev()[0], parent: this.currentItem.parent()[0] };
                this.helper[0] != this.currentItem[0] && this.currentItem.hide(); this._createPlaceholder(); c.containment && this._setContainment(); if (c.cursor) { if (a("body").css("cursor")) this._storedCursor = a("body").css("cursor"); a("body").css("cursor", c.cursor) } if (c.opacity) { if (this.helper.css("opacity")) this._storedOpacity = this.helper.css("opacity"); this.helper.css("opacity", c.opacity) } if (c.zIndex) { if (this.helper.css("zIndex")) this._storedZIndex = this.helper.css("zIndex"); this.helper.css("zIndex", c.zIndex) } if (this.scrollParent[0] !=
document && this.scrollParent[0].tagName != "HTML") this.overflowOffset = this.scrollParent.offset(); this._trigger("start", d, this._uiHash()); this._preserveHelperProportions || this._cacheHelperProportions(); if (!f) for (f = this.containers.length - 1; f >= 0; f--) this.containers[f]._trigger("activate", d, g._uiHash(this)); if (a.ui.ddmanager) a.ui.ddmanager.current = this; a.ui.ddmanager && !c.dropBehaviour && a.ui.ddmanager.prepareOffsets(this, d); this.dragging = true; this.helper.addClass("ui-sortable-helper"); this._mouseDrag(d);
                return true
            }, _mouseDrag: function(d) {
                this.position = this._generatePosition(d); this.positionAbs = this._convertPositionTo("absolute"); if (!this.lastPositionAbs) this.lastPositionAbs = this.positionAbs; if (this.options.scroll) {
                    var c = this.options, f = false; if (this.scrollParent[0] != document && this.scrollParent[0].tagName != "HTML") {
                        if (this.overflowOffset.top + this.scrollParent[0].offsetHeight - d.pageY < c.scrollSensitivity) this.scrollParent[0].scrollTop = f = this.scrollParent[0].scrollTop + c.scrollSpeed; else if (d.pageY - this.overflowOffset.top <
c.scrollSensitivity) this.scrollParent[0].scrollTop = f = this.scrollParent[0].scrollTop - c.scrollSpeed; if (this.overflowOffset.left + this.scrollParent[0].offsetWidth - d.pageX < c.scrollSensitivity) this.scrollParent[0].scrollLeft = f = this.scrollParent[0].scrollLeft + c.scrollSpeed; else if (d.pageX - this.overflowOffset.left < c.scrollSensitivity) this.scrollParent[0].scrollLeft = f = this.scrollParent[0].scrollLeft - c.scrollSpeed
                    } else {
                        if (d.pageY - a(document).scrollTop() < c.scrollSensitivity) f = a(document).scrollTop(a(document).scrollTop() -
c.scrollSpeed); else if (a(window).height() - (d.pageY - a(document).scrollTop()) < c.scrollSensitivity) f = a(document).scrollTop(a(document).scrollTop() + c.scrollSpeed); if (d.pageX - a(document).scrollLeft() < c.scrollSensitivity) f = a(document).scrollLeft(a(document).scrollLeft() - c.scrollSpeed); else if (a(window).width() - (d.pageX - a(document).scrollLeft()) < c.scrollSensitivity) f = a(document).scrollLeft(a(document).scrollLeft() + c.scrollSpeed)
                    } f !== false && a.ui.ddmanager && !c.dropBehaviour && a.ui.ddmanager.prepareOffsets(this,
d)
                } this.positionAbs = this._convertPositionTo("absolute"); if (!this.options.axis || this.options.axis != "y") this.helper[0].style.left = this.position.left + "px"; if (!this.options.axis || this.options.axis != "x") this.helper[0].style.top = this.position.top + "px"; for (c = this.items.length - 1; c >= 0; c--) {
                    f = this.items[c]; var g = f.item[0], e = this._intersectsWithPointer(f); if (e) if (g != this.currentItem[0] && this.placeholder[e == 1 ? "next" : "prev"]()[0] != g && !a.ui.contains(this.placeholder[0], g) && (this.options.type == "semi-dynamic" ? !a.ui.contains(this.element[0],
g) : true)) { this.direction = e == 1 ? "down" : "up"; if (this.options.tolerance == "pointer" || this._intersectsWithSides(f)) this._rearrange(d, f); else break; this._trigger("change", d, this._uiHash()); break } 
                } this._contactContainers(d); a.ui.ddmanager && a.ui.ddmanager.drag(this, d); this._trigger("sort", d, this._uiHash()); this.lastPositionAbs = this.positionAbs; return false
            }, _mouseStop: function(d, c) {
                if (d) {
                    a.ui.ddmanager && !this.options.dropBehaviour && a.ui.ddmanager.drop(this, d); if (this.options.revert) {
                        var f = this; c = f.placeholder.offset();
                        f.reverting = true; a(this.helper).animate({ left: c.left - this.offset.parent.left - f.margins.left + (this.offsetParent[0] == document.body ? 0 : this.offsetParent[0].scrollLeft), top: c.top - this.offset.parent.top - f.margins.top + (this.offsetParent[0] == document.body ? 0 : this.offsetParent[0].scrollTop) }, parseInt(this.options.revert, 10) || 500, function() { f._clear(d) })
                    } else this._clear(d, c); return false
                } 
            }, cancel: function() {
                var d = this; if (this.dragging) {
                    this._mouseUp({ target: null }); this.options.helper == "original" ? this.currentItem.css(this._storedCSS).removeClass("ui-sortable-helper") :
this.currentItem.show(); for (var c = this.containers.length - 1; c >= 0; c--) { this.containers[c]._trigger("deactivate", null, d._uiHash(this)); if (this.containers[c].containerCache.over) { this.containers[c]._trigger("out", null, d._uiHash(this)); this.containers[c].containerCache.over = 0 } } 
                } if (this.placeholder) {
                    this.placeholder[0].parentNode && this.placeholder[0].parentNode.removeChild(this.placeholder[0]); this.options.helper != "original" && this.helper && this.helper[0].parentNode && this.helper.remove(); a.extend(this, { helper: null,
                        dragging: false, reverting: false, _noFinalSort: null
                    }); this.domPosition.prev ? a(this.domPosition.prev).after(this.currentItem) : a(this.domPosition.parent).prepend(this.currentItem)
                } return this
            }, serialize: function(d) { var c = this._getItemsAsjQuery(d && d.connected), f = []; d = d || {}; a(c).each(function() { var g = (a(d.item || this).attr(d.attribute || "id") || "").match(d.expression || /(.+)[-=_](.+)/); if (g) f.push((d.key || g[1] + "[]") + "=" + (d.key && d.expression ? g[1] : g[2])) }); !f.length && d.key && f.push(d.key + "="); return f.join("&") },
                toArray: function(d) { var c = this._getItemsAsjQuery(d && d.connected), f = []; d = d || {}; c.each(function() { f.push(a(d.item || this).attr(d.attribute || "id") || "") }); return f }, _intersectsWith: function(d) {
                    var c = this.positionAbs.left, f = c + this.helperProportions.width, g = this.positionAbs.top, e = g + this.helperProportions.height, i = d.left, b = i + d.width, h = d.top, j = h + d.height, l = this.offset.click.top, o = this.offset.click.left; l = g + l > h && g + l < j && c + o > i && c + o < b; return this.options.tolerance == "pointer" || this.options.forcePointerForContainers ||
this.options.tolerance != "pointer" && this.helperProportions[this.floating ? "width" : "height"] > d[this.floating ? "width" : "height"] ? l : i < c + this.helperProportions.width / 2 && f - this.helperProportions.width / 2 < b && h < g + this.helperProportions.height / 2 && e - this.helperProportions.height / 2 < j
                }, _intersectsWithPointer: function(d) {
                    var c = a.ui.isOverAxis(this.positionAbs.top + this.offset.click.top, d.top, d.height); d = a.ui.isOverAxis(this.positionAbs.left + this.offset.click.left, d.left, d.width); c = c && d; d = this._getDragVerticalDirection();
                    var f = this._getDragHorizontalDirection(); if (!c) return false; return this.floating ? f && f == "right" || d == "down" ? 2 : 1 : d && (d == "down" ? 2 : 1)
                }, _intersectsWithSides: function(d) { var c = a.ui.isOverAxis(this.positionAbs.top + this.offset.click.top, d.top + d.height / 2, d.height); d = a.ui.isOverAxis(this.positionAbs.left + this.offset.click.left, d.left + d.width / 2, d.width); var f = this._getDragVerticalDirection(), g = this._getDragHorizontalDirection(); return this.floating && g ? g == "right" && d || g == "left" && !d : f && (f == "down" && c || f == "up" && !c) },
                _getDragVerticalDirection: function() { var d = this.positionAbs.top - this.lastPositionAbs.top; return d != 0 && (d > 0 ? "down" : "up") }, _getDragHorizontalDirection: function() { var d = this.positionAbs.left - this.lastPositionAbs.left; return d != 0 && (d > 0 ? "right" : "left") }, refresh: function(d) { this._refreshItems(d); this.refreshPositions(); return this }, _connectWith: function() { var d = this.options; return d.connectWith.constructor == String ? [d.connectWith] : d.connectWith }, _getItemsAsjQuery: function(d) {
                    var c = [], f = [], g = this._connectWith();
                    if (g && d) for (d = g.length - 1; d >= 0; d--) for (var e = a(g[d]), i = e.length - 1; i >= 0; i--) { var b = a.data(e[i], "sortable"); if (b && b != this && !b.options.disabled) f.push([a.isFunction(b.options.items) ? b.options.items.call(b.element) : a(b.options.items, b.element).not(".ui-sortable-helper").not(".ui-sortable-placeholder"), b]) } f.push([a.isFunction(this.options.items) ? this.options.items.call(this.element, null, { options: this.options, item: this.currentItem }) : a(this.options.items, this.element).not(".ui-sortable-helper").not(".ui-sortable-placeholder"),
this]); for (d = f.length - 1; d >= 0; d--) f[d][0].each(function() { c.push(this) }); return a(c)
                }, _removeCurrentsFromItems: function() { for (var d = this.currentItem.find(":data(sortable-item)"), c = 0; c < this.items.length; c++) for (var f = 0; f < d.length; f++) d[f] == this.items[c].item[0] && this.items.splice(c, 1) }, _refreshItems: function(d) {
                    this.items = []; this.containers = [this]; var c = this.items, f = [[a.isFunction(this.options.items) ? this.options.items.call(this.element[0], d, { item: this.currentItem }) : a(this.options.items, this.element),
this]], g = this._connectWith(); if (g) for (var e = g.length - 1; e >= 0; e--) for (var i = a(g[e]), b = i.length - 1; b >= 0; b--) { var h = a.data(i[b], "sortable"); if (h && h != this && !h.options.disabled) { f.push([a.isFunction(h.options.items) ? h.options.items.call(h.element[0], d, { item: this.currentItem }) : a(h.options.items, h.element), h]); this.containers.push(h) } } for (e = f.length - 1; e >= 0; e--) { d = f[e][1]; g = f[e][0]; b = 0; for (i = g.length; b < i; b++) { h = a(g[b]); h.data("sortable-item", d); c.push({ item: h, instance: d, width: 0, height: 0, left: 0, top: 0 }) } } 
                }, refreshPositions: function(d) {
                    if (this.offsetParent &&
this.helper) this.offset.parent = this._getParentOffset(); for (var c = this.items.length - 1; c >= 0; c--) { var f = this.items[c]; if (!(f.instance != this.currentContainer && this.currentContainer && f.item[0] != this.currentItem[0])) { var g = this.options.toleranceElement ? a(this.options.toleranceElement, f.item) : f.item; if (!d) { f.width = g.outerWidth(); f.height = g.outerHeight() } g = g.offset(); f.left = g.left; f.top = g.top } } if (this.options.custom && this.options.custom.refreshContainers) this.options.custom.refreshContainers.call(this); else for (c =
this.containers.length - 1; c >= 0; c--) { g = this.containers[c].element.offset(); this.containers[c].containerCache.left = g.left; this.containers[c].containerCache.top = g.top; this.containers[c].containerCache.width = this.containers[c].element.outerWidth(); this.containers[c].containerCache.height = this.containers[c].element.outerHeight() } return this
                }, _createPlaceholder: function(d) {
                    var c = d || this, f = c.options; if (!f.placeholder || f.placeholder.constructor == String) {
                        var g = f.placeholder; f.placeholder = { element: function() {
                            var e =
a(document.createElement(c.currentItem[0].nodeName)).addClass(g || c.currentItem[0].className + " ui-sortable-placeholder").removeClass("ui-sortable-helper")[0]; if (!g) e.style.visibility = "hidden"; return e
                        }, update: function(e, i) {
                            if (!(g && !f.forcePlaceholderSize)) {
                                i.height() || i.height(c.currentItem.innerHeight() - parseInt(c.currentItem.css("paddingTop") || 0, 10) - parseInt(c.currentItem.css("paddingBottom") || 0, 10)); i.width() || i.width(c.currentItem.innerWidth() - parseInt(c.currentItem.css("paddingLeft") || 0, 10) - parseInt(c.currentItem.css("paddingRight") ||
0, 10))
                            } 
                        } }
                        } c.placeholder = a(f.placeholder.element.call(c.element, c.currentItem)); c.currentItem.after(c.placeholder); f.placeholder.update(c, c.placeholder)
                    }, _contactContainers: function(d) {
                        for (var c = null, f = null, g = this.containers.length - 1; g >= 0; g--) if (!a.ui.contains(this.currentItem[0], this.containers[g].element[0])) if (this._intersectsWith(this.containers[g].containerCache)) { if (!(c && a.ui.contains(this.containers[g].element[0], c.element[0]))) { c = this.containers[g]; f = g } } else if (this.containers[g].containerCache.over) {
                            this.containers[g]._trigger("out",
d, this._uiHash(this)); this.containers[g].containerCache.over = 0
                        } if (c) if (this.containers.length === 1) { this.containers[f]._trigger("over", d, this._uiHash(this)); this.containers[f].containerCache.over = 1 } else if (this.currentContainer != this.containers[f]) {
                            c = 1E4; g = null; for (var e = this.positionAbs[this.containers[f].floating ? "left" : "top"], i = this.items.length - 1; i >= 0; i--) if (a.ui.contains(this.containers[f].element[0], this.items[i].item[0])) {
                                var b = this.items[i][this.containers[f].floating ? "left" : "top"]; if (Math.abs(b -
e) < c) { c = Math.abs(b - e); g = this.items[i] } 
                            } if (g || this.options.dropOnEmpty) { this.currentContainer = this.containers[f]; g ? this._rearrange(d, g, null, true) : this._rearrange(d, null, this.containers[f].element, true); this._trigger("change", d, this._uiHash()); this.containers[f]._trigger("change", d, this._uiHash(this)); this.options.placeholder.update(this.currentContainer, this.placeholder); this.containers[f]._trigger("over", d, this._uiHash(this)); this.containers[f].containerCache.over = 1 } 
                        } 
                    }, _createHelper: function(d) {
                        var c =
this.options; d = a.isFunction(c.helper) ? a(c.helper.apply(this.element[0], [d, this.currentItem])) : c.helper == "clone" ? this.currentItem.clone() : this.currentItem; d.parents("body").length || a(c.appendTo != "parent" ? c.appendTo : this.currentItem[0].parentNode)[0].appendChild(d[0]); if (d[0] == this.currentItem[0]) this._storedCSS = { width: this.currentItem[0].style.width, height: this.currentItem[0].style.height, position: this.currentItem.css("position"), top: this.currentItem.css("top"), left: this.currentItem.css("left") }; if (d[0].style.width ==
"" || c.forceHelperSize) d.width(this.currentItem.width()); if (d[0].style.height == "" || c.forceHelperSize) d.height(this.currentItem.height()); return d
                    }, _adjustOffsetFromHelper: function(d) {
                        if (typeof d == "string") d = d.split(" "); if (a.isArray(d)) d = { left: +d[0], top: +d[1] || 0 }; if ("left" in d) this.offset.click.left = d.left + this.margins.left; if ("right" in d) this.offset.click.left = this.helperProportions.width - d.right + this.margins.left; if ("top" in d) this.offset.click.top = d.top + this.margins.top; if ("bottom" in d) this.offset.click.top =
this.helperProportions.height - d.bottom + this.margins.top
                    }, _getParentOffset: function() {
                        this.offsetParent = this.helper.offsetParent(); var d = this.offsetParent.offset(); if (this.cssPosition == "absolute" && this.scrollParent[0] != document && a.ui.contains(this.scrollParent[0], this.offsetParent[0])) { d.left += this.scrollParent.scrollLeft(); d.top += this.scrollParent.scrollTop() } if (this.offsetParent[0] == document.body || this.offsetParent[0].tagName && this.offsetParent[0].tagName.toLowerCase() == "html" && a.browser.msie) d =
{ top: 0, left: 0 }; return { top: d.top + (parseInt(this.offsetParent.css("borderTopWidth"), 10) || 0), left: d.left + (parseInt(this.offsetParent.css("borderLeftWidth"), 10) || 0)}
                    }, _getRelativeOffset: function() { if (this.cssPosition == "relative") { var d = this.currentItem.position(); return { top: d.top - (parseInt(this.helper.css("top"), 10) || 0) + this.scrollParent.scrollTop(), left: d.left - (parseInt(this.helper.css("left"), 10) || 0) + this.scrollParent.scrollLeft()} } else return { top: 0, left: 0} }, _cacheMargins: function() {
                        this.margins = { left: parseInt(this.currentItem.css("marginLeft"),
10) || 0, top: parseInt(this.currentItem.css("marginTop"), 10) || 0}
                        }, _cacheHelperProportions: function() { this.helperProportions = { width: this.helper.outerWidth(), height: this.helper.outerHeight()} }, _setContainment: function() {
                            var d = this.options; if (d.containment == "parent") d.containment = this.helper[0].parentNode; if (d.containment == "document" || d.containment == "window") this.containment = [0 - this.offset.relative.left - this.offset.parent.left, 0 - this.offset.relative.top - this.offset.parent.top, a(d.containment == "document" ?
document : window).width() - this.helperProportions.width - this.margins.left, (a(d.containment == "document" ? document : window).height() || document.body.parentNode.scrollHeight) - this.helperProportions.height - this.margins.top]; if (!/^(document|window|parent)$/.test(d.containment)) {
                                var c = a(d.containment)[0]; d = a(d.containment).offset(); var f = a(c).css("overflow") != "hidden"; this.containment = [d.left + (parseInt(a(c).css("borderLeftWidth"), 10) || 0) + (parseInt(a(c).css("paddingLeft"), 10) || 0) - this.margins.left, d.top + (parseInt(a(c).css("borderTopWidth"),
10) || 0) + (parseInt(a(c).css("paddingTop"), 10) || 0) - this.margins.top, d.left + (f ? Math.max(c.scrollWidth, c.offsetWidth) : c.offsetWidth) - (parseInt(a(c).css("borderLeftWidth"), 10) || 0) - (parseInt(a(c).css("paddingRight"), 10) || 0) - this.helperProportions.width - this.margins.left, d.top + (f ? Math.max(c.scrollHeight, c.offsetHeight) : c.offsetHeight) - (parseInt(a(c).css("borderTopWidth"), 10) || 0) - (parseInt(a(c).css("paddingBottom"), 10) || 0) - this.helperProportions.height - this.margins.top]
                            } 
                        }, _convertPositionTo: function(d, c) {
                            if (!c) c =
this.position; d = d == "absolute" ? 1 : -1; var f = this.cssPosition == "absolute" && !(this.scrollParent[0] != document && a.ui.contains(this.scrollParent[0], this.offsetParent[0])) ? this.offsetParent : this.scrollParent, g = /(html|body)/i.test(f[0].tagName); return { top: c.top + this.offset.relative.top * d + this.offset.parent.top * d - (a.browser.safari && this.cssPosition == "fixed" ? 0 : (this.cssPosition == "fixed" ? -this.scrollParent.scrollTop() : g ? 0 : f.scrollTop()) * d), left: c.left + this.offset.relative.left * d + this.offset.parent.left * d - (a.browser.safari &&
this.cssPosition == "fixed" ? 0 : (this.cssPosition == "fixed" ? -this.scrollParent.scrollLeft() : g ? 0 : f.scrollLeft()) * d)}
                        }, _generatePosition: function(d) {
                            var c = this.options, f = this.cssPosition == "absolute" && !(this.scrollParent[0] != document && a.ui.contains(this.scrollParent[0], this.offsetParent[0])) ? this.offsetParent : this.scrollParent, g = /(html|body)/i.test(f[0].tagName); if (this.cssPosition == "relative" && !(this.scrollParent[0] != document && this.scrollParent[0] != this.offsetParent[0])) this.offset.relative = this._getRelativeOffset();
                            var e = d.pageX, i = d.pageY; if (this.originalPosition) {
                                if (this.containment) { if (d.pageX - this.offset.click.left < this.containment[0]) e = this.containment[0] + this.offset.click.left; if (d.pageY - this.offset.click.top < this.containment[1]) i = this.containment[1] + this.offset.click.top; if (d.pageX - this.offset.click.left > this.containment[2]) e = this.containment[2] + this.offset.click.left; if (d.pageY - this.offset.click.top > this.containment[3]) i = this.containment[3] + this.offset.click.top } if (c.grid) {
                                    i = this.originalPageY + Math.round((i -
this.originalPageY) / c.grid[1]) * c.grid[1]; i = this.containment ? !(i - this.offset.click.top < this.containment[1] || i - this.offset.click.top > this.containment[3]) ? i : !(i - this.offset.click.top < this.containment[1]) ? i - c.grid[1] : i + c.grid[1] : i; e = this.originalPageX + Math.round((e - this.originalPageX) / c.grid[0]) * c.grid[0]; e = this.containment ? !(e - this.offset.click.left < this.containment[0] || e - this.offset.click.left > this.containment[2]) ? e : !(e - this.offset.click.left < this.containment[0]) ? e - c.grid[0] : e + c.grid[0] : e
                                } 
                            } return { top: i -
this.offset.click.top - this.offset.relative.top - this.offset.parent.top + (a.browser.safari && this.cssPosition == "fixed" ? 0 : this.cssPosition == "fixed" ? -this.scrollParent.scrollTop() : g ? 0 : f.scrollTop()), left: e - this.offset.click.left - this.offset.relative.left - this.offset.parent.left + (a.browser.safari && this.cssPosition == "fixed" ? 0 : this.cssPosition == "fixed" ? -this.scrollParent.scrollLeft() : g ? 0 : f.scrollLeft())}
                            }, _rearrange: function(d, c, f, g) {
                                f ? f[0].appendChild(this.placeholder[0]) : c.item[0].parentNode.insertBefore(this.placeholder[0],
this.direction == "down" ? c.item[0] : c.item[0].nextSibling); this.counter = this.counter ? ++this.counter : 1; var e = this, i = this.counter; window.setTimeout(function() { i == e.counter && e.refreshPositions(!g) }, 0)
                            }, _clear: function(d, c) {
                                this.reverting = false; var f = []; !this._noFinalSort && this.currentItem[0].parentNode && this.placeholder.before(this.currentItem); this._noFinalSort = null; if (this.helper[0] == this.currentItem[0]) {
                                    for (var g in this._storedCSS) if (this._storedCSS[g] == "auto" || this._storedCSS[g] == "static") this._storedCSS[g] =
""; this.currentItem.css(this._storedCSS).removeClass("ui-sortable-helper")
                                } else this.currentItem.show(); this.fromOutside && !c && f.push(function(e) { this._trigger("receive", e, this._uiHash(this.fromOutside)) }); if ((this.fromOutside || this.domPosition.prev != this.currentItem.prev().not(".ui-sortable-helper")[0] || this.domPosition.parent != this.currentItem.parent()[0]) && !c) f.push(function(e) { this._trigger("update", e, this._uiHash()) }); if (!a.ui.contains(this.element[0], this.currentItem[0])) {
                                    c || f.push(function(e) {
                                        this._trigger("remove",
e, this._uiHash())
                                    }); for (g = this.containers.length - 1; g >= 0; g--) if (a.ui.contains(this.containers[g].element[0], this.currentItem[0]) && !c) { f.push(function(e) { return function(i) { e._trigger("receive", i, this._uiHash(this)) } } .call(this, this.containers[g])); f.push(function(e) { return function(i) { e._trigger("update", i, this._uiHash(this)) } } .call(this, this.containers[g])) } 
                                } for (g = this.containers.length - 1; g >= 0; g--) {
                                    c || f.push(function(e) { return function(i) { e._trigger("deactivate", i, this._uiHash(this)) } } .call(this,
this.containers[g])); if (this.containers[g].containerCache.over) { f.push(function(e) { return function(i) { e._trigger("out", i, this._uiHash(this)) } } .call(this, this.containers[g])); this.containers[g].containerCache.over = 0 } 
                                } this._storedCursor && a("body").css("cursor", this._storedCursor); this._storedOpacity && this.helper.css("opacity", this._storedOpacity); if (this._storedZIndex) this.helper.css("zIndex", this._storedZIndex == "auto" ? "" : this._storedZIndex); this.dragging = false; if (this.cancelHelperRemoval) {
                                    if (!c) {
                                        this._trigger("beforeStop",
d, this._uiHash()); for (g = 0; g < f.length; g++) f[g].call(this, d); this._trigger("stop", d, this._uiHash())
                                    } return false
                                } c || this._trigger("beforeStop", d, this._uiHash()); this.placeholder[0].parentNode.removeChild(this.placeholder[0]); this.helper[0] != this.currentItem[0] && this.helper.remove(); this.helper = null; if (!c) { for (g = 0; g < f.length; g++) f[g].call(this, d); this._trigger("stop", d, this._uiHash()) } this.fromOutside = false; return true
                            }, _trigger: function() { a.Widget.prototype._trigger.apply(this, arguments) === false && this.cancel() },
                            _uiHash: function(d) { var c = d || this; return { helper: c.helper, placeholder: c.placeholder || a([]), position: c.position, originalPosition: c.originalPosition, offset: c.positionAbs, item: c.currentItem, sender: d ? d.element : null} } 
                        }); a.extend(a.ui.sortable, { version: "1.8.13" })
                    })(jQuery);
                    jQuery.effects || function(a, d) {
                        function c(n) {
                            var k; if (n && n.constructor == Array && n.length == 3) return n; if (k = /rgb\(\s*([0-9]{1,3})\s*,\s*([0-9]{1,3})\s*,\s*([0-9]{1,3})\s*\)/.exec(n)) return [parseInt(k[1], 10), parseInt(k[2], 10), parseInt(k[3], 10)]; if (k = /rgb\(\s*([0-9]+(?:\.[0-9]+)?)\%\s*,\s*([0-9]+(?:\.[0-9]+)?)\%\s*,\s*([0-9]+(?:\.[0-9]+)?)\%\s*\)/.exec(n)) return [parseFloat(k[1]) * 2.55, parseFloat(k[2]) * 2.55, parseFloat(k[3]) * 2.55]; if (k = /#([a-fA-F0-9]{2})([a-fA-F0-9]{2})([a-fA-F0-9]{2})/.exec(n)) return [parseInt(k[1],
16), parseInt(k[2], 16), parseInt(k[3], 16)]; if (k = /#([a-fA-F0-9])([a-fA-F0-9])([a-fA-F0-9])/.exec(n)) return [parseInt(k[1] + k[1], 16), parseInt(k[2] + k[2], 16), parseInt(k[3] + k[3], 16)]; if (/rgba\(0, 0, 0, 0\)/.exec(n)) return j.transparent; return j[a.trim(n).toLowerCase()]
                        } function f(n, k) { var m; do { m = a.curCSS(n, k); if (m != "" && m != "transparent" || a.nodeName(n, "body")) break; k = "backgroundColor" } while (n = n.parentNode); return c(m) } function g() {
                            var n = document.defaultView ? document.defaultView.getComputedStyle(this, null) : this.currentStyle,
k = {}, m, p; if (n && n.length && n[0] && n[n[0]]) for (var q = n.length; q--; ) { m = n[q]; if (typeof n[m] == "string") { p = m.replace(/\-(\w)/g, function(s, r) { return r.toUpperCase() }); k[p] = n[m] } } else for (m in n) if (typeof n[m] === "string") k[m] = n[m]; return k
                        } function e(n) { var k, m; for (k in n) { m = n[k]; if (m == null || a.isFunction(m) || k in o || /scrollbar/.test(k) || !/color/i.test(k) && isNaN(parseFloat(m))) delete n[k] } return n } function i(n, k) { var m = { _: 0 }, p; for (p in k) if (n[p] != k[p]) m[p] = k[p]; return m } function b(n, k, m, p) {
                            if (typeof n == "object") {
                                p =
k; m = null; k = n; n = k.effect
                            } if (a.isFunction(k)) { p = k; m = null; k = {} } if (typeof k == "number" || a.fx.speeds[k]) { p = m; m = k; k = {} } if (a.isFunction(m)) { p = m; m = null } k = k || {}; m = m || k.duration; m = a.fx.off ? 0 : typeof m == "number" ? m : m in a.fx.speeds ? a.fx.speeds[m] : a.fx.speeds._default; p = p || k.complete; return [n, k, m, p]
                        } function h(n) { if (!n || typeof n === "number" || a.fx.speeds[n]) return true; if (typeof n === "string" && !a.effects[n]) return true; return false } a.effects = {}; a.each(["backgroundColor", "borderBottomColor", "borderLeftColor", "borderRightColor",
"borderTopColor", "borderColor", "color", "outlineColor"], function(n, k) { a.fx.step[k] = function(m) { if (!m.colorInit) { m.start = f(m.elem, k); m.end = c(m.end); m.colorInit = true } m.elem.style[k] = "rgb(" + Math.max(Math.min(parseInt(m.pos * (m.end[0] - m.start[0]) + m.start[0], 10), 255), 0) + "," + Math.max(Math.min(parseInt(m.pos * (m.end[1] - m.start[1]) + m.start[1], 10), 255), 0) + "," + Math.max(Math.min(parseInt(m.pos * (m.end[2] - m.start[2]) + m.start[2], 10), 255), 0) + ")" } }); var j = { aqua: [0, 255, 255], azure: [240, 255, 255], beige: [245, 245, 220], black: [0,
0, 0], blue: [0, 0, 255], brown: [165, 42, 42], cyan: [0, 255, 255], darkblue: [0, 0, 139], darkcyan: [0, 139, 139], darkgrey: [169, 169, 169], darkgreen: [0, 100, 0], darkkhaki: [189, 183, 107], darkmagenta: [139, 0, 139], darkolivegreen: [85, 107, 47], darkorange: [255, 140, 0], darkorchid: [153, 50, 204], darkred: [139, 0, 0], darksalmon: [233, 150, 122], darkviolet: [148, 0, 211], fuchsia: [255, 0, 255], gold: [255, 215, 0], green: [0, 128, 0], indigo: [75, 0, 130], khaki: [240, 230, 140], lightblue: [173, 216, 230], lightcyan: [224, 255, 255], lightgreen: [144, 238, 144], lightgrey: [211,
211, 211], lightpink: [255, 182, 193], lightyellow: [255, 255, 224], lime: [0, 255, 0], magenta: [255, 0, 255], maroon: [128, 0, 0], navy: [0, 0, 128], olive: [128, 128, 0], orange: [255, 165, 0], pink: [255, 192, 203], purple: [128, 0, 128], violet: [128, 0, 128], red: [255, 0, 0], silver: [192, 192, 192], white: [255, 255, 255], yellow: [255, 255, 0], transparent: [255, 255, 255]
}, l = ["add", "remove", "toggle"], o = { border: 1, borderBottom: 1, borderColor: 1, borderLeft: 1, borderRight: 1, borderTop: 1, borderWidth: 1, margin: 1, padding: 1 }; a.effects.animateClass = function(n, k, m,
p) { if (a.isFunction(m)) { p = m; m = null } return this.queue(function() { var q = a(this), s = q.attr("style") || " ", r = e(g.call(this)), u, v = q.attr("class"); a.each(l, function(w, x) { n[x] && q[x + "Class"](n[x]) }); u = e(g.call(this)); q.attr("class", v); q.animate(i(r, u), { queue: false, duration: k, easding: m, complete: function() { a.each(l, function(w, x) { n[x] && q[x + "Class"](n[x]) }); if (typeof q.attr("style") == "object") { q.attr("style").cssText = ""; q.attr("style").cssText = s } else q.attr("style", s); p && p.apply(this, arguments); a.dequeue(this) } }) }) };
                        a.fn.extend({ _addClass: a.fn.addClass, addClass: function(n, k, m, p) { return k ? a.effects.animateClass.apply(this, [{ add: n }, k, m, p]) : this._addClass(n) }, _removeClass: a.fn.removeClass, removeClass: function(n, k, m, p) { return k ? a.effects.animateClass.apply(this, [{ remove: n }, k, m, p]) : this._removeClass(n) }, _toggleClass: a.fn.toggleClass, toggleClass: function(n, k, m, p, q) {
                            return typeof k == "boolean" || k === d ? m ? a.effects.animateClass.apply(this, [k ? { add: n} : { remove: n }, m, p, q]) : this._toggleClass(n, k) : a.effects.animateClass.apply(this,
[{ toggle: n }, k, m, p])
                        }, switchClass: function(n, k, m, p, q) { return a.effects.animateClass.apply(this, [{ add: k, remove: n }, m, p, q]) } 
                        }); a.extend(a.effects, { version: "1.8.13", save: function(n, k) { for (var m = 0; m < k.length; m++) k[m] !== null && n.data("ec.storage." + k[m], n[0].style[k[m]]) }, restore: function(n, k) { for (var m = 0; m < k.length; m++) k[m] !== null && n.css(k[m], n.data("ec.storage." + k[m])) }, setMode: function(n, k) { if (k == "toggle") k = n.is(":hidden") ? "show" : "hide"; return k }, getBaseline: function(n, k) {
                            var m; switch (n[0]) {
                                case "top": m =
0; break; case "middle": m = 0.5; break; case "bottom": m = 1; break; default: m = n[0] / k.height
                            } switch (n[1]) { case "left": n = 0; break; case "center": n = 0.5; break; case "right": n = 1; break; default: n = n[1] / k.width } return { x: n, y: m}
                        }, createWrapper: function(n) {
                            if (n.parent().is(".ui-effects-wrapper")) return n.parent(); var k = { width: n.outerWidth(true), height: n.outerHeight(true), "float": n.css("float") }, m = a("<div></div>").addClass("ui-effects-wrapper").css({ fontSize: "100%", background: "transparent", border: "none", margin: 0, padding: 0 });
                            n.wrap(m); m = n.parent(); if (n.css("position") == "static") { m.css({ position: "relative" }); n.css({ position: "relative" }) } else { a.extend(k, { position: n.css("position"), zIndex: n.css("z-index") }); a.each(["top", "left", "bottom", "right"], function(p, q) { k[q] = n.css(q); if (isNaN(parseInt(k[q], 10))) k[q] = "auto" }); n.css({ position: "relative", top: 0, left: 0, right: "auto", bottom: "auto" }) } return m.css(k).show()
                        }, removeWrapper: function(n) { if (n.parent().is(".ui-effects-wrapper")) return n.parent().replaceWith(n); return n }, setTransition: function(n,
k, m, p) { p = p || {}; a.each(k, function(q, s) { unit = n.cssUnit(s); if (unit[0] > 0) p[s] = unit[0] * m + unit[1] }); return p } 
                        }); a.fn.extend({ effect: function(n) { var k = b.apply(this, arguments), m = { options: k[1], duration: k[2], callback: k[3] }; k = m.options.mode; var p = a.effects[n]; if (a.fx.off || !p) return k ? this[k](m.duration, m.callback) : this.each(function() { m.callback && m.callback.call(this) }); return p.call(this, m) }, _show: a.fn.show, show: function(n) {
                            if (h(n)) return this._show.apply(this, arguments); else {
                                var k = b.apply(this, arguments);
                                k[1].mode = "show"; return this.effect.apply(this, k)
                            } 
                        }, _hide: a.fn.hide, hide: function(n) { if (h(n)) return this._hide.apply(this, arguments); else { var k = b.apply(this, arguments); k[1].mode = "hide"; return this.effect.apply(this, k) } }, __toggle: a.fn.toggle, toggle: function(n) { if (h(n) || typeof n === "boolean" || a.isFunction(n)) return this.__toggle.apply(this, arguments); else { var k = b.apply(this, arguments); k[1].mode = "toggle"; return this.effect.apply(this, k) } }, cssUnit: function(n) {
                            var k = this.css(n), m = []; a.each(["em", "px", "%",
"pt"], function(p, q) { if (k.indexOf(q) > 0) m = [parseFloat(k), q] }); return m
                        } 
                        }); a.easing.jswing = a.easing.swing; a.extend(a.easing, { def: "easeOutQuad", swing: function(n, k, m, p, q) { return a.easing[a.easing.def](n, k, m, p, q) }, easeInQuad: function(n, k, m, p, q) { return p * (k /= q) * k + m }, easeOutQuad: function(n, k, m, p, q) { return -p * (k /= q) * (k - 2) + m }, easeInOutQuad: function(n, k, m, p, q) { if ((k /= q / 2) < 1) return p / 2 * k * k + m; return -p / 2 * (--k * (k - 2) - 1) + m }, easeInCubic: function(n, k, m, p, q) { return p * (k /= q) * k * k + m }, easeOutCubic: function(n, k, m, p, q) {
                            return p *
((k = k / q - 1) * k * k + 1) + m
                        }, easeInOutCubic: function(n, k, m, p, q) { if ((k /= q / 2) < 1) return p / 2 * k * k * k + m; return p / 2 * ((k -= 2) * k * k + 2) + m }, easeInQuart: function(n, k, m, p, q) { return p * (k /= q) * k * k * k + m }, easeOutQuart: function(n, k, m, p, q) { return -p * ((k = k / q - 1) * k * k * k - 1) + m }, easeInOutQuart: function(n, k, m, p, q) { if ((k /= q / 2) < 1) return p / 2 * k * k * k * k + m; return -p / 2 * ((k -= 2) * k * k * k - 2) + m }, easeInQuint: function(n, k, m, p, q) { return p * (k /= q) * k * k * k * k + m }, easeOutQuint: function(n, k, m, p, q) { return p * ((k = k / q - 1) * k * k * k * k + 1) + m }, easeInOutQuint: function(n, k, m, p, q) {
                            if ((k /=
q / 2) < 1) return p / 2 * k * k * k * k * k + m; return p / 2 * ((k -= 2) * k * k * k * k + 2) + m
                        }, easeInSine: function(n, k, m, p, q) { return -p * Math.cos(k / q * (Math.PI / 2)) + p + m }, easeOutSine: function(n, k, m, p, q) { return p * Math.sin(k / q * (Math.PI / 2)) + m }, easeInOutSine: function(n, k, m, p, q) { return -p / 2 * (Math.cos(Math.PI * k / q) - 1) + m }, easeInExpo: function(n, k, m, p, q) { return k == 0 ? m : p * Math.pow(2, 10 * (k / q - 1)) + m }, easeOutExpo: function(n, k, m, p, q) { return k == q ? m + p : p * (-Math.pow(2, -10 * k / q) + 1) + m }, easeInOutExpo: function(n, k, m, p, q) {
                            if (k == 0) return m; if (k == q) return m + p; if ((k /=
q / 2) < 1) return p / 2 * Math.pow(2, 10 * (k - 1)) + m; return p / 2 * (-Math.pow(2, -10 * --k) + 2) + m
                        }, easeInCirc: function(n, k, m, p, q) { return -p * (Math.sqrt(1 - (k /= q) * k) - 1) + m }, easeOutCirc: function(n, k, m, p, q) { return p * Math.sqrt(1 - (k = k / q - 1) * k) + m }, easeInOutCirc: function(n, k, m, p, q) { if ((k /= q / 2) < 1) return -p / 2 * (Math.sqrt(1 - k * k) - 1) + m; return p / 2 * (Math.sqrt(1 - (k -= 2) * k) + 1) + m }, easeInElastic: function(n, k, m, p, q) {
                            n = 1.70158; var s = 0, r = p; if (k == 0) return m; if ((k /= q) == 1) return m + p; s || (s = q * 0.3); if (r < Math.abs(p)) { r = p; n = s / 4 } else n = s / (2 * Math.PI) * Math.asin(p /
r); return -(r * Math.pow(2, 10 * (k -= 1)) * Math.sin((k * q - n) * 2 * Math.PI / s)) + m
                        }, easeOutElastic: function(n, k, m, p, q) { n = 1.70158; var s = 0, r = p; if (k == 0) return m; if ((k /= q) == 1) return m + p; s || (s = q * 0.3); if (r < Math.abs(p)) { r = p; n = s / 4 } else n = s / (2 * Math.PI) * Math.asin(p / r); return r * Math.pow(2, -10 * k) * Math.sin((k * q - n) * 2 * Math.PI / s) + p + m }, easeInOutElastic: function(n, k, m, p, q) {
                            n = 1.70158; var s = 0, r = p; if (k == 0) return m; if ((k /= q / 2) == 2) return m + p; s || (s = q * 0.3 * 1.5); if (r < Math.abs(p)) { r = p; n = s / 4 } else n = s / (2 * Math.PI) * Math.asin(p / r); if (k < 1) return -0.5 *
r * Math.pow(2, 10 * (k -= 1)) * Math.sin((k * q - n) * 2 * Math.PI / s) + m; return r * Math.pow(2, -10 * (k -= 1)) * Math.sin((k * q - n) * 2 * Math.PI / s) * 0.5 + p + m
                        }, easeInBack: function(n, k, m, p, q, s) { if (s == d) s = 1.70158; return p * (k /= q) * k * ((s + 1) * k - s) + m }, easeOutBack: function(n, k, m, p, q, s) { if (s == d) s = 1.70158; return p * ((k = k / q - 1) * k * ((s + 1) * k + s) + 1) + m }, easeInOutBack: function(n, k, m, p, q, s) { if (s == d) s = 1.70158; if ((k /= q / 2) < 1) return p / 2 * k * k * (((s *= 1.525) + 1) * k - s) + m; return p / 2 * ((k -= 2) * k * (((s *= 1.525) + 1) * k + s) + 2) + m }, easeInBounce: function(n, k, m, p, q) {
                            return p - a.easing.easeOutBounce(n,
q - k, 0, p, q) + m
                        }, easeOutBounce: function(n, k, m, p, q) { return (k /= q) < 1 / 2.75 ? p * 7.5625 * k * k + m : k < 2 / 2.75 ? p * (7.5625 * (k -= 1.5 / 2.75) * k + 0.75) + m : k < 2.5 / 2.75 ? p * (7.5625 * (k -= 2.25 / 2.75) * k + 0.9375) + m : p * (7.5625 * (k -= 2.625 / 2.75) * k + 0.984375) + m }, easeInOutBounce: function(n, k, m, p, q) { if (k < q / 2) return a.easing.easeInBounce(n, k * 2, 0, p, q) * 0.5 + m; return a.easing.easeOutBounce(n, k * 2 - q, 0, p, q) * 0.5 + p * 0.5 + m } 
                        })
                    } (jQuery);
                    (function(a) {
                        a.effects.blind = function(d) {
                            return this.queue(function() {
                                var c = a(this), f = ["position", "top", "bottom", "left", "right"], g = a.effects.setMode(c, d.options.mode || "hide"), e = d.options.direction || "vertical"; a.effects.save(c, f); c.show(); var i = a.effects.createWrapper(c).css({ overflow: "hidden" }), b = e == "vertical" ? "height" : "width"; e = e == "vertical" ? i.height() : i.width(); g == "show" && i.css(b, 0); var h = {}; h[b] = g == "show" ? e : 0; i.animate(h, d.duration, d.options.easing, function() {
                                    g == "hide" && c.hide(); a.effects.restore(c,
f); a.effects.removeWrapper(c); d.callback && d.callback.apply(c[0], arguments); c.dequeue()
                                })
                            })
                        } 
                    })(jQuery);
                    (function(a) {
                        a.effects.bounce = function(d) {
                            return this.queue(function() {
                                var c = a(this), f = ["position", "top", "bottom", "left", "right"], g = a.effects.setMode(c, d.options.mode || "effect"), e = d.options.direction || "up", i = d.options.distance || 20, b = d.options.times || 5, h = d.duration || 250; /show|hide/.test(g) && f.push("opacity"); a.effects.save(c, f); c.show(); a.effects.createWrapper(c); var j = e == "up" || e == "down" ? "top" : "left"; e = e == "up" || e == "left" ? "pos" : "neg"; i = d.options.distance || (j == "top" ? c.outerHeight({ margin: true }) / 3 : c.outerWidth({ margin: true }) /
3); if (g == "show") c.css("opacity", 0).css(j, e == "pos" ? -i : i); if (g == "hide") i /= b * 2; g != "hide" && b--; if (g == "show") { var l = { opacity: 1 }; l[j] = (e == "pos" ? "+=" : "-=") + i; c.animate(l, h / 2, d.options.easing); i /= 2; b-- } for (l = 0; l < b; l++) { var o = {}, n = {}; o[j] = (e == "pos" ? "-=" : "+=") + i; n[j] = (e == "pos" ? "+=" : "-=") + i; c.animate(o, h / 2, d.options.easing).animate(n, h / 2, d.options.easing); i = g == "hide" ? i * 2 : i / 2 } if (g == "hide") {
                                    l = { opacity: 0 }; l[j] = (e == "pos" ? "-=" : "+=") + i; c.animate(l, h / 2, d.options.easing, function() {
                                        c.hide(); a.effects.restore(c, f); a.effects.removeWrapper(c);
                                        d.callback && d.callback.apply(this, arguments)
                                    })
                                } else { o = {}; n = {}; o[j] = (e == "pos" ? "-=" : "+=") + i; n[j] = (e == "pos" ? "+=" : "-=") + i; c.animate(o, h / 2, d.options.easing).animate(n, h / 2, d.options.easing, function() { a.effects.restore(c, f); a.effects.removeWrapper(c); d.callback && d.callback.apply(this, arguments) }) } c.queue("fx", function() { c.dequeue() }); c.dequeue()
                            })
                        } 
                    })(jQuery);
                    (function(a) {
                        a.effects.clip = function(d) {
                            return this.queue(function() {
                                var c = a(this), f = ["position", "top", "bottom", "left", "right", "height", "width"], g = a.effects.setMode(c, d.options.mode || "hide"), e = d.options.direction || "vertical"; a.effects.save(c, f); c.show(); var i = a.effects.createWrapper(c).css({ overflow: "hidden" }); i = c[0].tagName == "IMG" ? i : c; var b = { size: e == "vertical" ? "height" : "width", position: e == "vertical" ? "top" : "left" }; e = e == "vertical" ? i.height() : i.width(); if (g == "show") {
                                    i.css(b.size, 0); i.css(b.position,
e / 2)
                                } var h = {}; h[b.size] = g == "show" ? e : 0; h[b.position] = g == "show" ? 0 : e / 2; i.animate(h, { queue: false, duration: d.duration, easing: d.options.easing, complete: function() { g == "hide" && c.hide(); a.effects.restore(c, f); a.effects.removeWrapper(c); d.callback && d.callback.apply(c[0], arguments); c.dequeue() } })
                            })
                        } 
                    })(jQuery);
                    (function(a) {
                        a.effects.drop = function(d) {
                            return this.queue(function() {
                                var c = a(this), f = ["position", "top", "bottom", "left", "right", "opacity"], g = a.effects.setMode(c, d.options.mode || "hide"), e = d.options.direction || "left"; a.effects.save(c, f); c.show(); a.effects.createWrapper(c); var i = e == "up" || e == "down" ? "top" : "left"; e = e == "up" || e == "left" ? "pos" : "neg"; var b = d.options.distance || (i == "top" ? c.outerHeight({ margin: true }) / 2 : c.outerWidth({ margin: true }) / 2); if (g == "show") c.css("opacity", 0).css(i, e == "pos" ? -b : b); var h = { opacity: g ==
"show" ? 1 : 0
                                }; h[i] = (g == "show" ? e == "pos" ? "+=" : "-=" : e == "pos" ? "-=" : "+=") + b; c.animate(h, { queue: false, duration: d.duration, easing: d.options.easing, complete: function() { g == "hide" && c.hide(); a.effects.restore(c, f); a.effects.removeWrapper(c); d.callback && d.callback.apply(this, arguments); c.dequeue() } })
                            })
                        } 
                    })(jQuery);
                    (function(a) {
                        a.effects.explode = function(d) {
                            return this.queue(function() {
                                var c = d.options.pieces ? Math.round(Math.sqrt(d.options.pieces)) : 3, f = d.options.pieces ? Math.round(Math.sqrt(d.options.pieces)) : 3; d.options.mode = d.options.mode == "toggle" ? a(this).is(":visible") ? "hide" : "show" : d.options.mode; var g = a(this).show().css("visibility", "hidden"), e = g.offset(); e.top -= parseInt(g.css("marginTop"), 10) || 0; e.left -= parseInt(g.css("marginLeft"), 10) || 0; for (var i = g.outerWidth(true), b = g.outerHeight(true), h = 0; h < c; h++) for (var j =
0; j < f; j++) g.clone().appendTo("body").wrap("<div></div>").css({ position: "absolute", visibility: "visible", left: -j * (i / f), top: -h * (b / c) }).parent().addClass("ui-effects-explode").css({ position: "absolute", overflow: "hidden", width: i / f, height: b / c, left: e.left + j * (i / f) + (d.options.mode == "show" ? (j - Math.floor(f / 2)) * (i / f) : 0), top: e.top + h * (b / c) + (d.options.mode == "show" ? (h - Math.floor(c / 2)) * (b / c) : 0), opacity: d.options.mode == "show" ? 0 : 1 }).animate({ left: e.left + j * (i / f) + (d.options.mode == "show" ? 0 : (j - Math.floor(f / 2)) * (i / f)), top: e.top +
h * (b / c) + (d.options.mode == "show" ? 0 : (h - Math.floor(c / 2)) * (b / c)), opacity: d.options.mode == "show" ? 1 : 0
}, d.duration || 500); setTimeout(function() { d.options.mode == "show" ? g.css({ visibility: "visible" }) : g.css({ visibility: "visible" }).hide(); d.callback && d.callback.apply(g[0]); g.dequeue(); a("div.ui-effects-explode").remove() }, d.duration || 500)
                            })
                        } 
                    })(jQuery);
                    (function(a) { a.effects.fade = function(d) { return this.queue(function() { var c = a(this), f = a.effects.setMode(c, d.options.mode || "hide"); c.animate({ opacity: f }, { queue: false, duration: d.duration, easing: d.options.easing, complete: function() { d.callback && d.callback.apply(this, arguments); c.dequeue() } }) }) } })(jQuery);
                    (function(a) {
                        a.effects.fold = function(d) {
                            return this.queue(function() {
                                var c = a(this), f = ["position", "top", "bottom", "left", "right"], g = a.effects.setMode(c, d.options.mode || "hide"), e = d.options.size || 15, i = !!d.options.horizFirst, b = d.duration ? d.duration / 2 : a.fx.speeds._default / 2; a.effects.save(c, f); c.show(); var h = a.effects.createWrapper(c).css({ overflow: "hidden" }), j = g == "show" != i, l = j ? ["width", "height"] : ["height", "width"]; j = j ? [h.width(), h.height()] : [h.height(), h.width()]; var o = /([0-9]+)%/.exec(e); if (o) e = parseInt(o[1],
10) / 100 * j[g == "hide" ? 0 : 1]; if (g == "show") h.css(i ? { height: 0, width: e} : { height: e, width: 0 }); i = {}; o = {}; i[l[0]] = g == "show" ? j[0] : e; o[l[1]] = g == "show" ? j[1] : 0; h.animate(i, b, d.options.easing).animate(o, b, d.options.easing, function() { g == "hide" && c.hide(); a.effects.restore(c, f); a.effects.removeWrapper(c); d.callback && d.callback.apply(c[0], arguments); c.dequeue() })
                            })
                        } 
                    })(jQuery);
                    (function(a) {
                        a.effects.highlight = function(d) {
                            return this.queue(function() {
                                var c = a(this), f = ["backgroundImage", "backgroundColor", "opacity"], g = a.effects.setMode(c, d.options.mode || "show"), e = { backgroundColor: c.css("backgroundColor") }; if (g == "hide") e.opacity = 0; a.effects.save(c, f); c.show().css({ backgroundImage: "none", backgroundColor: d.options.color || "#ffff99" }).animate(e, { queue: false, duration: d.duration, easing: d.options.easing, complete: function() {
                                    g == "hide" && c.hide(); a.effects.restore(c, f); g == "show" && !a.support.opacity &&
this.style.removeAttribute("filter"); d.callback && d.callback.apply(this, arguments); c.dequeue()
                                } 
                                })
                            })
                        } 
                    })(jQuery);
                    (function(a) {
                        a.effects.pulsate = function(d) {
                            return this.queue(function() {
                                var c = a(this), f = a.effects.setMode(c, d.options.mode || "show"); times = (d.options.times || 5) * 2 - 1; duration = d.duration ? d.duration / 2 : a.fx.speeds._default / 2; isVisible = c.is(":visible"); animateTo = 0; if (!isVisible) { c.css("opacity", 0).show(); animateTo = 1 } if (f == "hide" && isVisible || f == "show" && !isVisible) times--; for (f = 0; f < times; f++) { c.animate({ opacity: animateTo }, duration, d.options.easing); animateTo = (animateTo + 1) % 2 } c.animate({ opacity: animateTo }, duration,
d.options.easing, function() { animateTo == 0 && c.hide(); d.callback && d.callback.apply(this, arguments) }); c.queue("fx", function() { c.dequeue() }).dequeue()
                            })
                        } 
                    })(jQuery);
                    (function(a) {
                        a.effects.puff = function(d) { return this.queue(function() { var c = a(this), f = a.effects.setMode(c, d.options.mode || "hide"), g = parseInt(d.options.percent, 10) || 150, e = g / 100, i = { height: c.height(), width: c.width() }; a.extend(d.options, { fade: true, mode: f, percent: f == "hide" ? g : 100, from: f == "hide" ? i : { height: i.height * e, width: i.width * e} }); c.effect("scale", d.options, d.duration, d.callback); c.dequeue() }) }; a.effects.scale = function(d) {
                            return this.queue(function() {
                                var c = a(this), f = a.extend(true, {}, d.options), g = a.effects.setMode(c,
d.options.mode || "effect"), e = parseInt(d.options.percent, 10) || (parseInt(d.options.percent, 10) == 0 ? 0 : g == "hide" ? 0 : 100), i = d.options.direction || "both", b = d.options.origin; if (g != "effect") { f.origin = b || ["middle", "center"]; f.restore = true } b = { height: c.height(), width: c.width() }; c.from = d.options.from || (g == "show" ? { height: 0, width: 0} : b); e = { y: i != "horizontal" ? e / 100 : 1, x: i != "vertical" ? e / 100 : 1 }; c.to = { height: b.height * e.y, width: b.width * e.x }; if (d.options.fade) {
                                    if (g == "show") { c.from.opacity = 0; c.to.opacity = 1 } if (g == "hide") {
                                        c.from.opacity =
1; c.to.opacity = 0
                                    } 
                                } f.from = c.from; f.to = c.to; f.mode = g; c.effect("size", f, d.duration, d.callback); c.dequeue()
                            })
                        }; a.effects.size = function(d) {
                            return this.queue(function() {
                                var c = a(this), f = ["position", "top", "bottom", "left", "right", "width", "height", "overflow", "opacity"], g = ["position", "top", "bottom", "left", "right", "overflow", "opacity"], e = ["width", "height", "overflow"], i = ["fontSize"], b = ["borderTopWidth", "borderBottomWidth", "paddingTop", "paddingBottom"], h = ["borderLeftWidth", "borderRightWidth", "paddingLeft", "paddingRight"],
j = a.effects.setMode(c, d.options.mode || "effect"), l = d.options.restore || false, o = d.options.scale || "both", n = d.options.origin, k = { height: c.height(), width: c.width() }; c.from = d.options.from || k; c.to = d.options.to || k; if (n) { n = a.effects.getBaseline(n, k); c.from.top = (k.height - c.from.height) * n.y; c.from.left = (k.width - c.from.width) * n.x; c.to.top = (k.height - c.to.height) * n.y; c.to.left = (k.width - c.to.width) * n.x } var m = { from: { y: c.from.height / k.height, x: c.from.width / k.width }, to: { y: c.to.height / k.height, x: c.to.width / k.width} };
                                if (o == "box" || o == "both") { if (m.from.y != m.to.y) { f = f.concat(b); c.from = a.effects.setTransition(c, b, m.from.y, c.from); c.to = a.effects.setTransition(c, b, m.to.y, c.to) } if (m.from.x != m.to.x) { f = f.concat(h); c.from = a.effects.setTransition(c, h, m.from.x, c.from); c.to = a.effects.setTransition(c, h, m.to.x, c.to) } } if (o == "content" || o == "both") if (m.from.y != m.to.y) { f = f.concat(i); c.from = a.effects.setTransition(c, i, m.from.y, c.from); c.to = a.effects.setTransition(c, i, m.to.y, c.to) } a.effects.save(c, l ? f : g); c.show(); a.effects.createWrapper(c);
                                c.css("overflow", "hidden").css(c.from); if (o == "content" || o == "both") {
                                    b = b.concat(["marginTop", "marginBottom"]).concat(i); h = h.concat(["marginLeft", "marginRight"]); e = f.concat(b).concat(h); c.find("*[width]").each(function() {
                                        child = a(this); l && a.effects.save(child, e); var p = { height: child.height(), width: child.width() }; child.from = { height: p.height * m.from.y, width: p.width * m.from.x }; child.to = { height: p.height * m.to.y, width: p.width * m.to.x }; if (m.from.y != m.to.y) {
                                            child.from = a.effects.setTransition(child, b, m.from.y, child.from);
                                            child.to = a.effects.setTransition(child, b, m.to.y, child.to)
                                        } if (m.from.x != m.to.x) { child.from = a.effects.setTransition(child, h, m.from.x, child.from); child.to = a.effects.setTransition(child, h, m.to.x, child.to) } child.css(child.from); child.animate(child.to, d.duration, d.options.easing, function() { l && a.effects.restore(child, e) })
                                    })
                                } c.animate(c.to, { queue: false, duration: d.duration, easing: d.options.easing, complete: function() {
                                    c.to.opacity === 0 && c.css("opacity", c.from.opacity); j == "hide" && c.hide(); a.effects.restore(c,
l ? f : g); a.effects.removeWrapper(c); d.callback && d.callback.apply(this, arguments); c.dequeue()
                                } 
                                })
                            })
                        } 
                    })(jQuery);
                    (function(a) {
                        a.effects.shake = function(d) {
                            return this.queue(function() {
                                var c = a(this), f = ["position", "top", "bottom", "left", "right"]; a.effects.setMode(c, d.options.mode || "effect"); var g = d.options.direction || "left", e = d.options.distance || 20, i = d.options.times || 3, b = d.duration || d.options.duration || 140; a.effects.save(c, f); c.show(); a.effects.createWrapper(c); var h = g == "up" || g == "down" ? "top" : "left", j = g == "up" || g == "left" ? "pos" : "neg"; g = {}; var l = {}, o = {}; g[h] = (j == "pos" ? "-=" : "+=") + e; l[h] = (j == "pos" ? "+=" : "-=") + e * 2; o[h] =
(j == "pos" ? "-=" : "+=") + e * 2; c.animate(g, b, d.options.easing); for (e = 1; e < i; e++) c.animate(l, b, d.options.easing).animate(o, b, d.options.easing); c.animate(l, b, d.options.easing).animate(g, b / 2, d.options.easing, function() { a.effects.restore(c, f); a.effects.removeWrapper(c); d.callback && d.callback.apply(this, arguments) }); c.queue("fx", function() { c.dequeue() }); c.dequeue()
                            })
                        } 
                    })(jQuery);
                    (function(a) {
                        a.effects.slide = function(d) {
                            return this.queue(function() {
                                var c = a(this), f = ["position", "top", "bottom", "left", "right"], g = a.effects.setMode(c, d.options.mode || "show"), e = d.options.direction || "left"; a.effects.save(c, f); c.show(); a.effects.createWrapper(c).css({ overflow: "hidden" }); var i = e == "up" || e == "down" ? "top" : "left"; e = e == "up" || e == "left" ? "pos" : "neg"; var b = d.options.distance || (i == "top" ? c.outerHeight({ margin: true }) : c.outerWidth({ margin: true })); if (g == "show") c.css(i, e == "pos" ? isNaN(b) ? "-" + b : -b : b);
                                var h = {}; h[i] = (g == "show" ? e == "pos" ? "+=" : "-=" : e == "pos" ? "-=" : "+=") + b; c.animate(h, { queue: false, duration: d.duration, easing: d.options.easing, complete: function() { g == "hide" && c.hide(); a.effects.restore(c, f); a.effects.removeWrapper(c); d.callback && d.callback.apply(this, arguments); c.dequeue() } })
                            })
                        } 
                    })(jQuery);
                    (function(a) {
                        a.effects.transfer = function(d) {
                            return this.queue(function() {
                                var c = a(this), f = a(d.options.to), g = f.offset(); f = { top: g.top, left: g.left, height: f.innerHeight(), width: f.innerWidth() }; g = c.offset(); var e = a('<div class="ui-effects-transfer"></div>').appendTo(document.body).addClass(d.options.className).css({ top: g.top, left: g.left, height: c.innerHeight(), width: c.innerWidth(), position: "absolute" }).animate(f, d.duration, d.options.easing, function() {
                                    e.remove(); d.callback && d.callback.apply(c[0], arguments);
                                    c.dequeue()
                                })
                            })
                        } 
                    })(jQuery);
                    (function(a) {
                        a.widget("ui.accordion", { options: { active: 0, animated: "slide", autoHeight: true, clearStyle: false, collapsible: false, event: "click", fillSpace: false, header: "> li > :first-child,> :not(li):even", icons: { header: "ui-icon-triangle-1-e", headerSelected: "ui-icon-triangle-1-s" }, navigation: false, navigationFilter: function() { return this.href.toLowerCase() === location.href.toLowerCase() } }, _create: function() {
                            var d = this, c = d.options; d.running = 0; d.element.addClass("ui-accordion ui-widget ui-helper-reset").children("li").addClass("ui-accordion-li-fix"); d.headers =
d.element.find(c.header).addClass("ui-accordion-header ui-helper-reset ui-state-default ui-corner-all").bind("mouseenter.accordion", function() { c.disabled || a(this).addClass("ui-state-hover") }).bind("mouseleave.accordion", function() { c.disabled || a(this).removeClass("ui-state-hover") }).bind("focus.accordion", function() { c.disabled || a(this).addClass("ui-state-focus") }).bind("blur.accordion", function() { c.disabled || a(this).removeClass("ui-state-focus") }); d.headers.next().addClass("ui-accordion-content ui-helper-reset ui-widget-content ui-corner-bottom");
                            if (c.navigation) { var f = d.element.find("a").filter(c.navigationFilter).eq(0); if (f.length) { var g = f.closest(".ui-accordion-header"); d.active = g.length ? g : f.closest(".ui-accordion-content").prev() } } d.active = d._findActive(d.active || c.active).addClass("ui-state-default ui-state-active").toggleClass("ui-corner-all").toggleClass("ui-corner-top"); d.active.next().addClass("ui-accordion-content-active"); d._createIcons(); d.resize(); d.element.attr("role", "tablist"); d.headers.attr("role", "tab").bind("keydown.accordion",
function(e) { return d._keydown(e) }).next().attr("role", "tabpanel"); d.headers.not(d.active || "").attr({ "aria-expanded": "false", "aria-selected": "false", tabIndex: -1 }).next().hide(); d.active.length ? d.active.attr({ "aria-expanded": "true", "aria-selected": "true", tabIndex: 0 }) : d.headers.eq(0).attr("tabIndex", 0); a.browser.safari || d.headers.find("a").attr("tabIndex", -1); c.event && d.headers.bind(c.event.split(" ").join(".accordion ") + ".accordion", function(e) { d._clickHandler.call(d, e, this); e.preventDefault() })
                        }, _createIcons: function() {
                            var d =
this.options; if (d.icons) { a("<span></span>").addClass("ui-icon " + d.icons.header).prependTo(this.headers); this.active.children(".ui-icon").toggleClass(d.icons.header).toggleClass(d.icons.headerSelected); this.element.addClass("ui-accordion-icons") } 
                        }, _destroyIcons: function() { this.headers.children(".ui-icon").remove(); this.element.removeClass("ui-accordion-icons") }, destroy: function() {
                            var d = this.options; this.element.removeClass("ui-accordion ui-widget ui-helper-reset").removeAttr("role"); this.headers.unbind(".accordion").removeClass("ui-accordion-header ui-accordion-disabled ui-helper-reset ui-state-default ui-corner-all ui-state-active ui-state-disabled ui-corner-top").removeAttr("role").removeAttr("aria-expanded").removeAttr("aria-selected").removeAttr("tabIndex");
                            this.headers.find("a").removeAttr("tabIndex"); this._destroyIcons(); var c = this.headers.next().css("display", "").removeAttr("role").removeClass("ui-helper-reset ui-widget-content ui-corner-bottom ui-accordion-content ui-accordion-content-active ui-accordion-disabled ui-state-disabled"); if (d.autoHeight || d.fillHeight) c.css("height", ""); return a.Widget.prototype.destroy.call(this)
                        }, _setOption: function(d, c) {
                            a.Widget.prototype._setOption.apply(this, arguments); d == "active" && this.activate(c); if (d == "icons") {
                                this._destroyIcons();
                                c && this._createIcons()
                            } if (d == "disabled") this.headers.add(this.headers.next())[c ? "addClass" : "removeClass"]("ui-accordion-disabled ui-state-disabled")
                        }, _keydown: function(d) {
                            if (!(this.options.disabled || d.altKey || d.ctrlKey)) {
                                var c = a.ui.keyCode, f = this.headers.length, g = this.headers.index(d.target), e = false; switch (d.keyCode) {
                                    case c.RIGHT: case c.DOWN: e = this.headers[(g + 1) % f]; break; case c.LEFT: case c.UP: e = this.headers[(g - 1 + f) % f]; break; case c.SPACE: case c.ENTER: this._clickHandler({ target: d.target }, d.target);
                                        d.preventDefault()
                                } if (e) { a(d.target).attr("tabIndex", -1); a(e).attr("tabIndex", 0); e.focus(); return false } return true
                            } 
                        }, resize: function() {
                            var d = this.options, c; if (d.fillSpace) {
                                if (a.browser.msie) { var f = this.element.parent().css("overflow"); this.element.parent().css("overflow", "hidden") } c = this.element.parent().height(); a.browser.msie && this.element.parent().css("overflow", f); this.headers.each(function() { c -= a(this).outerHeight(true) }); this.headers.next().each(function() {
                                    a(this).height(Math.max(0, c - a(this).innerHeight() +
a(this).height()))
                                }).css("overflow", "auto")
                            } else if (d.autoHeight) { c = 0; this.headers.next().each(function() { c = Math.max(c, a(this).height("").height()) }).height(c) } return this
                        }, activate: function(d) { this.options.active = d; d = this._findActive(d)[0]; this._clickHandler({ target: d }, d); return this }, _findActive: function(d) { return d ? typeof d === "number" ? this.headers.filter(":eq(" + d + ")") : this.headers.not(this.headers.not(d)) : d === false ? a([]) : this.headers.filter(":eq(0)") }, _clickHandler: function(d, c) {
                            var f = this.options;
                            if (!f.disabled) if (d.target) {
                                d = a(d.currentTarget || c); c = d[0] === this.active[0]; f.active = f.collapsible && c ? false : this.headers.index(d); if (!(this.running || !f.collapsible && c)) {
                                    var g = this.active; h = d.next(); i = this.active.next(); b = { options: f, newHeader: c && f.collapsible ? a([]) : d, oldHeader: this.active, newContent: c && f.collapsible ? a([]) : h, oldContent: i }; var e = this.headers.index(this.active[0]) > this.headers.index(d[0]); this.active = c ? a([]) : d; this._toggle(h, i, b, c, e); g.removeClass("ui-state-active ui-corner-top").addClass("ui-state-default ui-corner-all").children(".ui-icon").removeClass(f.icons.headerSelected).addClass(f.icons.header);
                                    if (!c) { d.removeClass("ui-state-default ui-corner-all").addClass("ui-state-active ui-corner-top").children(".ui-icon").removeClass(f.icons.header).addClass(f.icons.headerSelected); d.next().addClass("ui-accordion-content-active") } 
                                } 
                            } else if (f.collapsible) {
                                this.active.removeClass("ui-state-active ui-corner-top").addClass("ui-state-default ui-corner-all").children(".ui-icon").removeClass(f.icons.headerSelected).addClass(f.icons.header); this.active.next().addClass("ui-accordion-content-active"); var i = this.active.next(),
b = { options: f, newHeader: a([]), oldHeader: f.active, newContent: a([]), oldContent: i }, h = this.active = a([]); this._toggle(h, i, b)
                            } 
                        }, _toggle: function(d, c, f, g, e) {
                            var i = this, b = i.options; i.toShow = d; i.toHide = c; i.data = f; var h = function() { if (i) return i._completed.apply(i, arguments) }; i._trigger("changestart", null, i.data); i.running = c.size() === 0 ? d.size() : c.size(); if (b.animated) {
                                f = {}; f = b.collapsible && g ? { toShow: a([]), toHide: c, complete: h, down: e, autoHeight: b.autoHeight || b.fillSpace} : { toShow: d, toHide: c, complete: h, down: e, autoHeight: b.autoHeight ||
b.fillSpace
                                }; if (!b.proxied) b.proxied = b.animated; if (!b.proxiedDuration) b.proxiedDuration = b.duration; b.animated = a.isFunction(b.proxied) ? b.proxied(f) : b.proxied; b.duration = a.isFunction(b.proxiedDuration) ? b.proxiedDuration(f) : b.proxiedDuration; g = a.ui.accordion.animations; var j = b.duration, l = b.animated; if (l && !g[l] && !a.easing[l]) l = "slide"; g[l] || (g[l] = function(o) { this.slide(o, { easing: l, duration: j || 700 }) }); g[l](f)
                            } else { if (b.collapsible && g) d.toggle(); else { c.hide(); d.show() } h(true) } c.prev().attr({ "aria-expanded": "false",
                                "aria-selected": "false", tabIndex: -1
                            }).blur(); d.prev().attr({ "aria-expanded": "true", "aria-selected": "true", tabIndex: 0 }).focus()
                        }, _completed: function(d) { this.running = d ? 0 : --this.running; if (!this.running) { this.options.clearStyle && this.toShow.add(this.toHide).css({ height: "", overflow: "" }); this.toHide.removeClass("ui-accordion-content-active"); if (this.toHide.length) this.toHide.parent()[0].className = this.toHide.parent()[0].className; this._trigger("change", null, this.data) } } 
                        }); a.extend(a.ui.accordion, { version: "1.8.13",
                            animations: { slide: function(d, c) {
                                d = a.extend({ easing: "swing", duration: 300 }, d, c); if (d.toHide.size()) if (d.toShow.size()) {
                                    var f = d.toShow.css("overflow"), g = 0, e = {}, i = {}, b; c = d.toShow; b = c[0].style.width; c.width(parseInt(c.parent().width(), 10) - parseInt(c.css("paddingLeft"), 10) - parseInt(c.css("paddingRight"), 10) - (parseInt(c.css("borderLeftWidth"), 10) || 0) - (parseInt(c.css("borderRightWidth"), 10) || 0)); a.each(["height", "paddingTop", "paddingBottom"], function(h, j) {
                                        i[j] = "hide"; h = ("" + a.css(d.toShow[0], j)).match(/^([\d+-.]+)(.*)$/);
                                        e[j] = { value: h[1], unit: h[2] || "px"}
                                    }); d.toShow.css({ height: 0, overflow: "hidden" }).show(); d.toHide.filter(":hidden").each(d.complete).end().filter(":visible").animate(i, { step: function(h, j) { if (j.prop == "height") g = j.end - j.start === 0 ? 0 : (j.now - j.start) / (j.end - j.start); d.toShow[0].style[j.prop] = g * e[j.prop].value + e[j.prop].unit }, duration: d.duration, easing: d.easing, complete: function() { d.autoHeight || d.toShow.css("height", ""); d.toShow.css({ width: b, overflow: f }); d.complete() } })
                                } else d.toHide.animate({ height: "hide",
                                    paddingTop: "hide", paddingBottom: "hide"
                                }, d); else d.toShow.animate({ height: "show", paddingTop: "show", paddingBottom: "show" }, d)
                            }, bounceslide: function(d) { this.slide(d, { easing: d.down ? "easeOutBounce" : "swing", duration: d.down ? 1E3 : 200 }) } }
                            })
                        })(jQuery);
                        (function(a) {
                            var d = 0; a.widget("ui.autocomplete", { options: { appendTo: "body", autoFocus: false, delay: 300, minLength: 1, position: { my: "left top", at: "left bottom", collision: "none" }, source: null }, pending: 0, _create: function() {
                                var c = this, f = this.element[0].ownerDocument, g; this.element.addClass("ui-autocomplete-input").attr("autocomplete", "off").attr({ role: "textbox", "aria-autocomplete": "list", "aria-haspopup": "true" }).bind("keydown.autocomplete", function(e) {
                                    if (!(c.options.disabled || c.element.attr("readonly"))) {
                                        g =
false; var i = a.ui.keyCode; switch (e.keyCode) {
                                            case i.PAGE_UP: c._move("previousPage", e); break; case i.PAGE_DOWN: c._move("nextPage", e); break; case i.UP: c._move("previous", e); e.preventDefault(); break; case i.DOWN: c._move("next", e); e.preventDefault(); break; case i.ENTER: case i.NUMPAD_ENTER: if (c.menu.active) { g = true; e.preventDefault() } case i.TAB: if (!c.menu.active) return; c.menu.select(e); break; case i.ESCAPE: c.element.val(c.term); c.close(e); break; default: clearTimeout(c.searching); c.searching = setTimeout(function() {
                                                if (c.term !=
c.element.val()) { c.selectedItem = null; c.search(null, e) } 
                                            }, c.options.delay); break
                                        } 
                                    } 
                                }).bind("keypress.autocomplete", function(e) { if (g) { g = false; e.preventDefault() } }).bind("focus.autocomplete", function() { if (!c.options.disabled) { c.selectedItem = null; c.previous = c.element.val() } }).bind("blur.autocomplete", function(e) { if (!c.options.disabled) { clearTimeout(c.searching); c.closing = setTimeout(function() { c.close(e); c._change(e) }, 150) } }); this._initSource(); this.response = function() { return c._response.apply(c, arguments) };
                                this.menu = a("<ul></ul>").addClass("ui-autocomplete").appendTo(a(this.options.appendTo || "body", f)[0]).mousedown(function(e) { var i = c.menu.element[0]; a(e.target).closest(".ui-menu-item").length || setTimeout(function() { a(document).one("mousedown", function(b) { b.target !== c.element[0] && b.target !== i && !a.ui.contains(i, b.target) && c.close() }) }, 1); setTimeout(function() { clearTimeout(c.closing) }, 13) }).menu({ focus: function(e, i) {
                                    i = i.item.data("item.autocomplete"); false !== c._trigger("focus", e, { item: i }) && /^key/.test(e.originalEvent.type) &&
c.element.val(i.value)
                                }, selected: function(e, i) { var b = i.item.data("item.autocomplete"), h = c.previous; if (c.element[0] !== f.activeElement) { c.element.focus(); c.previous = h; setTimeout(function() { c.previous = h; c.selectedItem = b }, 1) } false !== c._trigger("select", e, { item: b }) && c.element.val(b.value); c.term = c.element.val(); c.close(e); c.selectedItem = b }, blur: function() { c.menu.element.is(":visible") && c.element.val() !== c.term && c.element.val(c.term) } 
                                }).zIndex(this.element.zIndex() + 1).css({ top: 0, left: 0 }).hide().data("menu");
                                a.fn.bgiframe && this.menu.element.bgiframe()
                            }, destroy: function() { this.element.removeClass("ui-autocomplete-input").removeAttr("autocomplete").removeAttr("role").removeAttr("aria-autocomplete").removeAttr("aria-haspopup"); this.menu.element.remove(); a.Widget.prototype.destroy.call(this) }, _setOption: function(c, f) {
                                a.Widget.prototype._setOption.apply(this, arguments); c === "source" && this._initSource(); if (c === "appendTo") this.menu.element.appendTo(a(f || "body", this.element[0].ownerDocument)[0]); c === "disabled" &&
f && this.xhr && this.xhr.abort()
                            }, _initSource: function() {
                                var c = this, f, g; if (a.isArray(this.options.source)) { f = this.options.source; this.source = function(e, i) { i(a.ui.autocomplete.filter(f, e.term)) } } else if (typeof this.options.source === "string") { g = this.options.source; this.source = function(e, i) { c.xhr && c.xhr.abort(); c.xhr = a.ajax({ url: g, data: e, dataType: "json", autocompleteRequest: ++d, success: function(b) { this.autocompleteRequest === d && i(b) }, error: function() { this.autocompleteRequest === d && i([]) } }) } } else this.source =
this.options.source
                            }, search: function(c, f) { c = c != null ? c : this.element.val(); this.term = this.element.val(); if (c.length < this.options.minLength) return this.close(f); clearTimeout(this.closing); if (this._trigger("search", f) !== false) return this._search(c) }, _search: function(c) { this.pending++; this.element.addClass("ui-autocomplete-loading"); this.source({ term: c }, this.response) }, _response: function(c) {
                                if (!this.options.disabled && c && c.length) { c = this._normalize(c); this._suggest(c); this._trigger("open") } else this.close();
                                this.pending--; this.pending || this.element.removeClass("ui-autocomplete-loading")
                            }, close: function(c) { clearTimeout(this.closing); if (this.menu.element.is(":visible")) { this.menu.element.hide(); this.menu.deactivate(); this._trigger("close", c) } }, _change: function(c) { this.previous !== this.element.val() && this._trigger("change", c, { item: this.selectedItem }) }, _normalize: function(c) {
                                if (c.length && c[0].label && c[0].value) return c; return a.map(c, function(f) {
                                    if (typeof f === "string") return { label: f, value: f }; return a.extend({ label: f.label ||
f.value, value: f.value || f.label
                                    }, f)
                                })
                            }, _suggest: function(c) { var f = this.menu.element.empty().zIndex(this.element.zIndex() + 1); this._renderMenu(f, c); this.menu.deactivate(); this.menu.refresh(); f.show(); this._resizeMenu(); f.position(a.extend({ of: this.element }, this.options.position)); this.options.autoFocus && this.menu.next(new a.Event("mouseover")) }, _resizeMenu: function() { var c = this.menu.element; c.outerWidth(Math.max(c.width("").outerWidth(), this.element.outerWidth())) }, _renderMenu: function(c, f) {
                                var g = this;
                                a.each(f, function(e, i) { g._renderItem(c, i) })
                            }, _renderItem: function(c, f) { return a("<li></li>").data("item.autocomplete", f).append(a("<a></a>").text(f.label)).appendTo(c) }, _move: function(c, f) { if (this.menu.element.is(":visible")) if (this.menu.first() && /^previous/.test(c) || this.menu.last() && /^next/.test(c)) { this.element.val(this.term); this.menu.deactivate() } else this.menu[c](f); else this.search(null, f) }, widget: function() { return this.menu.element } 
                            }); a.extend(a.ui.autocomplete, { escapeRegex: function(c) {
                                return c.replace(/[-[\]{}()*+?.,\\^$|#\s]/g,
"\\$&")
                            }, filter: function(c, f) { var g = new RegExp(a.ui.autocomplete.escapeRegex(f), "i"); return a.grep(c, function(e) { return g.test(e.label || e.value || e) }) } 
                            })
                        })(jQuery);
                        (function(a) {
                            a.widget("ui.menu", { _create: function() { var d = this; this.element.addClass("ui-menu ui-widget ui-widget-content ui-corner-all").attr({ role: "listbox", "aria-activedescendant": "ui-active-menuitem" }).click(function(c) { if (a(c.target).closest(".ui-menu-item a").length) { c.preventDefault(); d.select(c) } }); this.refresh() }, refresh: function() {
                                var d = this; this.element.children("li:not(.ui-menu-item):has(a)").addClass("ui-menu-item").attr("role", "menuitem").children("a").addClass("ui-corner-all").attr("tabindex",
-1).mouseenter(function(c) { d.activate(c, a(this).parent()) }).mouseleave(function() { d.deactivate() })
                            }, activate: function(d, c) { this.deactivate(); if (this.hasScroll()) { var f = c.offset().top - this.element.offset().top, g = this.element.scrollTop(), e = this.element.height(); if (f < 0) this.element.scrollTop(g + f); else f >= e && this.element.scrollTop(g + f - e + c.height()) } this.active = c.eq(0).children("a").addClass("ui-state-hover").attr("id", "ui-active-menuitem").end(); this._trigger("focus", d, { item: c }) }, deactivate: function() {
                                if (this.active) {
                                    this.active.children("a").removeClass("ui-state-hover").removeAttr("id");
                                    this._trigger("blur"); this.active = null
                                } 
                            }, next: function(d) { this.move("next", ".ui-menu-item:first", d) }, previous: function(d) { this.move("prev", ".ui-menu-item:last", d) }, first: function() { return this.active && !this.active.prevAll(".ui-menu-item").length }, last: function() { return this.active && !this.active.nextAll(".ui-menu-item").length }, move: function(d, c, f) {
                                if (this.active) { d = this.active[d + "All"](".ui-menu-item").eq(0); d.length ? this.activate(f, d) : this.activate(f, this.element.children(c)) } else this.activate(f,
this.element.children(c))
                            }, nextPage: function(d) {
                                if (this.hasScroll()) if (!this.active || this.last()) this.activate(d, this.element.children(".ui-menu-item:first")); else { var c = this.active.offset().top, f = this.element.height(), g = this.element.children(".ui-menu-item").filter(function() { var e = a(this).offset().top - c - f + a(this).height(); return e < 10 && e > -10 }); g.length || (g = this.element.children(".ui-menu-item:last")); this.activate(d, g) } else this.activate(d, this.element.children(".ui-menu-item").filter(!this.active ||
this.last() ? ":first" : ":last"))
                            }, previousPage: function(d) {
                                if (this.hasScroll()) if (!this.active || this.first()) this.activate(d, this.element.children(".ui-menu-item:last")); else { var c = this.active.offset().top, f = this.element.height(); result = this.element.children(".ui-menu-item").filter(function() { var g = a(this).offset().top - c + f - a(this).height(); return g < 10 && g > -10 }); result.length || (result = this.element.children(".ui-menu-item:first")); this.activate(d, result) } else this.activate(d, this.element.children(".ui-menu-item").filter(!this.active ||
this.first() ? ":last" : ":first"))
                            }, hasScroll: function() { return this.element.height() < this.element[a.fn.prop ? "prop" : "attr"]("scrollHeight") }, select: function(d) { this._trigger("selected", d, { item: this.active }) } 
                            })
                        })(jQuery);
                        (function(a) {
                            var d, c = function(g) { a(":ui-button", g.target.form).each(function() { var e = a(this).data("button"); setTimeout(function() { e.refresh() }, 1) }) }, f = function(g) { var e = g.name, i = g.form, b = a([]); if (e) b = i ? a(i).find("[name='" + e + "']") : a("[name='" + e + "']", g.ownerDocument).filter(function() { return !this.form }); return b }; a.widget("ui.button", { options: { disabled: null, text: true, label: null, icons: { primary: null, secondary: null} }, _create: function() {
                                this.element.closest("form").unbind("reset.button").bind("reset.button",
c); if (typeof this.options.disabled !== "boolean") this.options.disabled = this.element.attr("disabled"); this._determineButtonType(); this.hasTitle = !!this.buttonElement.attr("title"); var g = this, e = this.options, i = this.type === "checkbox" || this.type === "radio", b = "ui-state-hover" + (!i ? " ui-state-active" : ""); if (e.label === null) e.label = this.buttonElement.html(); if (this.element.is(":disabled")) e.disabled = true; this.buttonElement.addClass("ui-button ui-widget ui-state-default ui-corner-all").attr("role", "button").bind("mouseenter.button",
function() { if (!e.disabled) { a(this).addClass("ui-state-hover"); this === d && a(this).addClass("ui-state-active") } }).bind("mouseleave.button", function() { e.disabled || a(this).removeClass(b) }).bind("focus.button", function() { a(this).addClass("ui-state-focus") }).bind("blur.button", function() { a(this).removeClass("ui-state-focus") }).bind("click.button", function(h) { e.disabled && h.stopImmediatePropagation() }); i && this.element.bind("change.button", function() { g.refresh() }); if (this.type === "checkbox") this.buttonElement.bind("click.button",
function() { if (e.disabled) return false; a(this).toggleClass("ui-state-active"); g.buttonElement.attr("aria-pressed", g.element[0].checked) }); else if (this.type === "radio") this.buttonElement.bind("click.button", function() { if (e.disabled) return false; a(this).addClass("ui-state-active"); g.buttonElement.attr("aria-pressed", true); var h = g.element[0]; f(h).not(h).map(function() { return a(this).button("widget")[0] }).removeClass("ui-state-active").attr("aria-pressed", false) }); else {
                                    this.buttonElement.bind("mousedown.button",
function() { if (e.disabled) return false; a(this).addClass("ui-state-active"); d = this; a(document).one("mouseup", function() { d = null }) }).bind("mouseup.button", function() { if (e.disabled) return false; a(this).removeClass("ui-state-active") }).bind("keydown.button", function(h) { if (e.disabled) return false; if (h.keyCode == a.ui.keyCode.SPACE || h.keyCode == a.ui.keyCode.ENTER) a(this).addClass("ui-state-active") }).bind("keyup.button", function() { a(this).removeClass("ui-state-active") }); this.buttonElement.is("a") && this.buttonElement.keyup(function(h) {
    h.keyCode ===
a.ui.keyCode.SPACE && a(this).click()
})
                                } this._setOption("disabled", e.disabled)
                            }, _determineButtonType: function() {
                                this.type = this.element.is(":checkbox") ? "checkbox" : this.element.is(":radio") ? "radio" : this.element.is("input") ? "input" : "button"; if (this.type === "checkbox" || this.type === "radio") {
                                    var g = this.element.parents().filter(":last"), e = "label[for=" + this.element.attr("id") + "]"; this.buttonElement = g.find(e); if (!this.buttonElement.length) {
                                        g = g.length ? g.siblings() : this.element.siblings(); this.buttonElement = g.filter(e);
                                        if (!this.buttonElement.length) this.buttonElement = g.find(e)
                                    } this.element.addClass("ui-helper-hidden-accessible"); (g = this.element.is(":checked")) && this.buttonElement.addClass("ui-state-active"); this.buttonElement.attr("aria-pressed", g)
                                } else this.buttonElement = this.element
                            }, widget: function() { return this.buttonElement }, destroy: function() {
                                this.element.removeClass("ui-helper-hidden-accessible"); this.buttonElement.removeClass("ui-button ui-widget ui-state-default ui-corner-all ui-state-hover ui-state-active  ui-button-icons-only ui-button-icon-only ui-button-text-icons ui-button-text-icon-primary ui-button-text-icon-secondary ui-button-text-only").removeAttr("role").removeAttr("aria-pressed").html(this.buttonElement.find(".ui-button-text").html());
                                this.hasTitle || this.buttonElement.removeAttr("title"); a.Widget.prototype.destroy.call(this)
                            }, _setOption: function(g, e) { a.Widget.prototype._setOption.apply(this, arguments); if (g === "disabled") e ? this.element.attr("disabled", true) : this.element.removeAttr("disabled"); this._resetButton() }, refresh: function() {
                                var g = this.element.is(":disabled"); g !== this.options.disabled && this._setOption("disabled", g); if (this.type === "radio") f(this.element[0]).each(function() {
                                    a(this).is(":checked") ? a(this).button("widget").addClass("ui-state-active").attr("aria-pressed",
true) : a(this).button("widget").removeClass("ui-state-active").attr("aria-pressed", false)
                                }); else if (this.type === "checkbox") this.element.is(":checked") ? this.buttonElement.addClass("ui-state-active").attr("aria-pressed", true) : this.buttonElement.removeClass("ui-state-active").attr("aria-pressed", false)
                            }, _resetButton: function() {
                                if (this.type === "input") this.options.label && this.element.val(this.options.label); else {
                                    var g = this.buttonElement.removeClass("ui-button-icons-only ui-button-icon-only ui-button-text-icons ui-button-text-icon-primary ui-button-text-icon-secondary ui-button-text-only"),
e = a("<span></span>").addClass("ui-button-text").html(this.options.label).appendTo(g.empty()).text(), i = this.options.icons, b = i.primary && i.secondary, h = []; if (i.primary || i.secondary) {
                                        if (this.options.text) h.push("ui-button-text-icon" + (b ? "s" : i.primary ? "-primary" : "-secondary")); i.primary && g.prepend("<span class='ui-button-icon-primary ui-icon " + i.primary + "'></span>"); i.secondary && g.append("<span class='ui-button-icon-secondary ui-icon " + i.secondary + "'></span>"); if (!this.options.text) {
                                            h.push(b ? "ui-button-icons-only" :
"ui-button-icon-only"); this.hasTitle || g.attr("title", e)
                                        } 
                                    } else h.push("ui-button-text-only"); g.addClass(h.join(" "))
                                } 
                            } 
                            }); a.widget("ui.buttonset", { options: { items: ":button, :submit, :reset, :checkbox, :radio, a, :data(button)" }, _create: function() { this.element.addClass("ui-buttonset") }, _init: function() { this.refresh() }, _setOption: function(g, e) { g === "disabled" && this.buttons.button("option", g, e); a.Widget.prototype._setOption.apply(this, arguments) }, refresh: function() { this.buttons = this.element.find(this.options.items).filter(":ui-button").button("refresh").end().not(":ui-button").button().end().map(function() { return a(this).button("widget")[0] }).removeClass("ui-corner-all ui-corner-left ui-corner-right").filter(":first").addClass("ui-corner-left").end().filter(":last").addClass("ui-corner-right").end().end() },
                                destroy: function() { this.element.removeClass("ui-buttonset"); this.buttons.map(function() { return a(this).button("widget")[0] }).removeClass("ui-corner-left ui-corner-right").end().button("destroy"); a.Widget.prototype.destroy.call(this) } 
                            })
                        })(jQuery);
                        (function(a, d) {
                            function c() {
                                this.debug = false; this._curInst = null; this._keyEvent = false; this._disabledInputs = []; this._inDialog = this._datepickerShowing = false; this._mainDivId = "ui-datepicker-div"; this._inlineClass = "ui-datepicker-inline"; this._appendClass = "ui-datepicker-append"; this._triggerClass = "ui-datepicker-trigger"; this._dialogClass = "ui-datepicker-dialog"; this._disableClass = "ui-datepicker-disabled"; this._unselectableClass = "ui-datepicker-unselectable"; this._currentClass = "ui-datepicker-current-day"; this._dayOverClass =
"ui-datepicker-days-cell-over"; this.regional = []; this.regional[""] = { closeText: "Done", prevText: "Prev", nextText: "Next", currentText: "Today", monthNames: ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"], monthNamesShort: ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"], dayNames: ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"], dayNamesShort: ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"], dayNamesMin: ["Su",
"Mo", "Tu", "We", "Th", "Fr", "Sa"], weekHeader: "Wk", dateFormat: "mm/dd/yy", firstDay: 0, isRTL: false, showMonthAfterYear: false, yearSuffix: ""
}; this._defaults = { showOn: "focus", showAnim: "fadeIn", showOptions: {}, defaultDate: null, appendText: "", buttonText: "...", buttonImage: "", buttonImageOnly: false, hideIfNoPrevNext: false, navigationAsDateFormat: false, gotoCurrent: false, changeMonth: false, changeYear: false, yearRange: "c-10:c+10", showOtherMonths: false, selectOtherMonths: false, showWeek: false, calculateWeek: this.iso8601Week, shortYearCutoff: "+10",
    minDate: null, maxDate: null, duration: "fast", beforeShowDay: null, beforeShow: null, onSelect: null, onChangeMonthYear: null, onClose: null, numberOfMonths: 1, showCurrentAtPos: 0, stepMonths: 1, stepBigMonths: 12, altField: "", altFormat: "", constrainInput: true, showButtonPanel: false, autoSize: false
}; a.extend(this._defaults, this.regional[""]); this.dpDiv = f(a('<div id="' + this._mainDivId + '" class="ui-datepicker ui-widget ui-widget-content ui-helper-clearfix ui-corner-all"></div>'))
                            } function f(b) {
                                return b.delegate("button, .ui-datepicker-prev, .ui-datepicker-next, .ui-datepicker-calendar td a",
"mouseout", function() { a(this).removeClass("ui-state-hover"); this.className.indexOf("ui-datepicker-prev") != -1 && a(this).removeClass("ui-datepicker-prev-hover"); this.className.indexOf("ui-datepicker-next") != -1 && a(this).removeClass("ui-datepicker-next-hover") }).delegate("button, .ui-datepicker-prev, .ui-datepicker-next, .ui-datepicker-calendar td a", "mouseover", function() {
    if (!a.datepicker._isDisabledDatepicker(i.inline ? b.parent()[0] : i.input[0])) {
        a(this).parents(".ui-datepicker-calendar").find("a").removeClass("ui-state-hover");
        a(this).addClass("ui-state-hover"); this.className.indexOf("ui-datepicker-prev") != -1 && a(this).addClass("ui-datepicker-prev-hover"); this.className.indexOf("ui-datepicker-next") != -1 && a(this).addClass("ui-datepicker-next-hover")
    } 
})
                            } function g(b, h) { a.extend(b, h); for (var j in h) if (h[j] == null || h[j] == d) b[j] = h[j]; return b } a.extend(a.ui, { datepicker: { version: "1.8.13"} }); var e = (new Date).getTime(), i; a.extend(c.prototype, { markerClassName: "hasDatepicker", log: function() { this.debug && console.log.apply("", arguments) },
                                _widgetDatepicker: function() { return this.dpDiv }, setDefaults: function(b) { g(this._defaults, b || {}); return this }, _attachDatepicker: function(b, h) { var j = null; for (var l in this._defaults) { var o = b.getAttribute("date:" + l); if (o) { j = j || {}; try { j[l] = eval(o) } catch (n) { j[l] = o } } } l = b.nodeName.toLowerCase(); o = l == "div" || l == "span"; if (!b.id) { this.uuid += 1; b.id = "dp" + this.uuid } var k = this._newInst(a(b), o); k.settings = a.extend({}, h || {}, j || {}); if (l == "input") this._connectDatepicker(b, k); else o && this._inlineDatepicker(b, k) }, _newInst: function(b,
h) { return { id: b[0].id.replace(/([^A-Za-z0-9_-])/g, "\\\\$1"), input: b, selectedDay: 0, selectedMonth: 0, selectedYear: 0, drawMonth: 0, drawYear: 0, inline: h, dpDiv: !h ? this.dpDiv : f(a('<div class="' + this._inlineClass + ' ui-datepicker ui-widget ui-widget-content ui-helper-clearfix ui-corner-all"></div>'))} }, _connectDatepicker: function(b, h) {
    var j = a(b); h.append = a([]); h.trigger = a([]); if (!j.hasClass(this.markerClassName)) {
        this._attachments(j, h); j.addClass(this.markerClassName).keydown(this._doKeyDown).keypress(this._doKeyPress).keyup(this._doKeyUp).bind("setData.datepicker",
function(l, o, n) { h.settings[o] = n }).bind("getData.datepicker", function(l, o) { return this._get(h, o) }); this._autoSize(h); a.data(b, "datepicker", h)
    } 
}, _attachments: function(b, h) {
    var j = this._get(h, "appendText"), l = this._get(h, "isRTL"); h.append && h.append.remove(); if (j) { h.append = a('<span class="' + this._appendClass + '">' + j + "</span>"); b[l ? "before" : "after"](h.append) } b.unbind("focus", this._showDatepicker); h.trigger && h.trigger.remove(); j = this._get(h, "showOn"); if (j == "focus" || j == "both") b.focus(this._showDatepicker);
    if (j == "button" || j == "both") {
        j = this._get(h, "buttonText"); var o = this._get(h, "buttonImage"); h.trigger = a(this._get(h, "buttonImageOnly") ? a("<img/>").addClass(this._triggerClass).attr({ src: o, alt: j, title: j }) : a('<button type="button"></button>').addClass(this._triggerClass).html(o == "" ? j : a("<img/>").attr({ src: o, alt: j, title: j }))); b[l ? "before" : "after"](h.trigger); h.trigger.click(function() {
            a.datepicker._datepickerShowing && a.datepicker._lastInput == b[0] ? a.datepicker._hideDatepicker() : a.datepicker._showDatepicker(b[0]);
            return false
        })
    } 
}, _autoSize: function(b) { if (this._get(b, "autoSize") && !b.inline) { var h = new Date(2009, 11, 20), j = this._get(b, "dateFormat"); if (j.match(/[DM]/)) { var l = function(o) { for (var n = 0, k = 0, m = 0; m < o.length; m++) if (o[m].length > n) { n = o[m].length; k = m } return k }; h.setMonth(l(this._get(b, j.match(/MM/) ? "monthNames" : "monthNamesShort"))); h.setDate(l(this._get(b, j.match(/DD/) ? "dayNames" : "dayNamesShort")) + 20 - h.getDay()) } b.input.attr("size", this._formatDate(b, h).length) } }, _inlineDatepicker: function(b, h) {
    var j = a(b);
    if (!j.hasClass(this.markerClassName)) { j.addClass(this.markerClassName).append(h.dpDiv).bind("setData.datepicker", function(l, o, n) { h.settings[o] = n }).bind("getData.datepicker", function(l, o) { return this._get(h, o) }); a.data(b, "datepicker", h); this._setDate(h, this._getDefaultDate(h), true); this._updateDatepicker(h); this._updateAlternate(h); h.dpDiv.show() } 
}, _dialogDatepicker: function(b, h, j, l, o) {
    b = this._dialogInst; if (!b) {
        this.uuid += 1; this._dialogInput = a('<input type="text" id="' + ("dp" + this.uuid) + '" style="position: absolute; top: -100px; width: 0px; z-index: -10;"/>');
        this._dialogInput.keydown(this._doKeyDown); a("body").append(this._dialogInput); b = this._dialogInst = this._newInst(this._dialogInput, false); b.settings = {}; a.data(this._dialogInput[0], "datepicker", b)
    } g(b.settings, l || {}); h = h && h.constructor == Date ? this._formatDate(b, h) : h; this._dialogInput.val(h); this._pos = o ? o.length ? o : [o.pageX, o.pageY] : null; if (!this._pos) this._pos = [document.documentElement.clientWidth / 2 - 100 + (document.documentElement.scrollLeft || document.body.scrollLeft), document.documentElement.clientHeight /
2 - 150 + (document.documentElement.scrollTop || document.body.scrollTop)]; this._dialogInput.css("left", this._pos[0] + 20 + "px").css("top", this._pos[1] + "px"); b.settings.onSelect = j; this._inDialog = true; this.dpDiv.addClass(this._dialogClass); this._showDatepicker(this._dialogInput[0]); a.blockUI && a.blockUI(this.dpDiv); a.data(this._dialogInput[0], "datepicker", b); return this
}, _destroyDatepicker: function(b) {
    var h = a(b), j = a.data(b, "datepicker"); if (h.hasClass(this.markerClassName)) {
        var l = b.nodeName.toLowerCase(); a.removeData(b,
"datepicker"); if (l == "input") { j.append.remove(); j.trigger.remove(); h.removeClass(this.markerClassName).unbind("focus", this._showDatepicker).unbind("keydown", this._doKeyDown).unbind("keypress", this._doKeyPress).unbind("keyup", this._doKeyUp) } else if (l == "div" || l == "span") h.removeClass(this.markerClassName).empty()
    } 
}, _enableDatepicker: function(b) {
    var h = a(b), j = a.data(b, "datepicker"); if (h.hasClass(this.markerClassName)) {
        var l = b.nodeName.toLowerCase(); if (l == "input") {
            b.disabled = false; j.trigger.filter("button").each(function() {
                this.disabled =
false
            }).end().filter("img").css({ opacity: "1.0", cursor: "" })
        } else if (l == "div" || l == "span") { h = h.children("." + this._inlineClass); h.children().removeClass("ui-state-disabled"); h.find("select.ui-datepicker-month, select.ui-datepicker-year").removeAttr("disabled") } this._disabledInputs = a.map(this._disabledInputs, function(o) { return o == b ? null : o })
    } 
}, _disableDatepicker: function(b) {
    var h = a(b), j = a.data(b, "datepicker"); if (h.hasClass(this.markerClassName)) {
        var l = b.nodeName.toLowerCase(); if (l == "input") {
            b.disabled =
true; j.trigger.filter("button").each(function() { this.disabled = true }).end().filter("img").css({ opacity: "0.5", cursor: "default" })
        } else if (l == "div" || l == "span") { h = h.children("." + this._inlineClass); h.children().addClass("ui-state-disabled"); h.find("select.ui-datepicker-month, select.ui-datepicker-year").attr("disabled", "disabled") } this._disabledInputs = a.map(this._disabledInputs, function(o) { return o == b ? null : o }); this._disabledInputs[this._disabledInputs.length] = b
    } 
}, _isDisabledDatepicker: function(b) {
    if (!b) return false;
    for (var h = 0; h < this._disabledInputs.length; h++) if (this._disabledInputs[h] == b) return true; return false
}, _getInst: function(b) { try { return a.data(b, "datepicker") } catch (h) { throw "Missing instance data for this datepicker"; } }, _optionDatepicker: function(b, h, j) {
    var l = this._getInst(b); if (arguments.length == 2 && typeof h == "string") return h == "defaults" ? a.extend({}, a.datepicker._defaults) : l ? h == "all" ? a.extend({}, l.settings) : this._get(l, h) : null; var o = h || {}; if (typeof h == "string") { o = {}; o[h] = j } if (l) {
        this._curInst == l &&
this._hideDatepicker(); var n = this._getDateDatepicker(b, true), k = this._getMinMaxDate(l, "min"), m = this._getMinMaxDate(l, "max"); g(l.settings, o); if (k !== null && o.dateFormat !== d && o.minDate === d) l.settings.minDate = this._formatDate(l, k); if (m !== null && o.dateFormat !== d && o.maxDate === d) l.settings.maxDate = this._formatDate(l, m); this._attachments(a(b), l); this._autoSize(l); this._setDate(l, n); this._updateAlternate(l); this._updateDatepicker(l)
    } 
}, _changeDatepicker: function(b, h, j) { this._optionDatepicker(b, h, j) }, _refreshDatepicker: function(b) {
    (b =
this._getInst(b)) && this._updateDatepicker(b)
}, _setDateDatepicker: function(b, h) { if (b = this._getInst(b)) { this._setDate(b, h); this._updateDatepicker(b); this._updateAlternate(b) } }, _getDateDatepicker: function(b, h) { (b = this._getInst(b)) && !b.inline && this._setDateFromField(b, h); return b ? this._getDate(b) : null }, _doKeyDown: function(b) {
    var h = a.datepicker._getInst(b.target), j = true, l = h.dpDiv.is(".ui-datepicker-rtl"); h._keyEvent = true; if (a.datepicker._datepickerShowing) switch (b.keyCode) {
        case 9: a.datepicker._hideDatepicker();
            j = false; break; case 13: j = a("td." + a.datepicker._dayOverClass + ":not(." + a.datepicker._currentClass + ")", h.dpDiv); j[0] ? a.datepicker._selectDay(b.target, h.selectedMonth, h.selectedYear, j[0]) : a.datepicker._hideDatepicker(); return false; case 27: a.datepicker._hideDatepicker(); break; case 33: a.datepicker._adjustDate(b.target, b.ctrlKey ? -a.datepicker._get(h, "stepBigMonths") : -a.datepicker._get(h, "stepMonths"), "M"); break; case 34: a.datepicker._adjustDate(b.target, b.ctrlKey ? +a.datepicker._get(h, "stepBigMonths") : +a.datepicker._get(h,
"stepMonths"), "M"); break; case 35: if (b.ctrlKey || b.metaKey) a.datepicker._clearDate(b.target); j = b.ctrlKey || b.metaKey; break; case 36: if (b.ctrlKey || b.metaKey) a.datepicker._gotoToday(b.target); j = b.ctrlKey || b.metaKey; break; case 37: if (b.ctrlKey || b.metaKey) a.datepicker._adjustDate(b.target, l ? +1 : -1, "D"); j = b.ctrlKey || b.metaKey; if (b.originalEvent.altKey) a.datepicker._adjustDate(b.target, b.ctrlKey ? -a.datepicker._get(h, "stepBigMonths") : -a.datepicker._get(h, "stepMonths"), "M"); break; case 38: if (b.ctrlKey || b.metaKey) a.datepicker._adjustDate(b.target,
-7, "D"); j = b.ctrlKey || b.metaKey; break; case 39: if (b.ctrlKey || b.metaKey) a.datepicker._adjustDate(b.target, l ? -1 : +1, "D"); j = b.ctrlKey || b.metaKey; if (b.originalEvent.altKey) a.datepicker._adjustDate(b.target, b.ctrlKey ? +a.datepicker._get(h, "stepBigMonths") : +a.datepicker._get(h, "stepMonths"), "M"); break; case 40: if (b.ctrlKey || b.metaKey) a.datepicker._adjustDate(b.target, +7, "D"); j = b.ctrlKey || b.metaKey; break; default: j = false
    } else if (b.keyCode == 36 && b.ctrlKey) a.datepicker._showDatepicker(this); else j = false; if (j) {
        b.preventDefault();
        b.stopPropagation()
    } 
}, _doKeyPress: function(b) { var h = a.datepicker._getInst(b.target); if (a.datepicker._get(h, "constrainInput")) { h = a.datepicker._possibleChars(a.datepicker._get(h, "dateFormat")); var j = String.fromCharCode(b.charCode == d ? b.keyCode : b.charCode); return b.ctrlKey || b.metaKey || j < " " || !h || h.indexOf(j) > -1 } }, _doKeyUp: function(b) {
    b = a.datepicker._getInst(b.target); if (b.input.val() != b.lastVal) try {
        if (a.datepicker.parseDate(a.datepicker._get(b, "dateFormat"), b.input ? b.input.val() : null, a.datepicker._getFormatConfig(b))) {
            a.datepicker._setDateFromField(b);
            a.datepicker._updateAlternate(b); a.datepicker._updateDatepicker(b)
        } 
    } catch (h) { a.datepicker.log(h) } return true
}, _showDatepicker: function(b) {
    b = b.target || b; if (b.nodeName.toLowerCase() != "input") b = a("input", b.parentNode)[0]; if (!(a.datepicker._isDisabledDatepicker(b) || a.datepicker._lastInput == b)) {
        var h = a.datepicker._getInst(b); a.datepicker._curInst && a.datepicker._curInst != h && a.datepicker._curInst.dpDiv.stop(true, true); var j = a.datepicker._get(h, "beforeShow"); g(h.settings, j ? j.apply(b, [b, h]) : {}); h.lastVal =
null; a.datepicker._lastInput = b; a.datepicker._setDateFromField(h); if (a.datepicker._inDialog) b.value = ""; if (!a.datepicker._pos) { a.datepicker._pos = a.datepicker._findPos(b); a.datepicker._pos[1] += b.offsetHeight } var l = false; a(b).parents().each(function() { l |= a(this).css("position") == "fixed"; return !l }); if (l && a.browser.opera) { a.datepicker._pos[0] -= document.documentElement.scrollLeft; a.datepicker._pos[1] -= document.documentElement.scrollTop } j = { left: a.datepicker._pos[0], top: a.datepicker._pos[1] }; a.datepicker._pos =
null; h.dpDiv.empty(); h.dpDiv.css({ position: "absolute", display: "block", top: "-1000px" }); a.datepicker._updateDatepicker(h); j = a.datepicker._checkOffset(h, j, l); h.dpDiv.css({ position: a.datepicker._inDialog && a.blockUI ? "static" : l ? "fixed" : "absolute", display: "none", left: j.left + "px", top: j.top + "px" }); if (!h.inline) {
            j = a.datepicker._get(h, "showAnim"); var o = a.datepicker._get(h, "duration"), n = function() {
                var k = h.dpDiv.find("iframe.ui-datepicker-cover"); if (k.length) {
                    var m = a.datepicker._getBorders(h.dpDiv); k.css({ left: -m[0],
                        top: -m[1], width: h.dpDiv.outerWidth(), height: h.dpDiv.outerHeight()
                    })
                } 
            }; h.dpDiv.zIndex(a(b).zIndex() + 1); a.datepicker._datepickerShowing = true; a.effects && a.effects[j] ? h.dpDiv.show(j, a.datepicker._get(h, "showOptions"), o, n) : h.dpDiv[j || "show"](j ? o : null, n); if (!j || !o) n(); h.input.is(":visible") && !h.input.is(":disabled") && h.input.focus(); a.datepicker._curInst = h
        } 
    } 
}, _updateDatepicker: function(b) {
    var h = a.datepicker._getBorders(b.dpDiv); i = b; b.dpDiv.empty().append(this._generateHTML(b)); var j = b.dpDiv.find("iframe.ui-datepicker-cover");
    j.length && j.css({ left: -h[0], top: -h[1], width: b.dpDiv.outerWidth(), height: b.dpDiv.outerHeight() }); b.dpDiv.find("." + this._dayOverClass + " a").mouseover(); h = this._getNumberOfMonths(b); j = h[1]; b.dpDiv.removeClass("ui-datepicker-multi-2 ui-datepicker-multi-3 ui-datepicker-multi-4").width(""); j > 1 && b.dpDiv.addClass("ui-datepicker-multi-" + j).css("width", 17 * j + "em"); b.dpDiv[(h[0] != 1 || h[1] != 1 ? "add" : "remove") + "Class"]("ui-datepicker-multi"); b.dpDiv[(this._get(b, "isRTL") ? "add" : "remove") + "Class"]("ui-datepicker-rtl");
    b == a.datepicker._curInst && a.datepicker._datepickerShowing && b.input && b.input.is(":visible") && !b.input.is(":disabled") && b.input[0] != document.activeElement && b.input.focus(); if (b.yearshtml) { var l = b.yearshtml; setTimeout(function() { l === b.yearshtml && b.yearshtml && b.dpDiv.find("select.ui-datepicker-year:first").replaceWith(b.yearshtml); l = b.yearshtml = null }, 0) } 
}, _getBorders: function(b) { var h = function(j) { return { thin: 1, medium: 2, thick: 3}[j] || j }; return [parseFloat(h(b.css("border-left-width"))), parseFloat(h(b.css("border-top-width")))] },
                                _checkOffset: function(b, h, j) {
                                    var l = b.dpDiv.outerWidth(), o = b.dpDiv.outerHeight(), n = b.input ? b.input.outerWidth() : 0, k = b.input ? b.input.outerHeight() : 0, m = document.documentElement.clientWidth + a(document).scrollLeft(), p = document.documentElement.clientHeight + a(document).scrollTop(); h.left -= this._get(b, "isRTL") ? l - n : 0; h.left -= j && h.left == b.input.offset().left ? a(document).scrollLeft() : 0; h.top -= j && h.top == b.input.offset().top + k ? a(document).scrollTop() : 0; h.left -= Math.min(h.left, h.left + l > m && m > l ? Math.abs(h.left + l -
m) : 0); h.top -= Math.min(h.top, h.top + o > p && p > o ? Math.abs(o + k) : 0); return h
                                }, _findPos: function(b) { for (var h = this._get(this._getInst(b), "isRTL"); b && (b.type == "hidden" || b.nodeType != 1 || a.expr.filters.hidden(b)); ) b = b[h ? "previousSibling" : "nextSibling"]; b = a(b).offset(); return [b.left, b.top] }, _hideDatepicker: function(b) {
                                    var h = this._curInst; if (!(!h || b && h != a.data(b, "datepicker"))) if (this._datepickerShowing) {
                                        b = this._get(h, "showAnim"); var j = this._get(h, "duration"), l = function() {
                                            a.datepicker._tidyDialog(h); this._curInst =
null
                                        }; a.effects && a.effects[b] ? h.dpDiv.hide(b, a.datepicker._get(h, "showOptions"), j, l) : h.dpDiv[b == "slideDown" ? "slideUp" : b == "fadeIn" ? "fadeOut" : "hide"](b ? j : null, l); b || l(); if (b = this._get(h, "onClose")) b.apply(h.input ? h.input[0] : null, [h.input ? h.input.val() : "", h]); this._datepickerShowing = false; this._lastInput = null; if (this._inDialog) { this._dialogInput.css({ position: "absolute", left: "0", top: "-100px" }); if (a.blockUI) { a.unblockUI(); a("body").append(this.dpDiv) } } this._inDialog = false
                                    } 
                                }, _tidyDialog: function(b) { b.dpDiv.removeClass(this._dialogClass).unbind(".ui-datepicker-calendar") },
                                _checkExternalClick: function(b) { if (a.datepicker._curInst) { b = a(b.target); b[0].id != a.datepicker._mainDivId && b.parents("#" + a.datepicker._mainDivId).length == 0 && !b.hasClass(a.datepicker.markerClassName) && !b.hasClass(a.datepicker._triggerClass) && a.datepicker._datepickerShowing && !(a.datepicker._inDialog && a.blockUI) && a.datepicker._hideDatepicker() } }, _adjustDate: function(b, h, j) {
                                    b = a(b); var l = this._getInst(b[0]); if (!this._isDisabledDatepicker(b[0])) {
                                        this._adjustInstDate(l, h + (j == "M" ? this._get(l, "showCurrentAtPos") :
0), j); this._updateDatepicker(l)
                                    } 
                                }, _gotoToday: function(b) { b = a(b); var h = this._getInst(b[0]); if (this._get(h, "gotoCurrent") && h.currentDay) { h.selectedDay = h.currentDay; h.drawMonth = h.selectedMonth = h.currentMonth; h.drawYear = h.selectedYear = h.currentYear } else { var j = new Date; h.selectedDay = j.getDate(); h.drawMonth = h.selectedMonth = j.getMonth(); h.drawYear = h.selectedYear = j.getFullYear() } this._notifyChange(h); this._adjustDate(b) }, _selectMonthYear: function(b, h, j) {
                                    b = a(b); var l = this._getInst(b[0]); l._selectingMonthYear =
false; l["selected" + (j == "M" ? "Month" : "Year")] = l["draw" + (j == "M" ? "Month" : "Year")] = parseInt(h.options[h.selectedIndex].value, 10); this._notifyChange(l); this._adjustDate(b)
                                }, _clickMonthYear: function(b) { var h = this._getInst(a(b)[0]); h.input && h._selectingMonthYear && setTimeout(function() { h.input.focus() }, 0); h._selectingMonthYear = !h._selectingMonthYear }, _selectDay: function(b, h, j, l) {
                                    var o = a(b); if (!(a(l).hasClass(this._unselectableClass) || this._isDisabledDatepicker(o[0]))) {
                                        o = this._getInst(o[0]); o.selectedDay = o.currentDay =
a("a", l).html(); o.selectedMonth = o.currentMonth = h; o.selectedYear = o.currentYear = j; this._selectDate(b, this._formatDate(o, o.currentDay, o.currentMonth, o.currentYear))
                                    } 
                                }, _clearDate: function(b) { b = a(b); this._getInst(b[0]); this._selectDate(b, "") }, _selectDate: function(b, h) {
                                    b = this._getInst(a(b)[0]); h = h != null ? h : this._formatDate(b); b.input && b.input.val(h); this._updateAlternate(b); var j = this._get(b, "onSelect"); if (j) j.apply(b.input ? b.input[0] : null, [h, b]); else b.input && b.input.trigger("change"); if (b.inline) this._updateDatepicker(b);
                                    else { this._hideDatepicker(); this._lastInput = b.input[0]; typeof b.input[0] != "object" && b.input.focus(); this._lastInput = null } 
                                }, _updateAlternate: function(b) { var h = this._get(b, "altField"); if (h) { var j = this._get(b, "altFormat") || this._get(b, "dateFormat"), l = this._getDate(b), o = this.formatDate(j, l, this._getFormatConfig(b)); a(h).each(function() { a(this).val(o) }) } }, noWeekends: function(b) { b = b.getDay(); return [b > 0 && b < 6, ""] }, iso8601Week: function(b) {
                                    b = new Date(b.getTime()); b.setDate(b.getDate() + 4 - (b.getDay() || 7)); var h =
b.getTime(); b.setMonth(0); b.setDate(1); return Math.floor(Math.round((h - b) / 864E5) / 7) + 1
                                }, parseDate: function(b, h, j) {
                                    if (b == null || h == null) throw "Invalid arguments"; h = typeof h == "object" ? h.toString() : h + ""; if (h == "") return null; var l = (j ? j.shortYearCutoff : null) || this._defaults.shortYearCutoff; l = typeof l != "string" ? l : (new Date).getFullYear() % 100 + parseInt(l, 10); for (var o = (j ? j.dayNamesShort : null) || this._defaults.dayNamesShort, n = (j ? j.dayNames : null) || this._defaults.dayNames, k = (j ? j.monthNamesShort : null) || this._defaults.monthNamesShort,
m = (j ? j.monthNames : null) || this._defaults.monthNames, p = j = -1, q = -1, s = -1, r = false, u = function(y) { (y = G + 1 < b.length && b.charAt(G + 1) == y) && G++; return y }, v = function(y) { var H = u(y); y = new RegExp("^\\d{1," + (y == "@" ? 14 : y == "!" ? 20 : y == "y" && H ? 4 : y == "o" ? 3 : 2) + "}"); y = h.substring(z).match(y); if (!y) throw "Missing number at position " + z; z += y[0].length; return parseInt(y[0], 10) }, w = function(y, H, N) {
    y = a.map(u(y) ? N : H, function(D, E) { return [[E, D]] }).sort(function(D, E) { return -(D[1].length - E[1].length) }); var J = -1; a.each(y, function(D, E) {
        D =
E[1]; if (h.substr(z, D.length).toLowerCase() == D.toLowerCase()) { J = E[0]; z += D.length; return false } 
    }); if (J != -1) return J + 1; else throw "Unknown name at position " + z;
}, x = function() { if (h.charAt(z) != b.charAt(G)) throw "Unexpected literal at position " + z; z++ }, z = 0, G = 0; G < b.length; G++) if (r) if (b.charAt(G) == "'" && !u("'")) r = false; else x(); else switch (b.charAt(G)) {
                                        case "d": q = v("d"); break; case "D": w("D", o, n); break; case "o": s = v("o"); break; case "m": p = v("m"); break; case "M": p = w("M", k, m); break; case "y": j = v("y"); break; case "@": var C =
new Date(v("@")); j = C.getFullYear(); p = C.getMonth() + 1; q = C.getDate(); break; case "!": C = new Date((v("!") - this._ticksTo1970) / 1E4); j = C.getFullYear(); p = C.getMonth() + 1; q = C.getDate(); break; case "'": if (u("'")) x(); else r = true; break; default: x()
                                    } if (j == -1) j = (new Date).getFullYear(); else if (j < 100) j += (new Date).getFullYear() - (new Date).getFullYear() % 100 + (j <= l ? 0 : -100); if (s > -1) { p = 1; q = s; do { l = this._getDaysInMonth(j, p - 1); if (q <= l) break; p++; q -= l } while (1) } C = this._daylightSavingAdjust(new Date(j, p - 1, q)); if (C.getFullYear() !=
j || C.getMonth() + 1 != p || C.getDate() != q) throw "Invalid date"; return C
                                }, ATOM: "yy-mm-dd", COOKIE: "D, dd M yy", ISO_8601: "yy-mm-dd", RFC_822: "D, d M y", RFC_850: "DD, dd-M-y", RFC_1036: "D, d M y", RFC_1123: "D, d M yy", RFC_2822: "D, d M yy", RSS: "D, d M y", TICKS: "!", TIMESTAMP: "@", W3C: "yy-mm-dd", _ticksTo1970: (718685 + Math.floor(492.5) - Math.floor(19.7) + Math.floor(4.925)) * 24 * 60 * 60 * 1E7, formatDate: function(b, h, j) {
                                    if (!h) return ""; var l = (j ? j.dayNamesShort : null) || this._defaults.dayNamesShort, o = (j ? j.dayNames : null) || this._defaults.dayNames,
n = (j ? j.monthNamesShort : null) || this._defaults.monthNamesShort; j = (j ? j.monthNames : null) || this._defaults.monthNames; var k = function(u) { (u = r + 1 < b.length && b.charAt(r + 1) == u) && r++; return u }, m = function(u, v, w) { v = "" + v; if (k(u)) for (; v.length < w; ) v = "0" + v; return v }, p = function(u, v, w, x) { return k(u) ? x[v] : w[v] }, q = "", s = false; if (h) for (var r = 0; r < b.length; r++) if (s) if (b.charAt(r) == "'" && !k("'")) s = false; else q += b.charAt(r); else switch (b.charAt(r)) {
                                        case "d": q += m("d", h.getDate(), 2); break; case "D": q += p("D", h.getDay(), l, o); break;
                                        case "o": q += m("o", (h.getTime() - (new Date(h.getFullYear(), 0, 0)).getTime()) / 864E5, 3); break; case "m": q += m("m", h.getMonth() + 1, 2); break; case "M": q += p("M", h.getMonth(), n, j); break; case "y": q += k("y") ? h.getFullYear() : (h.getYear() % 100 < 10 ? "0" : "") + h.getYear() % 100; break; case "@": q += h.getTime(); break; case "!": q += h.getTime() * 1E4 + this._ticksTo1970; break; case "'": if (k("'")) q += "'"; else s = true; break; default: q += b.charAt(r)
                                    } return q
                                }, _possibleChars: function(b) {
                                    for (var h = "", j = false, l = function(n) {
                                        (n = o + 1 < b.length && b.charAt(o +
1) == n) && o++; return n
                                    }, o = 0; o < b.length; o++) if (j) if (b.charAt(o) == "'" && !l("'")) j = false; else h += b.charAt(o); else switch (b.charAt(o)) { case "d": case "m": case "y": case "@": h += "0123456789"; break; case "D": case "M": return null; case "'": if (l("'")) h += "'"; else j = true; break; default: h += b.charAt(o) } return h
                                }, _get: function(b, h) { return b.settings[h] !== d ? b.settings[h] : this._defaults[h] }, _setDateFromField: function(b, h) {
                                    if (b.input.val() != b.lastVal) {
                                        var j = this._get(b, "dateFormat"), l = b.lastVal = b.input ? b.input.val() : null,
o, n; o = n = this._getDefaultDate(b); var k = this._getFormatConfig(b); try { o = this.parseDate(j, l, k) || n } catch (m) { this.log(m); l = h ? "" : l } b.selectedDay = o.getDate(); b.drawMonth = b.selectedMonth = o.getMonth(); b.drawYear = b.selectedYear = o.getFullYear(); b.currentDay = l ? o.getDate() : 0; b.currentMonth = l ? o.getMonth() : 0; b.currentYear = l ? o.getFullYear() : 0; this._adjustInstDate(b)
                                    } 
                                }, _getDefaultDate: function(b) { return this._restrictMinMax(b, this._determineDate(b, this._get(b, "defaultDate"), new Date)) }, _determineDate: function(b, h,
j) {
                                    var l = function(n) { var k = new Date; k.setDate(k.getDate() + n); return k }, o = function(n) {
                                        try { return a.datepicker.parseDate(a.datepicker._get(b, "dateFormat"), n, a.datepicker._getFormatConfig(b)) } catch (k) { } var m = (n.toLowerCase().match(/^c/) ? a.datepicker._getDate(b) : null) || new Date, p = m.getFullYear(), q = m.getMonth(); m = m.getDate(); for (var s = /([+-]?[0-9]+)\s*(d|D|w|W|m|M|y|Y)?/g, r = s.exec(n); r; ) {
                                            switch (r[2] || "d") {
                                                case "d": case "D": m += parseInt(r[1], 10); break; case "w": case "W": m += parseInt(r[1], 10) * 7; break; case "m": case "M": q +=
parseInt(r[1], 10); m = Math.min(m, a.datepicker._getDaysInMonth(p, q)); break; case "y": case "Y": p += parseInt(r[1], 10); m = Math.min(m, a.datepicker._getDaysInMonth(p, q)); break
                                            } r = s.exec(n)
                                        } return new Date(p, q, m)
                                    }; if (h = (h = h == null || h === "" ? j : typeof h == "string" ? o(h) : typeof h == "number" ? isNaN(h) ? j : l(h) : new Date(h.getTime())) && h.toString() == "Invalid Date" ? j : h) { h.setHours(0); h.setMinutes(0); h.setSeconds(0); h.setMilliseconds(0) } return this._daylightSavingAdjust(h)
                                }, _daylightSavingAdjust: function(b) {
                                    if (!b) return null;
                                    b.setHours(b.getHours() > 12 ? b.getHours() + 2 : 0); return b
                                }, _setDate: function(b, h, j) { var l = !h, o = b.selectedMonth, n = b.selectedYear; h = this._restrictMinMax(b, this._determineDate(b, h, new Date)); b.selectedDay = b.currentDay = h.getDate(); b.drawMonth = b.selectedMonth = b.currentMonth = h.getMonth(); b.drawYear = b.selectedYear = b.currentYear = h.getFullYear(); if ((o != b.selectedMonth || n != b.selectedYear) && !j) this._notifyChange(b); this._adjustInstDate(b); if (b.input) b.input.val(l ? "" : this._formatDate(b)) }, _getDate: function(b) {
                                    return !b.currentYear ||
b.input && b.input.val() == "" ? null : this._daylightSavingAdjust(new Date(b.currentYear, b.currentMonth, b.currentDay))
                                }, _generateHTML: function(b) {
                                    var h = new Date; h = this._daylightSavingAdjust(new Date(h.getFullYear(), h.getMonth(), h.getDate())); var j = this._get(b, "isRTL"), l = this._get(b, "showButtonPanel"), o = this._get(b, "hideIfNoPrevNext"), n = this._get(b, "navigationAsDateFormat"), k = this._getNumberOfMonths(b), m = this._get(b, "showCurrentAtPos"), p = this._get(b, "stepMonths"), q = k[0] != 1 || k[1] != 1, s = this._daylightSavingAdjust(!b.currentDay ?
new Date(9999, 9, 9) : new Date(b.currentYear, b.currentMonth, b.currentDay)), r = this._getMinMaxDate(b, "min"), u = this._getMinMaxDate(b, "max"); m = b.drawMonth - m; var v = b.drawYear; if (m < 0) { m += 12; v-- } if (u) { var w = this._daylightSavingAdjust(new Date(u.getFullYear(), u.getMonth() - k[0] * k[1] + 1, u.getDate())); for (w = r && w < r ? r : w; this._daylightSavingAdjust(new Date(v, m, 1)) > w; ) { m--; if (m < 0) { m = 11; v-- } } } b.drawMonth = m; b.drawYear = v; w = this._get(b, "prevText"); w = !n ? w : this.formatDate(w, this._daylightSavingAdjust(new Date(v, m - p, 1)), this._getFormatConfig(b));
                                    w = this._canAdjustMonth(b, -1, v, m) ? '<a class="ui-datepicker-prev ui-corner-all" onclick="DP_jQuery_' + e + ".datepicker._adjustDate('#" + b.id + "', -" + p + ", 'M');\" title=\"" + w + '"><span class="ui-icon ui-icon-circle-triangle-' + (j ? "e" : "w") + '">' + w + "</span></a>" : o ? "" : '<a class="ui-datepicker-prev ui-corner-all ui-state-disabled" title="' + w + '"><span class="ui-icon ui-icon-circle-triangle-' + (j ? "e" : "w") + '">' + w + "</span></a>"; var x = this._get(b, "nextText"); x = !n ? x : this.formatDate(x, this._daylightSavingAdjust(new Date(v,
m + p, 1)), this._getFormatConfig(b)); o = this._canAdjustMonth(b, +1, v, m) ? '<a class="ui-datepicker-next ui-corner-all" onclick="DP_jQuery_' + e + ".datepicker._adjustDate('#" + b.id + "', +" + p + ", 'M');\" title=\"" + x + '"><span class="ui-icon ui-icon-circle-triangle-' + (j ? "w" : "e") + '">' + x + "</span></a>" : o ? "" : '<a class="ui-datepicker-next ui-corner-all ui-state-disabled" title="' + x + '"><span class="ui-icon ui-icon-circle-triangle-' + (j ? "w" : "e") + '">' + x + "</span></a>"; p = this._get(b, "currentText"); x = this._get(b, "gotoCurrent") &&
b.currentDay ? s : h; p = !n ? p : this.formatDate(p, x, this._getFormatConfig(b)); n = !b.inline ? '<button type="button" class="ui-datepicker-close ui-state-default ui-priority-primary ui-corner-all" onclick="DP_jQuery_' + e + '.datepicker._hideDatepicker();">' + this._get(b, "closeText") + "</button>" : ""; l = l ? '<div class="ui-datepicker-buttonpane ui-widget-content">' + (j ? n : "") + (this._isInRange(b, x) ? '<button type="button" class="ui-datepicker-current ui-state-default ui-priority-secondary ui-corner-all" onclick="DP_jQuery_' +
e + ".datepicker._gotoToday('#" + b.id + "');\">" + p + "</button>" : "") + (j ? "" : n) + "</div>" : ""; n = parseInt(this._get(b, "firstDay"), 10); n = isNaN(n) ? 0 : n; p = this._get(b, "showWeek"); x = this._get(b, "dayNames"); this._get(b, "dayNamesShort"); var z = this._get(b, "dayNamesMin"), G = this._get(b, "monthNames"), C = this._get(b, "monthNamesShort"), y = this._get(b, "beforeShowDay"), H = this._get(b, "showOtherMonths"), N = this._get(b, "selectOtherMonths"); this._get(b, "calculateWeek"); for (var J = this._getDefaultDate(b), D = "", E = 0; E < k[0]; E++) {
                                        for (var P =
"", L = 0; L < k[1]; L++) {
                                            var Q = this._daylightSavingAdjust(new Date(v, m, b.selectedDay)), B = " ui-corner-all", F = ""; if (q) { F += '<div class="ui-datepicker-group'; if (k[1] > 1) switch (L) { case 0: F += " ui-datepicker-group-first"; B = " ui-corner-" + (j ? "right" : "left"); break; case k[1] - 1: F += " ui-datepicker-group-last"; B = " ui-corner-" + (j ? "left" : "right"); break; default: F += " ui-datepicker-group-middle"; B = ""; break } F += '">' } F += '<div class="ui-datepicker-header ui-widget-header ui-helper-clearfix' + B + '">' + (/all|left/.test(B) && E == 0 ? j ?
o : w : "") + (/all|right/.test(B) && E == 0 ? j ? w : o : "") + this._generateMonthYearHeader(b, m, v, r, u, E > 0 || L > 0, G, C) + '</div><table class="ui-datepicker-calendar"><thead><tr>'; var I = p ? '<th class="ui-datepicker-week-col">' + this._get(b, "weekHeader") + "</th>" : ""; for (B = 0; B < 7; B++) { var A = (B + n) % 7; I += "<th" + ((B + n + 6) % 7 >= 5 ? ' class="ui-datepicker-week-end"' : "") + '><span title="' + x[A] + '">' + z[A] + "</span></th>" } F += I + "</tr></thead><tbody>"; I = this._getDaysInMonth(v, m); if (v == b.selectedYear && m == b.selectedMonth) b.selectedDay = Math.min(b.selectedDay,
I); B = (this._getFirstDayOfMonth(v, m) - n + 7) % 7; I = q ? 6 : Math.ceil((B + I) / 7); A = this._daylightSavingAdjust(new Date(v, m, 1 - B)); for (var R = 0; R < I; R++) {
                                                F += "<tr>"; var S = !p ? "" : '<td class="ui-datepicker-week-col">' + this._get(b, "calculateWeek")(A) + "</td>"; for (B = 0; B < 7; B++) {
                                                    var M = y ? y.apply(b.input ? b.input[0] : null, [A]) : [true, ""], K = A.getMonth() != m, O = K && !N || !M[0] || r && A < r || u && A > u; S += '<td class="' + ((B + n + 6) % 7 >= 5 ? " ui-datepicker-week-end" : "") + (K ? " ui-datepicker-other-month" : "") + (A.getTime() == Q.getTime() && m == b.selectedMonth &&
b._keyEvent || J.getTime() == A.getTime() && J.getTime() == Q.getTime() ? " " + this._dayOverClass : "") + (O ? " " + this._unselectableClass + " ui-state-disabled" : "") + (K && !H ? "" : " " + M[1] + (A.getTime() == s.getTime() ? " " + this._currentClass : "") + (A.getTime() == h.getTime() ? " ui-datepicker-today" : "")) + '"' + ((!K || H) && M[2] ? ' title="' + M[2] + '"' : "") + (O ? "" : ' onclick="DP_jQuery_' + e + ".datepicker._selectDay('#" + b.id + "'," + A.getMonth() + "," + A.getFullYear() + ', this);return false;"') + ">" + (K && !H ? "&#xa0;" : O ? '<span class="ui-state-default">' + A.getDate() +
"</span>" : '<a class="ui-state-default' + (A.getTime() == h.getTime() ? " ui-state-highlight" : "") + (A.getTime() == s.getTime() ? " ui-state-active" : "") + (K ? " ui-priority-secondary" : "") + '" href="#">' + A.getDate() + "</a>") + "</td>"; A.setDate(A.getDate() + 1); A = this._daylightSavingAdjust(A)
                                                } F += S + "</tr>"
                                            } m++; if (m > 11) { m = 0; v++ } F += "</tbody></table>" + (q ? "</div>" + (k[0] > 0 && L == k[1] - 1 ? '<div class="ui-datepicker-row-break"></div>' : "") : ""); P += F
                                        } D += P
                                    } D += l + (a.browser.msie && parseInt(a.browser.version, 10) < 7 && !b.inline ? '<iframe src="javascript:false;" class="ui-datepicker-cover" frameborder="0"></iframe>' :
""); b._keyEvent = false; return D
                                }, _generateMonthYearHeader: function(b, h, j, l, o, n, k, m) {
                                    var p = this._get(b, "changeMonth"), q = this._get(b, "changeYear"), s = this._get(b, "showMonthAfterYear"), r = '<div class="ui-datepicker-title">', u = ""; if (n || !p) u += '<span class="ui-datepicker-month">' + k[h] + "</span>"; else {
                                        k = l && l.getFullYear() == j; var v = o && o.getFullYear() == j; u += '<select class="ui-datepicker-month" onchange="DP_jQuery_' + e + ".datepicker._selectMonthYear('#" + b.id + "', this, 'M');\" onclick=\"DP_jQuery_" + e + ".datepicker._clickMonthYear('#" +
b.id + "');\">"; for (var w = 0; w < 12; w++) if ((!k || w >= l.getMonth()) && (!v || w <= o.getMonth())) u += '<option value="' + w + '"' + (w == h ? ' selected="selected"' : "") + ">" + m[w] + "</option>"; u += "</select>"
                                    } s || (r += u + (n || !(p && q) ? "&#xa0;" : "")); if (!b.yearshtml) {
                                        b.yearshtml = ""; if (n || !q) r += '<span class="ui-datepicker-year">' + j + "</span>"; else {
                                            m = this._get(b, "yearRange").split(":"); var x = (new Date).getFullYear(); k = function(z) {
                                                z = z.match(/c[+-].*/) ? j + parseInt(z.substring(1), 10) : z.match(/[+-].*/) ? x + parseInt(z, 10) : parseInt(z, 10); return isNaN(z) ?
x : z
                                            }; h = k(m[0]); m = Math.max(h, k(m[1] || "")); h = l ? Math.max(h, l.getFullYear()) : h; m = o ? Math.min(m, o.getFullYear()) : m; for (b.yearshtml += '<select class="ui-datepicker-year" onchange="DP_jQuery_' + e + ".datepicker._selectMonthYear('#" + b.id + "', this, 'Y');\" onclick=\"DP_jQuery_" + e + ".datepicker._clickMonthYear('#" + b.id + "');\">"; h <= m; h++) b.yearshtml += '<option value="' + h + '"' + (h == j ? ' selected="selected"' : "") + ">" + h + "</option>"; b.yearshtml += "</select>"; r += b.yearshtml; b.yearshtml = null
                                        } 
                                    } r += this._get(b, "yearSuffix"); if (s) r +=
(n || !(p && q) ? "&#xa0;" : "") + u; r += "</div>"; return r
                                }, _adjustInstDate: function(b, h, j) { var l = b.drawYear + (j == "Y" ? h : 0), o = b.drawMonth + (j == "M" ? h : 0); h = Math.min(b.selectedDay, this._getDaysInMonth(l, o)) + (j == "D" ? h : 0); l = this._restrictMinMax(b, this._daylightSavingAdjust(new Date(l, o, h))); b.selectedDay = l.getDate(); b.drawMonth = b.selectedMonth = l.getMonth(); b.drawYear = b.selectedYear = l.getFullYear(); if (j == "M" || j == "Y") this._notifyChange(b) }, _restrictMinMax: function(b, h) {
                                    var j = this._getMinMaxDate(b, "min"); b = this._getMinMaxDate(b,
"max"); h = j && h < j ? j : h; return h = b && h > b ? b : h
                                }, _notifyChange: function(b) { var h = this._get(b, "onChangeMonthYear"); if (h) h.apply(b.input ? b.input[0] : null, [b.selectedYear, b.selectedMonth + 1, b]) }, _getNumberOfMonths: function(b) { b = this._get(b, "numberOfMonths"); return b == null ? [1, 1] : typeof b == "number" ? [1, b] : b }, _getMinMaxDate: function(b, h) { return this._determineDate(b, this._get(b, h + "Date"), null) }, _getDaysInMonth: function(b, h) { return 32 - this._daylightSavingAdjust(new Date(b, h, 32)).getDate() }, _getFirstDayOfMonth: function(b,
h) { return (new Date(b, h, 1)).getDay() }, _canAdjustMonth: function(b, h, j, l) { var o = this._getNumberOfMonths(b); j = this._daylightSavingAdjust(new Date(j, l + (h < 0 ? h : o[0] * o[1]), 1)); h < 0 && j.setDate(this._getDaysInMonth(j.getFullYear(), j.getMonth())); return this._isInRange(b, j) }, _isInRange: function(b, h) { var j = this._getMinMaxDate(b, "min"); b = this._getMinMaxDate(b, "max"); return (!j || h.getTime() >= j.getTime()) && (!b || h.getTime() <= b.getTime()) }, _getFormatConfig: function(b) {
    var h = this._get(b, "shortYearCutoff"); h = typeof h !=
"string" ? h : (new Date).getFullYear() % 100 + parseInt(h, 10); return { shortYearCutoff: h, dayNamesShort: this._get(b, "dayNamesShort"), dayNames: this._get(b, "dayNames"), monthNamesShort: this._get(b, "monthNamesShort"), monthNames: this._get(b, "monthNames")}
}, _formatDate: function(b, h, j, l) {
    if (!h) { b.currentDay = b.selectedDay; b.currentMonth = b.selectedMonth; b.currentYear = b.selectedYear } h = h ? typeof h == "object" ? h : this._daylightSavingAdjust(new Date(l, j, h)) : this._daylightSavingAdjust(new Date(b.currentYear, b.currentMonth, b.currentDay));
    return this.formatDate(this._get(b, "dateFormat"), h, this._getFormatConfig(b))
} 
                            }); a.fn.datepicker = function(b) {
                                if (!this.length) return this; if (!a.datepicker.initialized) { a(document).mousedown(a.datepicker._checkExternalClick).find("body").append(a.datepicker.dpDiv); a.datepicker.initialized = true } var h = Array.prototype.slice.call(arguments, 1); if (typeof b == "string" && (b == "isDisabled" || b == "getDate" || b == "widget")) return a.datepicker["_" + b + "Datepicker"].apply(a.datepicker, [this[0]].concat(h)); if (b == "option" &&
arguments.length == 2 && typeof arguments[1] == "string") return a.datepicker["_" + b + "Datepicker"].apply(a.datepicker, [this[0]].concat(h)); return this.each(function() { typeof b == "string" ? a.datepicker["_" + b + "Datepicker"].apply(a.datepicker, [this].concat(h)) : a.datepicker._attachDatepicker(this, b) })
                            }; a.datepicker = new c; a.datepicker.initialized = false; a.datepicker.uuid = (new Date).getTime(); a.datepicker.version = "1.8.13"; window["DP_jQuery_" + e] = a
                        })(jQuery);
                        (function(a, d) {
                            var c = { buttons: true, height: true, maxHeight: true, maxWidth: true, minHeight: true, minWidth: true, width: true }, f = { maxHeight: true, maxWidth: true, minHeight: true, minWidth: true }, g = a.attrFn || { val: true, css: true, html: true, text: true, data: true, width: true, height: true, offset: true, click: true }; a.widget("ui.dialog", { options: { autoOpen: true, buttons: {}, closeOnEscape: true, closeText: "close", dialogClass: "", draggable: true, hide: null, height: "auto", maxHeight: false, maxWidth: false, minHeight: 150, minWidth: 150, modal: false,
                                position: { my: "center", at: "center", collision: "fit", using: function(e) { var i = a(this).css(e).offset().top; i < 0 && a(this).css("top", e.top - i) } }, resizable: true, show: null, stack: true, title: "", width: 300, zIndex: 1E3
                            }, _create: function() {
                                this.originalTitle = this.element.attr("title"); if (typeof this.originalTitle !== "string") this.originalTitle = ""; this.options.title = this.options.title || this.originalTitle; var e = this, i = e.options, b = i.title || "&#160;", h = a.ui.dialog.getTitleId(e.element), j = (e.uiDialog = a("<div></div>")).appendTo(document.body).hide().addClass("ui-dialog ui-widget ui-widget-content ui-corner-all " +
i.dialogClass).css({ zIndex: i.zIndex }).attr("tabIndex", -1).css("outline", 0).keydown(function(n) { if (i.closeOnEscape && n.keyCode && n.keyCode === a.ui.keyCode.ESCAPE) { e.close(n); n.preventDefault() } }).attr({ role: "dialog", "aria-labelledby": h }).mousedown(function(n) { e.moveToTop(false, n) }); e.element.show().removeAttr("title").addClass("ui-dialog-content ui-widget-content").appendTo(j); var l = (e.uiDialogTitlebar = a("<div></div>")).addClass("ui-dialog-titlebar ui-widget-header ui-corner-all ui-helper-clearfix").prependTo(j),
o = a('<a href="#"></a>').addClass("ui-dialog-titlebar-close ui-corner-all").attr("role", "button").hover(function() { o.addClass("ui-state-hover") }, function() { o.removeClass("ui-state-hover") }).focus(function() { o.addClass("ui-state-focus") }).blur(function() { o.removeClass("ui-state-focus") }).click(function(n) { e.close(n); return false }).appendTo(l); (e.uiDialogTitlebarCloseText = a("<span></span>")).addClass("ui-icon ui-icon-closethick").text(i.closeText).appendTo(o); a("<span></span>").addClass("ui-dialog-title").attr("id",
h).html(b).prependTo(l); if (a.isFunction(i.beforeclose) && !a.isFunction(i.beforeClose)) i.beforeClose = i.beforeclose; l.find("*").add(l).disableSelection(); i.draggable && a.fn.draggable && e._makeDraggable(); i.resizable && a.fn.resizable && e._makeResizable(); e._createButtons(i.buttons); e._isOpen = false; a.fn.bgiframe && j.bgiframe()
                            }, _init: function() { this.options.autoOpen && this.open() }, destroy: function() {
                                var e = this; e.overlay && e.overlay.destroy(); e.uiDialog.hide(); e.element.unbind(".dialog").removeData("dialog").removeClass("ui-dialog-content ui-widget-content").hide().appendTo("body");
                                e.uiDialog.remove(); e.originalTitle && e.element.attr("title", e.originalTitle); return e
                            }, widget: function() { return this.uiDialog }, close: function(e) {
                                var i = this, b, h; if (false !== i._trigger("beforeClose", e)) {
                                    i.overlay && i.overlay.destroy(); i.uiDialog.unbind("keypress.ui-dialog"); i._isOpen = false; if (i.options.hide) i.uiDialog.hide(i.options.hide, function() { i._trigger("close", e) }); else { i.uiDialog.hide(); i._trigger("close", e) } a.ui.dialog.overlay.resize(); if (i.options.modal) {
                                        b = 0; a(".ui-dialog").each(function() {
                                            if (this !==
i.uiDialog[0]) { h = a(this).css("z-index"); isNaN(h) || (b = Math.max(b, h)) } 
                                        }); a.ui.dialog.maxZ = b
                                    } return i
                                } 
                            }, isOpen: function() { return this._isOpen }, moveToTop: function(e, i) {
                                var b = this, h = b.options; if (h.modal && !e || !h.stack && !h.modal) return b._trigger("focus", i); if (h.zIndex > a.ui.dialog.maxZ) a.ui.dialog.maxZ = h.zIndex; if (b.overlay) { a.ui.dialog.maxZ += 1; b.overlay.$el.css("z-index", a.ui.dialog.overlay.maxZ = a.ui.dialog.maxZ) } e = { scrollTop: b.element.attr("scrollTop"), scrollLeft: b.element.attr("scrollLeft") }; a.ui.dialog.maxZ +=
1; b.uiDialog.css("z-index", a.ui.dialog.maxZ); b.element.attr(e); b._trigger("focus", i); return b
                            }, open: function() {
                                if (!this._isOpen) {
                                    var e = this, i = e.options, b = e.uiDialog; e.overlay = i.modal ? new a.ui.dialog.overlay(e) : null; e._size(); e._position(i.position); b.show(i.show); e.moveToTop(true); i.modal && b.bind("keypress.ui-dialog", function(h) {
                                        if (h.keyCode === a.ui.keyCode.TAB) {
                                            var j = a(":tabbable", this), l = j.filter(":first"); j = j.filter(":last"); if (h.target === j[0] && !h.shiftKey) { l.focus(1); return false } else if (h.target ===
l[0] && h.shiftKey) { j.focus(1); return false } 
                                        } 
                                    }); a(e.element.find(":tabbable").get().concat(b.find(".ui-dialog-buttonpane :tabbable").get().concat(b.get()))).eq(0).focus(); e._isOpen = true; e._trigger("open"); return e
                                } 
                            }, _createButtons: function(e) {
                                var i = this, b = false, h = a("<div></div>").addClass("ui-dialog-buttonpane ui-widget-content ui-helper-clearfix"), j = a("<div></div>").addClass("ui-dialog-buttonset").appendTo(h); i.uiDialog.find(".ui-dialog-buttonpane").remove(); typeof e === "object" && e !== null && a.each(e,
function() { return !(b = true) }); if (b) { a.each(e, function(l, o) { o = a.isFunction(o) ? { click: o, text: l} : o; var n = a('<button type="button"></button>').click(function() { o.click.apply(i.element[0], arguments) }).appendTo(j); a.each(o, function(k, m) { if (k !== "click") k in g ? n[k](m) : n.attr(k, m) }); a.fn.button && n.button() }); h.appendTo(i.uiDialog) } 
                            }, _makeDraggable: function() {
                                function e(l) { return { position: l.position, offset: l.offset} } var i = this, b = i.options, h = a(document), j; i.uiDialog.draggable({ cancel: ".ui-dialog-content, .ui-dialog-titlebar-close",
                                    handle: ".ui-dialog-titlebar", containment: "document", start: function(l, o) { j = b.height === "auto" ? "auto" : a(this).height(); a(this).height(a(this).height()).addClass("ui-dialog-dragging"); i._trigger("dragStart", l, e(o)) }, drag: function(l, o) { i._trigger("drag", l, e(o)) }, stop: function(l, o) { b.position = [o.position.left - h.scrollLeft(), o.position.top - h.scrollTop()]; a(this).removeClass("ui-dialog-dragging").height(j); i._trigger("dragStop", l, e(o)); a.ui.dialog.overlay.resize() } 
                                })
                            }, _makeResizable: function(e) {
                                function i(l) {
                                    return { originalPosition: l.originalPosition,
                                        originalSize: l.originalSize, position: l.position, size: l.size}
                                    } e = e === d ? this.options.resizable : e; var b = this, h = b.options, j = b.uiDialog.css("position"); e = typeof e === "string" ? e : "n,e,s,w,se,sw,ne,nw"; b.uiDialog.resizable({ cancel: ".ui-dialog-content", containment: "document", alsoResize: b.element, maxWidth: h.maxWidth, maxHeight: h.maxHeight, minWidth: h.minWidth, minHeight: b._minHeight(), handles: e, start: function(l, o) { a(this).addClass("ui-dialog-resizing"); b._trigger("resizeStart", l, i(o)) }, resize: function(l, o) {
                                        b._trigger("resize",
l, i(o))
                                    }, stop: function(l, o) { a(this).removeClass("ui-dialog-resizing"); h.height = a(this).height(); h.width = a(this).width(); b._trigger("resizeStop", l, i(o)); a.ui.dialog.overlay.resize() } 
                                    }).css("position", j).find(".ui-resizable-se").addClass("ui-icon ui-icon-grip-diagonal-se")
                                }, _minHeight: function() { var e = this.options; return e.height === "auto" ? e.minHeight : Math.min(e.minHeight, e.height) }, _position: function(e) {
                                    var i = [], b = [0, 0], h; if (e) {
                                        if (typeof e === "string" || typeof e === "object" && "0" in e) {
                                            i = e.split ? e.split(" ") :
[e[0], e[1]]; if (i.length === 1) i[1] = i[0]; a.each(["left", "top"], function(j, l) { if (+i[j] === i[j]) { b[j] = i[j]; i[j] = l } }); e = { my: i.join(" "), at: i.join(" "), offset: b.join(" ")}
                                        } e = a.extend({}, a.ui.dialog.prototype.options.position, e)
                                    } else e = a.ui.dialog.prototype.options.position; (h = this.uiDialog.is(":visible")) || this.uiDialog.show(); this.uiDialog.css({ top: 0, left: 0 }).position(a.extend({ of: window }, e)); h || this.uiDialog.hide()
                                }, _setOptions: function(e) {
                                    var i = this, b = {}, h = false; a.each(e, function(j, l) {
                                        i._setOption(j, l);
                                        if (j in c) h = true; if (j in f) b[j] = l
                                    }); h && this._size(); this.uiDialog.is(":data(resizable)") && this.uiDialog.resizable("option", b)
                                }, _setOption: function(e, i) {
                                    var b = this, h = b.uiDialog; switch (e) {
                                        case "beforeclose": e = "beforeClose"; break; case "buttons": b._createButtons(i); break; case "closeText": b.uiDialogTitlebarCloseText.text("" + i); break; case "dialogClass": h.removeClass(b.options.dialogClass).addClass("ui-dialog ui-widget ui-widget-content ui-corner-all " + i); break; case "disabled": i ? h.addClass("ui-dialog-disabled") :
h.removeClass("ui-dialog-disabled"); break; case "draggable": var j = h.is(":data(draggable)"); j && !i && h.draggable("destroy"); !j && i && b._makeDraggable(); break; case "position": b._position(i); break; case "resizable": (j = h.is(":data(resizable)")) && !i && h.resizable("destroy"); j && typeof i === "string" && h.resizable("option", "handles", i); !j && i !== false && b._makeResizable(i); break; case "title": a(".ui-dialog-title", b.uiDialogTitlebar).html("" + (i || "&#160;")); break
                                    } a.Widget.prototype._setOption.apply(b, arguments)
                                }, _size: function() {
                                    var e =
this.options, i, b, h = this.uiDialog.is(":visible"); this.element.show().css({ width: "auto", minHeight: 0, height: 0 }); if (e.minWidth > e.width) e.width = e.minWidth; i = this.uiDialog.css({ height: "auto", width: e.width }).height(); b = Math.max(0, e.minHeight - i); if (e.height === "auto") if (a.support.minHeight) this.element.css({ minHeight: b, height: "auto" }); else { this.uiDialog.show(); e = this.element.css("height", "auto").height(); h || this.uiDialog.hide(); this.element.height(Math.max(e, b)) } else this.element.height(Math.max(e.height -
i, 0)); this.uiDialog.is(":data(resizable)") && this.uiDialog.resizable("option", "minHeight", this._minHeight())
                                } 
                            }); a.extend(a.ui.dialog, { version: "1.8.13", uuid: 0, maxZ: 0, getTitleId: function(e) { e = e.attr("id"); if (!e) { this.uuid += 1; e = this.uuid } return "ui-dialog-title-" + e }, overlay: function(e) { this.$el = a.ui.dialog.overlay.create(e) } }); a.extend(a.ui.dialog.overlay, { instances: [], oldInstances: [], maxZ: 0, events: a.map("focus,mousedown,mouseup,keydown,keypress,click".split(","), function(e) { return e + ".dialog-overlay" }).join(" "),
                                create: function(e) {
                                    if (this.instances.length === 0) { setTimeout(function() { a.ui.dialog.overlay.instances.length && a(document).bind(a.ui.dialog.overlay.events, function(b) { if (a(b.target).zIndex() < a.ui.dialog.overlay.maxZ) return false }) }, 1); a(document).bind("keydown.dialog-overlay", function(b) { if (e.options.closeOnEscape && b.keyCode && b.keyCode === a.ui.keyCode.ESCAPE) { e.close(b); b.preventDefault() } }); a(window).bind("resize.dialog-overlay", a.ui.dialog.overlay.resize) } var i = (this.oldInstances.pop() || a("<div></div>").addClass("ui-widget-overlay")).appendTo(document.body).css({ width: this.width(),
                                        height: this.height()
                                    }); a.fn.bgiframe && i.bgiframe(); this.instances.push(i); return i
                                }, destroy: function(e) { var i = a.inArray(e, this.instances); i != -1 && this.oldInstances.push(this.instances.splice(i, 1)[0]); this.instances.length === 0 && a([document, window]).unbind(".dialog-overlay"); e.remove(); var b = 0; a.each(this.instances, function() { b = Math.max(b, this.css("z-index")) }); this.maxZ = b }, height: function() {
                                    var e, i; if (a.browser.msie && a.browser.version < 7) {
                                        e = Math.max(document.documentElement.scrollHeight, document.body.scrollHeight);
                                        i = Math.max(document.documentElement.offsetHeight, document.body.offsetHeight); return e < i ? a(window).height() + "px" : e + "px"
                                    } else return a(document).height() + "px"
                                }, width: function() { var e, i; if (a.browser.msie && a.browser.version < 7) { e = Math.max(document.documentElement.scrollWidth, document.body.scrollWidth); i = Math.max(document.documentElement.offsetWidth, document.body.offsetWidth); return e < i ? a(window).width() + "px" : e + "px" } else return a(document).width() + "px" }, resize: function() {
                                    var e = a([]); a.each(a.ui.dialog.overlay.instances,
function() { e = e.add(this) }); e.css({ width: 0, height: 0 }).css({ width: a.ui.dialog.overlay.width(), height: a.ui.dialog.overlay.height() })
                                } 
                            }); a.extend(a.ui.dialog.overlay.prototype, { destroy: function() { a.ui.dialog.overlay.destroy(this.$el) } })
                        })(jQuery);
                        (function(a) {
                            a.ui = a.ui || {}; var d = /left|center|right/, c = /top|center|bottom/, f = a.fn.position, g = a.fn.offset; a.fn.position = function(e) {
                                if (!e || !e.of) return f.apply(this, arguments); e = a.extend({}, e); var i = a(e.of), b = i[0], h = (e.collision || "flip").split(" "), j = e.offset ? e.offset.split(" ") : [0, 0], l, o, n; if (b.nodeType === 9) { l = i.width(); o = i.height(); n = { top: 0, left: 0} } else if (b.setTimeout) { l = i.width(); o = i.height(); n = { top: i.scrollTop(), left: i.scrollLeft()} } else if (b.preventDefault) {
                                    e.at = "left top"; l = o = 0; n = { top: e.of.pageY,
                                        left: e.of.pageX}
                                    } else { l = i.outerWidth(); o = i.outerHeight(); n = i.offset() } a.each(["my", "at"], function() { var k = (e[this] || "").split(" "); if (k.length === 1) k = d.test(k[0]) ? k.concat(["center"]) : c.test(k[0]) ? ["center"].concat(k) : ["center", "center"]; k[0] = d.test(k[0]) ? k[0] : "center"; k[1] = c.test(k[1]) ? k[1] : "center"; e[this] = k }); if (h.length === 1) h[1] = h[0]; j[0] = parseInt(j[0], 10) || 0; if (j.length === 1) j[1] = j[0]; j[1] = parseInt(j[1], 10) || 0; if (e.at[0] === "right") n.left += l; else if (e.at[0] === "center") n.left += l / 2; if (e.at[1] === "bottom") n.top +=
o; else if (e.at[1] === "center") n.top += o / 2; n.left += j[0]; n.top += j[1]; return this.each(function() {
    var k = a(this), m = k.outerWidth(), p = k.outerHeight(), q = parseInt(a.curCSS(this, "marginLeft", true)) || 0, s = parseInt(a.curCSS(this, "marginTop", true)) || 0, r = m + q + (parseInt(a.curCSS(this, "marginRight", true)) || 0), u = p + s + (parseInt(a.curCSS(this, "marginBottom", true)) || 0), v = a.extend({}, n), w; if (e.my[0] === "right") v.left -= m; else if (e.my[0] === "center") v.left -= m / 2; if (e.my[1] === "bottom") v.top -= p; else if (e.my[1] === "center") v.top -=
p / 2; v.left = Math.round(v.left); v.top = Math.round(v.top); w = { left: v.left - q, top: v.top - s }; a.each(["left", "top"], function(x, z) { a.ui.position[h[x]] && a.ui.position[h[x]][z](v, { targetWidth: l, targetHeight: o, elemWidth: m, elemHeight: p, collisionPosition: w, collisionWidth: r, collisionHeight: u, offset: j, my: e.my, at: e.at }) }); a.fn.bgiframe && k.bgiframe(); k.offset(a.extend(v, { using: e.using }))
})
                                }; a.ui.position = { fit: { left: function(e, i) {
                                    var b = a(window); b = i.collisionPosition.left + i.collisionWidth - b.width() - b.scrollLeft(); e.left =
b > 0 ? e.left - b : Math.max(e.left - i.collisionPosition.left, e.left)
                                }, top: function(e, i) { var b = a(window); b = i.collisionPosition.top + i.collisionHeight - b.height() - b.scrollTop(); e.top = b > 0 ? e.top - b : Math.max(e.top - i.collisionPosition.top, e.top) } 
                                }, flip: { left: function(e, i) {
                                    if (i.at[0] !== "center") {
                                        var b = a(window); b = i.collisionPosition.left + i.collisionWidth - b.width() - b.scrollLeft(); var h = i.my[0] === "left" ? -i.elemWidth : i.my[0] === "right" ? i.elemWidth : 0, j = i.at[0] === "left" ? i.targetWidth : -i.targetWidth, l = -2 * i.offset[0]; e.left +=
i.collisionPosition.left < 0 ? h + j + l : b > 0 ? h + j + l : 0
                                    } 
                                }, top: function(e, i) { if (i.at[1] !== "center") { var b = a(window); b = i.collisionPosition.top + i.collisionHeight - b.height() - b.scrollTop(); var h = i.my[1] === "top" ? -i.elemHeight : i.my[1] === "bottom" ? i.elemHeight : 0, j = i.at[1] === "top" ? i.targetHeight : -i.targetHeight, l = -2 * i.offset[1]; e.top += i.collisionPosition.top < 0 ? h + j + l : b > 0 ? h + j + l : 0 } } }
                                }; if (!a.offset.setOffset) {
                                    a.offset.setOffset = function(e, i) {
                                        if (/static/.test(a.curCSS(e, "position"))) e.style.position = "relative"; var b = a(e),
h = b.offset(), j = parseInt(a.curCSS(e, "top", true), 10) || 0, l = parseInt(a.curCSS(e, "left", true), 10) || 0; h = { top: i.top - h.top + j, left: i.left - h.left + l }; "using" in i ? i.using.call(e, h) : b.css(h)
                                    }; a.fn.offset = function(e) { var i = this[0]; if (!i || !i.ownerDocument) return null; if (e) return this.each(function() { a.offset.setOffset(this, e) }); return g.call(this) } 
                                } 
                            })(jQuery);
                            (function(a, d) {
                                a.widget("ui.progressbar", { options: { value: 0, max: 100 }, min: 0, _create: function() { this.element.addClass("ui-progressbar ui-widget ui-widget-content ui-corner-all").attr({ role: "progressbar", "aria-valuemin": this.min, "aria-valuemax": this.options.max, "aria-valuenow": this._value() }); this.valueDiv = a("<div class='ui-progressbar-value ui-widget-header ui-corner-left'></div>").appendTo(this.element); this.oldValue = this._value(); this._refreshValue() }, destroy: function() {
                                    this.element.removeClass("ui-progressbar ui-widget ui-widget-content ui-corner-all").removeAttr("role").removeAttr("aria-valuemin").removeAttr("aria-valuemax").removeAttr("aria-valuenow");
                                    this.valueDiv.remove(); a.Widget.prototype.destroy.apply(this, arguments)
                                }, value: function(c) { if (c === d) return this._value(); this._setOption("value", c); return this }, _setOption: function(c, f) { if (c === "value") { this.options.value = f; this._refreshValue(); this._value() === this.options.max && this._trigger("complete") } a.Widget.prototype._setOption.apply(this, arguments) }, _value: function() { var c = this.options.value; if (typeof c !== "number") c = 0; return Math.min(this.options.max, Math.max(this.min, c)) }, _percentage: function() {
                                    return 100 *
this._value() / this.options.max
                                }, _refreshValue: function() { var c = this.value(), f = this._percentage(); if (this.oldValue !== c) { this.oldValue = c; this._trigger("change") } this.valueDiv.toggle(c > this.min).toggleClass("ui-corner-right", c === this.options.max).width(f.toFixed(0) + "%"); this.element.attr("aria-valuenow", c) } 
                                }); a.extend(a.ui.progressbar, { version: "1.8.13" })
                            })(jQuery);
                            (function(a) {
                                a.widget("ui.slider", a.ui.mouse, { widgetEventPrefix: "slide", options: { animate: false, distance: 0, max: 100, min: 0, orientation: "horizontal", range: false, step: 1, value: 0, values: null }, _create: function() {
                                    var d = this, c = this.options, f = this.element.find(".ui-slider-handle").addClass("ui-state-default ui-corner-all"), g = c.values && c.values.length || 1, e = []; this._mouseSliding = this._keySliding = false; this._animateOff = true; this._handleIndex = null; this._detectOrientation(); this._mouseInit(); this.element.addClass("ui-slider ui-slider-" +
this.orientation + " ui-widget ui-widget-content ui-corner-all" + (c.disabled ? " ui-slider-disabled ui-disabled" : "")); this.range = a([]); if (c.range) { if (c.range === true) { if (!c.values) c.values = [this._valueMin(), this._valueMin()]; if (c.values.length && c.values.length !== 2) c.values = [c.values[0], c.values[0]] } this.range = a("<div></div>").appendTo(this.element).addClass("ui-slider-range ui-widget-header" + (c.range === "min" || c.range === "max" ? " ui-slider-range-" + c.range : "")) } for (var i = f.length; i < g; i += 1) e.push("<a class='ui-slider-handle ui-state-default ui-corner-all' href='#'></a>");
                                    this.handles = f.add(a(e.join("")).appendTo(d.element)); this.handle = this.handles.eq(0); this.handles.add(this.range).filter("a").click(function(b) { b.preventDefault() }).hover(function() { c.disabled || a(this).addClass("ui-state-hover") }, function() { a(this).removeClass("ui-state-hover") }).focus(function() { if (c.disabled) a(this).blur(); else { a(".ui-slider .ui-state-focus").removeClass("ui-state-focus"); a(this).addClass("ui-state-focus") } }).blur(function() { a(this).removeClass("ui-state-focus") }); this.handles.each(function(b) {
                                        a(this).data("index.ui-slider-handle",
b)
                                    }); this.handles.keydown(function(b) {
                                        var h = true, j = a(this).data("index.ui-slider-handle"), l, o, n; if (!d.options.disabled) {
                                            switch (b.keyCode) { case a.ui.keyCode.HOME: case a.ui.keyCode.END: case a.ui.keyCode.PAGE_UP: case a.ui.keyCode.PAGE_DOWN: case a.ui.keyCode.UP: case a.ui.keyCode.RIGHT: case a.ui.keyCode.DOWN: case a.ui.keyCode.LEFT: h = false; if (!d._keySliding) { d._keySliding = true; a(this).addClass("ui-state-active"); l = d._start(b, j); if (l === false) return } break } n = d.options.step; l = d.options.values && d.options.values.length ?
(o = d.values(j)) : (o = d.value()); switch (b.keyCode) {
                                                case a.ui.keyCode.HOME: o = d._valueMin(); break; case a.ui.keyCode.END: o = d._valueMax(); break; case a.ui.keyCode.PAGE_UP: o = d._trimAlignValue(l + (d._valueMax() - d._valueMin()) / 5); break; case a.ui.keyCode.PAGE_DOWN: o = d._trimAlignValue(l - (d._valueMax() - d._valueMin()) / 5); break; case a.ui.keyCode.UP: case a.ui.keyCode.RIGHT: if (l === d._valueMax()) return; o = d._trimAlignValue(l + n); break; case a.ui.keyCode.DOWN: case a.ui.keyCode.LEFT: if (l === d._valueMin()) return; o = d._trimAlignValue(l -
n); break
                                            } d._slide(b, j, o); return h
                                        } 
                                    }).keyup(function(b) { var h = a(this).data("index.ui-slider-handle"); if (d._keySliding) { d._keySliding = false; d._stop(b, h); d._change(b, h); a(this).removeClass("ui-state-active") } }); this._refreshValue(); this._animateOff = false
                                }, destroy: function() {
                                    this.handles.remove(); this.range.remove(); this.element.removeClass("ui-slider ui-slider-horizontal ui-slider-vertical ui-slider-disabled ui-widget ui-widget-content ui-corner-all").removeData("slider").unbind(".slider"); this._mouseDestroy();
                                    return this
                                }, _mouseCapture: function(d) {
                                    var c = this.options, f, g, e, i, b; if (c.disabled) return false; this.elementSize = { width: this.element.outerWidth(), height: this.element.outerHeight() }; this.elementOffset = this.element.offset(); f = this._normValueFromMouse({ x: d.pageX, y: d.pageY }); g = this._valueMax() - this._valueMin() + 1; i = this; this.handles.each(function(h) { var j = Math.abs(f - i.values(h)); if (g > j) { g = j; e = a(this); b = h } }); if (c.range === true && this.values(1) === c.min) { b += 1; e = a(this.handles[b]) } if (this._start(d, b) === false) return false;
                                    this._mouseSliding = true; i._handleIndex = b; e.addClass("ui-state-active").focus(); c = e.offset(); this._clickOffset = !a(d.target).parents().andSelf().is(".ui-slider-handle") ? { left: 0, top: 0} : { left: d.pageX - c.left - e.width() / 2, top: d.pageY - c.top - e.height() / 2 - (parseInt(e.css("borderTopWidth"), 10) || 0) - (parseInt(e.css("borderBottomWidth"), 10) || 0) + (parseInt(e.css("marginTop"), 10) || 0) }; this.handles.hasClass("ui-state-hover") || this._slide(d, b, f); return this._animateOff = true
                                }, _mouseStart: function() { return true }, _mouseDrag: function(d) {
                                    var c =
this._normValueFromMouse({ x: d.pageX, y: d.pageY }); this._slide(d, this._handleIndex, c); return false
                                }, _mouseStop: function(d) { this.handles.removeClass("ui-state-active"); this._mouseSliding = false; this._stop(d, this._handleIndex); this._change(d, this._handleIndex); this._clickOffset = this._handleIndex = null; return this._animateOff = false }, _detectOrientation: function() { this.orientation = this.options.orientation === "vertical" ? "vertical" : "horizontal" }, _normValueFromMouse: function(d) {
                                    var c; if (this.orientation === "horizontal") {
                                        c =
this.elementSize.width; d = d.x - this.elementOffset.left - (this._clickOffset ? this._clickOffset.left : 0)
                                    } else { c = this.elementSize.height; d = d.y - this.elementOffset.top - (this._clickOffset ? this._clickOffset.top : 0) } c = d / c; if (c > 1) c = 1; if (c < 0) c = 0; if (this.orientation === "vertical") c = 1 - c; d = this._valueMax() - this._valueMin(); return this._trimAlignValue(this._valueMin() + c * d)
                                }, _start: function(d, c) {
                                    var f = { handle: this.handles[c], value: this.value() }; if (this.options.values && this.options.values.length) {
                                        f.value = this.values(c);
                                        f.values = this.values()
                                    } return this._trigger("start", d, f)
                                }, _slide: function(d, c, f) {
                                    var g; if (this.options.values && this.options.values.length) { g = this.values(c ? 0 : 1); if (this.options.values.length === 2 && this.options.range === true && (c === 0 && f > g || c === 1 && f < g)) f = g; if (f !== this.values(c)) { g = this.values(); g[c] = f; d = this._trigger("slide", d, { handle: this.handles[c], value: f, values: g }); this.values(c ? 0 : 1); d !== false && this.values(c, f, true) } } else if (f !== this.value()) {
                                        d = this._trigger("slide", d, { handle: this.handles[c], value: f });
                                        d !== false && this.value(f)
                                    } 
                                }, _stop: function(d, c) { var f = { handle: this.handles[c], value: this.value() }; if (this.options.values && this.options.values.length) { f.value = this.values(c); f.values = this.values() } this._trigger("stop", d, f) }, _change: function(d, c) { if (!this._keySliding && !this._mouseSliding) { var f = { handle: this.handles[c], value: this.value() }; if (this.options.values && this.options.values.length) { f.value = this.values(c); f.values = this.values() } this._trigger("change", d, f) } }, value: function(d) {
                                    if (arguments.length) {
                                        this.options.value =
this._trimAlignValue(d); this._refreshValue(); this._change(null, 0)
                                    } else return this._value()
                                }, values: function(d, c) {
                                    var f, g, e; if (arguments.length > 1) { this.options.values[d] = this._trimAlignValue(c); this._refreshValue(); this._change(null, d) } else if (arguments.length) if (a.isArray(arguments[0])) { f = this.options.values; g = arguments[0]; for (e = 0; e < f.length; e += 1) { f[e] = this._trimAlignValue(g[e]); this._change(null, e) } this._refreshValue() } else return this.options.values && this.options.values.length ? this._values(d) :
this.value(); else return this._values()
                                }, _setOption: function(d, c) {
                                    var f, g = 0; if (a.isArray(this.options.values)) g = this.options.values.length; a.Widget.prototype._setOption.apply(this, arguments); switch (d) {
                                        case "disabled": if (c) { this.handles.filter(".ui-state-focus").blur(); this.handles.removeClass("ui-state-hover"); this.handles.attr("disabled", "disabled"); this.element.addClass("ui-disabled") } else { this.handles.removeAttr("disabled"); this.element.removeClass("ui-disabled") } break; case "orientation": this._detectOrientation();
                                            this.element.removeClass("ui-slider-horizontal ui-slider-vertical").addClass("ui-slider-" + this.orientation); this._refreshValue(); break; case "value": this._animateOff = true; this._refreshValue(); this._change(null, 0); this._animateOff = false; break; case "values": this._animateOff = true; this._refreshValue(); for (f = 0; f < g; f += 1) this._change(null, f); this._animateOff = false; break
                                    } 
                                }, _value: function() { var d = this.options.value; return d = this._trimAlignValue(d) }, _values: function(d) {
                                    var c, f; if (arguments.length) {
                                        c = this.options.values[d];
                                        return c = this._trimAlignValue(c)
                                    } else { c = this.options.values.slice(); for (f = 0; f < c.length; f += 1) c[f] = this._trimAlignValue(c[f]); return c } 
                                }, _trimAlignValue: function(d) { if (d <= this._valueMin()) return this._valueMin(); if (d >= this._valueMax()) return this._valueMax(); var c = this.options.step > 0 ? this.options.step : 1, f = (d - this._valueMin()) % c; alignValue = d - f; if (Math.abs(f) * 2 >= c) alignValue += f > 0 ? c : -c; return parseFloat(alignValue.toFixed(5)) }, _valueMin: function() { return this.options.min }, _valueMax: function() { return this.options.max },
                                    _refreshValue: function() {
                                        var d = this.options.range, c = this.options, f = this, g = !this._animateOff ? c.animate : false, e, i = {}, b, h, j, l; if (this.options.values && this.options.values.length) this.handles.each(function(o) {
                                            e = (f.values(o) - f._valueMin()) / (f._valueMax() - f._valueMin()) * 100; i[f.orientation === "horizontal" ? "left" : "bottom"] = e + "%"; a(this).stop(1, 1)[g ? "animate" : "css"](i, c.animate); if (f.options.range === true) if (f.orientation === "horizontal") {
                                                if (o === 0) f.range.stop(1, 1)[g ? "animate" : "css"]({ left: e + "%" }, c.animate);
                                                if (o === 1) f.range[g ? "animate" : "css"]({ width: e - b + "%" }, { queue: false, duration: c.animate })
                                            } else { if (o === 0) f.range.stop(1, 1)[g ? "animate" : "css"]({ bottom: e + "%" }, c.animate); if (o === 1) f.range[g ? "animate" : "css"]({ height: e - b + "%" }, { queue: false, duration: c.animate }) } b = e
                                        }); else {
                                            h = this.value(); j = this._valueMin(); l = this._valueMax(); e = l !== j ? (h - j) / (l - j) * 100 : 0; i[f.orientation === "horizontal" ? "left" : "bottom"] = e + "%"; this.handle.stop(1, 1)[g ? "animate" : "css"](i, c.animate); if (d === "min" && this.orientation === "horizontal") this.range.stop(1,
1)[g ? "animate" : "css"]({ width: e + "%" }, c.animate); if (d === "max" && this.orientation === "horizontal") this.range[g ? "animate" : "css"]({ width: 100 - e + "%" }, { queue: false, duration: c.animate }); if (d === "min" && this.orientation === "vertical") this.range.stop(1, 1)[g ? "animate" : "css"]({ height: e + "%" }, c.animate); if (d === "max" && this.orientation === "vertical") this.range[g ? "animate" : "css"]({ height: 100 - e + "%" }, { queue: false, duration: c.animate })
                                        } 
                                    } 
                                }); a.extend(a.ui.slider, { version: "1.8.13" })
                            })(jQuery);
                            (function(a, d) {
                                function c() { return ++g } function f() { return ++e } var g = 0, e = 0; a.widget("ui.tabs", { options: { add: null, ajaxOptions: null, cache: false, cookie: null, collapsible: false, disable: null, disabled: [], enable: null, event: "click", fx: null, idPrefix: "ui-tabs-", load: null, panelTemplate: "<div></div>", remove: null, select: null, show: null, spinner: "<em>Loading&#8230;</em>", tabTemplate: "<li><a href='#{href}'><span>#{label}</span></a></li>" }, _create: function() { this._tabify(true) }, _setOption: function(i, b) {
                                    if (i == "selected") this.options.collapsible &&
b == this.options.selected || this.select(b); else { this.options[i] = b; this._tabify() } 
                                }, _tabId: function(i) { return i.title && i.title.replace(/\s/g, "_").replace(/[^\w\u00c0-\uFFFF-]/g, "") || this.options.idPrefix + c() }, _sanitizeSelector: function(i) { return i.replace(/:/g, "\\:") }, _cookie: function() { var i = this.cookie || (this.cookie = this.options.cookie.name || "ui-tabs-" + f()); return a.cookie.apply(null, [i].concat(a.makeArray(arguments))) }, _ui: function(i, b) { return { tab: i, panel: b, index: this.anchors.index(i)} }, _cleanup: function() {
                                    this.lis.filter(".ui-state-processing").removeClass("ui-state-processing").find("span:data(label.tabs)").each(function() {
                                        var i =
a(this); i.html(i.data("label.tabs")).removeData("label.tabs")
                                    })
                                }, _tabify: function(i) {
                                    function b(r, u) { r.css("display", ""); !a.support.opacity && u.opacity && r[0].style.removeAttribute("filter") } var h = this, j = this.options, l = /^#.+/; this.list = this.element.find("ol,ul").eq(0); this.lis = a(" > li:has(a[href])", this.list); this.anchors = this.lis.map(function() { return a("a", this)[0] }); this.panels = a([]); this.anchors.each(function(r, u) {
                                        var v = a(u).attr("href"), w = v.split("#")[0], x; if (w && (w === location.toString().split("#")[0] ||
(x = a("base")[0]) && w === x.href)) { v = u.hash; u.href = v } if (l.test(v)) h.panels = h.panels.add(h.element.find(h._sanitizeSelector(v))); else if (v && v !== "#") { a.data(u, "href.tabs", v); a.data(u, "load.tabs", v.replace(/#.*$/, "")); v = h._tabId(u); u.href = "#" + v; u = h.element.find("#" + v); if (!u.length) { u = a(j.panelTemplate).attr("id", v).addClass("ui-tabs-panel ui-widget-content ui-corner-bottom").insertAfter(h.panels[r - 1] || h.list); u.data("destroy.tabs", true) } h.panels = h.panels.add(u) } else j.disabled.push(r)
                                    }); if (i) {
                                        this.element.addClass("ui-tabs ui-widget ui-widget-content ui-corner-all");
                                        this.list.addClass("ui-tabs-nav ui-helper-reset ui-helper-clearfix ui-widget-header ui-corner-all"); this.lis.addClass("ui-state-default ui-corner-top"); this.panels.addClass("ui-tabs-panel ui-widget-content ui-corner-bottom"); if (j.selected === d) {
                                            location.hash && this.anchors.each(function(r, u) { if (u.hash == location.hash) { j.selected = r; return false } }); if (typeof j.selected !== "number" && j.cookie) j.selected = parseInt(h._cookie(), 10); if (typeof j.selected !== "number" && this.lis.filter(".ui-tabs-selected").length) j.selected =
this.lis.index(this.lis.filter(".ui-tabs-selected")); j.selected = j.selected || (this.lis.length ? 0 : -1)
                                        } else if (j.selected === null) j.selected = -1; j.selected = j.selected >= 0 && this.anchors[j.selected] || j.selected < 0 ? j.selected : 0; j.disabled = a.unique(j.disabled.concat(a.map(this.lis.filter(".ui-state-disabled"), function(r) { return h.lis.index(r) }))).sort(); a.inArray(j.selected, j.disabled) != -1 && j.disabled.splice(a.inArray(j.selected, j.disabled), 1); this.panels.addClass("ui-tabs-hide"); this.lis.removeClass("ui-tabs-selected ui-state-active");
                                        if (j.selected >= 0 && this.anchors.length) { h.element.find(h._sanitizeSelector(h.anchors[j.selected].hash)).removeClass("ui-tabs-hide"); this.lis.eq(j.selected).addClass("ui-tabs-selected ui-state-active"); h.element.queue("tabs", function() { h._trigger("show", null, h._ui(h.anchors[j.selected], h.element.find(h._sanitizeSelector(h.anchors[j.selected].hash))[0])) }); this.load(j.selected) } a(window).bind("unload", function() { h.lis.add(h.anchors).unbind(".tabs"); h.lis = h.anchors = h.panels = null })
                                    } else j.selected = this.lis.index(this.lis.filter(".ui-tabs-selected"));
                                    this.element[j.collapsible ? "addClass" : "removeClass"]("ui-tabs-collapsible"); j.cookie && this._cookie(j.selected, j.cookie); i = 0; for (var o; o = this.lis[i]; i++) a(o)[a.inArray(i, j.disabled) != -1 && !a(o).hasClass("ui-tabs-selected") ? "addClass" : "removeClass"]("ui-state-disabled"); j.cache === false && this.anchors.removeData("cache.tabs"); this.lis.add(this.anchors).unbind(".tabs"); if (j.event !== "mouseover") {
                                        var n = function(r, u) { u.is(":not(.ui-state-disabled)") && u.addClass("ui-state-" + r) }, k = function(r, u) {
                                            u.removeClass("ui-state-" +
r)
                                        }; this.lis.bind("mouseover.tabs", function() { n("hover", a(this)) }); this.lis.bind("mouseout.tabs", function() { k("hover", a(this)) }); this.anchors.bind("focus.tabs", function() { n("focus", a(this).closest("li")) }); this.anchors.bind("blur.tabs", function() { k("focus", a(this).closest("li")) })
                                    } var m, p; if (j.fx) if (a.isArray(j.fx)) { m = j.fx[0]; p = j.fx[1] } else m = p = j.fx; var q = p ? function(r, u) {
                                        a(r).closest("li").addClass("ui-tabs-selected ui-state-active"); u.hide().removeClass("ui-tabs-hide").animate(p, p.duration || "normal",
function() { b(u, p); h._trigger("show", null, h._ui(r, u[0])) })
                                    } : function(r, u) { a(r).closest("li").addClass("ui-tabs-selected ui-state-active"); u.removeClass("ui-tabs-hide"); h._trigger("show", null, h._ui(r, u[0])) }, s = m ? function(r, u) { u.animate(m, m.duration || "normal", function() { h.lis.removeClass("ui-tabs-selected ui-state-active"); u.addClass("ui-tabs-hide"); b(u, m); h.element.dequeue("tabs") }) } : function(r, u) { h.lis.removeClass("ui-tabs-selected ui-state-active"); u.addClass("ui-tabs-hide"); h.element.dequeue("tabs") };
                                    this.anchors.bind(j.event + ".tabs", function() {
                                        var r = this, u = a(r).closest("li"), v = h.panels.filter(":not(.ui-tabs-hide)"), w = h.element.find(h._sanitizeSelector(r.hash)); if (u.hasClass("ui-tabs-selected") && !j.collapsible || u.hasClass("ui-state-disabled") || u.hasClass("ui-state-processing") || h.panels.filter(":animated").length || h._trigger("select", null, h._ui(this, w[0])) === false) { this.blur(); return false } j.selected = h.anchors.index(this); h.abort(); if (j.collapsible) if (u.hasClass("ui-tabs-selected")) {
                                            j.selected =
-1; j.cookie && h._cookie(j.selected, j.cookie); h.element.queue("tabs", function() { s(r, v) }).dequeue("tabs"); this.blur(); return false
                                        } else if (!v.length) { j.cookie && h._cookie(j.selected, j.cookie); h.element.queue("tabs", function() { q(r, w) }); h.load(h.anchors.index(this)); this.blur(); return false } j.cookie && h._cookie(j.selected, j.cookie); if (w.length) { v.length && h.element.queue("tabs", function() { s(r, v) }); h.element.queue("tabs", function() { q(r, w) }); h.load(h.anchors.index(this)) } else throw "jQuery UI Tabs: Mismatching fragment identifier.";
                                        a.browser.msie && this.blur()
                                    }); this.anchors.bind("click.tabs", function() { return false })
                                }, _getIndex: function(i) { if (typeof i == "string") i = this.anchors.index(this.anchors.filter("[href$=" + i + "]")); return i }, destroy: function() {
                                    var i = this.options; this.abort(); this.element.unbind(".tabs").removeClass("ui-tabs ui-widget ui-widget-content ui-corner-all ui-tabs-collapsible").removeData("tabs"); this.list.removeClass("ui-tabs-nav ui-helper-reset ui-helper-clearfix ui-widget-header ui-corner-all"); this.anchors.each(function() {
                                        var b =
a.data(this, "href.tabs"); if (b) this.href = b; var h = a(this).unbind(".tabs"); a.each(["href", "load", "cache"], function(j, l) { h.removeData(l + ".tabs") })
                                    }); this.lis.unbind(".tabs").add(this.panels).each(function() { a.data(this, "destroy.tabs") ? a(this).remove() : a(this).removeClass("ui-state-default ui-corner-top ui-tabs-selected ui-state-active ui-state-hover ui-state-focus ui-state-disabled ui-tabs-panel ui-widget-content ui-corner-bottom ui-tabs-hide") }); i.cookie && this._cookie(null, i.cookie); return this
                                }, add: function(i,
b, h) {
                                    if (h === d) h = this.anchors.length; var j = this, l = this.options; b = a(l.tabTemplate.replace(/#\{href\}/g, i).replace(/#\{label\}/g, b)); i = !i.indexOf("#") ? i.replace("#", "") : this._tabId(a("a", b)[0]); b.addClass("ui-state-default ui-corner-top").data("destroy.tabs", true); var o = j.element.find("#" + i); o.length || (o = a(l.panelTemplate).attr("id", i).data("destroy.tabs", true)); o.addClass("ui-tabs-panel ui-widget-content ui-corner-bottom ui-tabs-hide"); if (h >= this.lis.length) { b.appendTo(this.list); o.appendTo(this.list[0].parentNode) } else {
                                        b.insertBefore(this.lis[h]);
                                        o.insertBefore(this.panels[h])
                                    } l.disabled = a.map(l.disabled, function(n) { return n >= h ? ++n : n }); this._tabify(); if (this.anchors.length == 1) { l.selected = 0; b.addClass("ui-tabs-selected ui-state-active"); o.removeClass("ui-tabs-hide"); this.element.queue("tabs", function() { j._trigger("show", null, j._ui(j.anchors[0], j.panels[0])) }); this.load(0) } this._trigger("add", null, this._ui(this.anchors[h], this.panels[h])); return this
                                }, remove: function(i) {
                                    i = this._getIndex(i); var b = this.options, h = this.lis.eq(i).remove(), j = this.panels.eq(i).remove();
                                    if (h.hasClass("ui-tabs-selected") && this.anchors.length > 1) this.select(i + (i + 1 < this.anchors.length ? 1 : -1)); b.disabled = a.map(a.grep(b.disabled, function(l) { return l != i }), function(l) { return l >= i ? --l : l }); this._tabify(); this._trigger("remove", null, this._ui(h.find("a")[0], j[0])); return this
                                }, enable: function(i) {
                                    i = this._getIndex(i); var b = this.options; if (a.inArray(i, b.disabled) != -1) {
                                        this.lis.eq(i).removeClass("ui-state-disabled"); b.disabled = a.grep(b.disabled, function(h) { return h != i }); this._trigger("enable", null,
this._ui(this.anchors[i], this.panels[i])); return this
                                    } 
                                }, disable: function(i) { i = this._getIndex(i); var b = this.options; if (i != b.selected) { this.lis.eq(i).addClass("ui-state-disabled"); b.disabled.push(i); b.disabled.sort(); this._trigger("disable", null, this._ui(this.anchors[i], this.panels[i])) } return this }, select: function(i) { i = this._getIndex(i); if (i == -1) if (this.options.collapsible && this.options.selected != -1) i = this.options.selected; else return this; this.anchors.eq(i).trigger(this.options.event + ".tabs"); return this },
                                    load: function(i) {
                                        i = this._getIndex(i); var b = this, h = this.options, j = this.anchors.eq(i)[0], l = a.data(j, "load.tabs"); this.abort(); if (!l || this.element.queue("tabs").length !== 0 && a.data(j, "cache.tabs")) this.element.dequeue("tabs"); else {
                                            this.lis.eq(i).addClass("ui-state-processing"); if (h.spinner) { var o = a("span", j); o.data("label.tabs", o.html()).html(h.spinner) } this.xhr = a.ajax(a.extend({}, h.ajaxOptions, { url: l, success: function(n, k) {
                                                b.element.find(b._sanitizeSelector(j.hash)).html(n); b._cleanup(); h.cache && a.data(j,
"cache.tabs", true); b._trigger("load", null, b._ui(b.anchors[i], b.panels[i])); try { h.ajaxOptions.success(n, k) } catch (m) { } 
                                            }, error: function(n, k) { b._cleanup(); b._trigger("load", null, b._ui(b.anchors[i], b.panels[i])); try { h.ajaxOptions.error(n, k, i, j) } catch (m) { } } 
                                            })); b.element.dequeue("tabs"); return this
                                        } 
                                    }, abort: function() { this.element.queue([]); this.panels.stop(false, true); this.element.queue("tabs", this.element.queue("tabs").splice(-2, 2)); if (this.xhr) { this.xhr.abort(); delete this.xhr } this._cleanup(); return this },
                                    url: function(i, b) { this.anchors.eq(i).removeData("cache.tabs").data("load.tabs", b); return this }, length: function() { return this.anchors.length } 
                                }); a.extend(a.ui.tabs, { version: "1.8.13" }); a.extend(a.ui.tabs.prototype, { rotation: null, rotate: function(i, b) {
                                    var h = this, j = this.options, l = h._rotate || (h._rotate = function(o) { clearTimeout(h.rotation); h.rotation = setTimeout(function() { var n = j.selected; h.select(++n < h.anchors.length ? n : 0) }, i); o && o.stopPropagation() }); b = h._unrotate || (h._unrotate = !b ? function(o) {
                                        o.clientX &&
h.rotate(null)
                                    } : function() { t = j.selected; l() }); if (i) { this.element.bind("tabsshow", l); this.anchors.bind(j.event + ".tabs", b); l() } else { clearTimeout(h.rotation); this.element.unbind("tabsshow", l); this.anchors.unbind(j.event + ".tabs", b); delete this._rotate; delete this._unrotate } return this
                                } 
                                })
                            })(jQuery);