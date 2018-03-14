a=Array.prototype.slice.call(document.querySelectorAll("p.artist_search"));
b=Array.prototype.slice.call(document.querySelectorAll("span.w"));
var tab = window.open('about:blank', '_blank');
for(i=a.length-1; i>0; i--) {
  tab.document.write('"'+b[i-1].innerHTML+'","'+a[i].innerHTML+'"<br>');
}
tab.document.close();
