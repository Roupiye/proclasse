// morphdom@2.6.1 downloaded from https://ga.jspm.io/npm:morphdom@2.6.1/dist/morphdom.js

var e={};var r=11;function morphAttrs(e,t){var a=t.attributes;var n;var o;var i;var d;var l;if(t.nodeType!==r&&e.nodeType!==r){for(var u=a.length-1;u>=0;u--){n=a[u];o=n.name;i=n.namespaceURI;d=n.value;if(i){o=n.localName||o;l=e.getAttributeNS(i,o);if(l!==d){"xmlns"===n.prefix&&(o=n.name);e.setAttributeNS(i,o,d)}}else{l=e.getAttribute(o);l!==d&&e.setAttribute(o,d)}}var f=e.attributes;for(var v=f.length-1;v>=0;v--){n=f[v];o=n.name;i=n.namespaceURI;if(i){o=n.localName||o;t.hasAttributeNS(i,o)||e.removeAttributeNS(i,o)}else t.hasAttribute(o)||e.removeAttribute(o)}}}var t;var a="http://www.w3.org/1999/xhtml";var n="undefined"===typeof document?void 0:document;var o=!!n&&"content"in n.createElement("template");var i=!!n&&n.createRange&&"createContextualFragment"in n.createRange();function createFragmentFromTemplate(e){var r=n.createElement("template");r.innerHTML=e;return r.content.childNodes[0]}function createFragmentFromRange(e){if(!t){t=n.createRange();t.selectNode(n.body)}var r=t.createContextualFragment(e);return r.childNodes[0]}function createFragmentFromWrap(e){var r=n.createElement("body");r.innerHTML=e;return r.childNodes[0]}function toElement(e){e=e.trim();return o?createFragmentFromTemplate(e):i?createFragmentFromRange(e):createFragmentFromWrap(e)}function compareNodeNames(e,r){var t=e.nodeName;var a=r.nodeName;var n,o;if(t===a)return true;n=t.charCodeAt(0);o=a.charCodeAt(0);return n<=90&&o>=97?t===a.toUpperCase():o<=90&&n>=97&&a===t.toUpperCase()}function createElementNS(e,r){return r&&r!==a?n.createElementNS(r,e):n.createElement(e)}function moveChildren(e,r){var t=e.firstChild;while(t){var a=t.nextSibling;r.appendChild(t);t=a}return r}function syncBooleanAttrProp(e,r,t){if(e[t]!==r[t]){e[t]=r[t];e[t]?e.setAttribute(t,""):e.removeAttribute(t)}}var d={OPTION:function(e,r){var t=e.parentNode;if(t){var a=t.nodeName.toUpperCase();if("OPTGROUP"===a){t=t.parentNode;a=t&&t.nodeName.toUpperCase()}if("SELECT"===a&&!t.hasAttribute("multiple")){if(e.hasAttribute("selected")&&!r.selected){e.setAttribute("selected","selected");e.removeAttribute("selected")}t.selectedIndex=-1}}syncBooleanAttrProp(e,r,"selected")},INPUT:function(e,r){syncBooleanAttrProp(e,r,"checked");syncBooleanAttrProp(e,r,"disabled");e.value!==r.value&&(e.value=r.value);r.hasAttribute("value")||e.removeAttribute("value")},TEXTAREA:function(e,r){var t=r.value;e.value!==t&&(e.value=t);var a=e.firstChild;if(a){var n=a.nodeValue;if(n==t||!t&&n==e.placeholder)return;a.nodeValue=t}},SELECT:function(e,r){if(!r.hasAttribute("multiple")){var t=-1;var a=0;var n=e.firstChild;var o;var i;while(n){i=n.nodeName&&n.nodeName.toUpperCase();if("OPTGROUP"===i){o=n;n=o.firstChild}else{if("OPTION"===i){if(n.hasAttribute("selected")){t=a;break}a++}n=n.nextSibling;if(!n&&o){n=o.nextSibling;o=null}}}e.selectedIndex=t}}};var l=1;var u=11;var f=3;var v=8;function noop(){}function defaultGetNodeKey(e){if(e)return e.getAttribute&&e.getAttribute("id")||e.id}function morphdomFactory(e){return function morphdom(r,t,a){a||(a={});if("string"===typeof t)if("#document"===r.nodeName||"HTML"===r.nodeName||"BODY"===r.nodeName){var o=t;t=n.createElement("html");t.innerHTML=o}else t=toElement(t);var i=a.getNodeKey||defaultGetNodeKey;var m=a.onBeforeNodeAdded||noop;var c=a.onNodeAdded||noop;var s=a.onBeforeElUpdated||noop;var p=a.onElUpdated||noop;var h=a.onBeforeNodeDiscarded||noop;var N=a.onNodeDiscarded||noop;var A=a.onBeforeElChildrenUpdated||noop;var b=true===a.childrenOnly;var C=Object.create(null);var g=[];function addKeyedRemoval(e){g.push(e)}function walkDiscardedChildNodes(e,r){if(e.nodeType===l){var t=e.firstChild;while(t){var a=void 0;if(r&&(a=i(t)))addKeyedRemoval(a);else{N(t);t.firstChild&&walkDiscardedChildNodes(t,r)}t=t.nextSibling}}}function removeNode(e,r,t){if(false!==h(e)){r&&r.removeChild(e);N(e);walkDiscardedChildNodes(e,t)}}function indexTree(e){if(e.nodeType===l||e.nodeType===u){var r=e.firstChild;while(r){var t=i(r);t&&(C[t]=r);indexTree(r);r=r.nextSibling}}}indexTree(r);function handleNodeAdded(e){c(e);var r=e.firstChild;while(r){var t=r.nextSibling;var a=i(r);if(a){var n=C[a];if(n&&compareNodeNames(r,n)){r.parentNode.replaceChild(n,r);morphEl(n,r)}else handleNodeAdded(r)}else handleNodeAdded(r);r=t}}function cleanupFromEl(e,r,t){while(r){var a=r.nextSibling;(t=i(r))?addKeyedRemoval(t):removeNode(r,e,true);r=a}}function morphEl(r,t,a){var n=i(t);n&&delete C[n];if(!a){if(false===s(r,t))return;e(r,t);p(r);if(false===A(r,t))return}"TEXTAREA"!==r.nodeName?morphChildren(r,t):d.TEXTAREA(r,t)}function morphChildren(e,r){var t=r.firstChild;var a=e.firstChild;var o;var u;var c;var s;var p;e:while(t){s=t.nextSibling;o=i(t);while(a){c=a.nextSibling;if(t.isSameNode&&t.isSameNode(a)){t=s;a=c;continue e}u=i(a);var h=a.nodeType;var N=void 0;if(h===t.nodeType)if(h===l){if(o){if(o!==u)if(p=C[o])if(c===p)N=false;else{e.insertBefore(p,a);u?addKeyedRemoval(u):removeNode(a,e,true);a=p}else N=false}else u&&(N=false);N=false!==N&&compareNodeNames(a,t);N&&morphEl(a,t)}else if(h===f||h==v){N=true;a.nodeValue!==t.nodeValue&&(a.nodeValue=t.nodeValue)}if(N){t=s;a=c;continue e}u?addKeyedRemoval(u):removeNode(a,e,true);a=c}if(o&&(p=C[o])&&compareNodeNames(p,t)){e.appendChild(p);morphEl(p,t)}else{var A=m(t);if(false!==A){A&&(t=A);t.actualize&&(t=t.actualize(e.ownerDocument||n));e.appendChild(t);handleNodeAdded(t)}}t=s;a=c}cleanupFromEl(e,a,u);var b=d[e.nodeName];b&&b(e,r)}var T=r;var E=T.nodeType;var y=t.nodeType;if(!b)if(E===l)if(y===l){if(!compareNodeNames(r,t)){N(r);T=moveChildren(r,createElementNS(t.nodeName,t.namespaceURI))}}else T=t;else if(E===f||E===v){if(y===E){T.nodeValue!==t.nodeValue&&(T.nodeValue=t.nodeValue);return T}T=t}if(T===t)N(r);else{if(t.isSameNode&&t.isSameNode(T))return;morphEl(T,t,b);if(g)for(var S=0,x=g.length;S<x;S++){var F=C[g[S]];F&&removeNode(F,F.parentNode,false)}}if(!b&&T!==r&&r.parentNode){T.actualize&&(T=T.actualize(r.ownerDocument||n));r.parentNode.replaceChild(T,r)}return T}}var m=morphdomFactory(morphAttrs);e=m;var c=e;export default c;

