(function () {
  var cd_max,cd_min,tbs,n;
  if (!isGoogle()) {
    alert('googleではありません');
    return ;
  }
  n = window.prompt('何日以内の検索結果を表示？', 90);
  if (!isNum(n)) {
    n = 90;
    alert("日数は半角数字で入力して下さい。\n" + n + "日以内の検索結果を表示します");
  }
  cd_max = day_ago(0);
  cd_min = day_ago(n);
  tbs = 'cdr%3A1%2Ccd_min%3A' + cd_min + '%2Ccd_max%3A' + cd_max;
  location.href = cut_tbs() + '&tbs=' + tbs;
  function day_ago(day) {
    var date = new Date();
    var target_date = new Date(date.getTime() - day*24*60*60*1000);
    return (target_date.getMonth() + 1) + '%2F' + target_date.getDate() + '%2F' + target_date.getFullYear();
  }
  function cut_tbs() {
    //SAMPLE URL: https://www.google.com/search?tbs=lr%3Alang_ja%2Ccdr%3A1&tbm=#lr=lang_ja&q=abcd&tbs=cd_min%3A2013%2F7%2F26%2Ccd_max%3A2014%2F8%2F20&source=lnt&tbs=cdr:1
    var tmp = location.href.replace(/(&|\?)tbs=[^&]*/g, '$1');
    tmp = tmp.replace(/&+/g, '&');
    tmp = tmp.replace(/\?&/, '\?');
    tmp = tmp.replace(/&$/, '');
    return tmp;
  }
  function isNum(x) {
    return (!isNaN(x) && x != '');
  }
  function isGoogle() {
    return (['www.google.co.jp','www.google.com'].indexOf(document.domain) != - 1);
  }
}) ();
