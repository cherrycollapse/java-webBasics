<%@ page contentType="text/html;charset=UTF-8" %>
<%
    String[] langs = new String[] { "uk", "en", "ru", "java" } ;
//    String home = "/WebBasics" ;
    String home = request.getContextPath() ;

    String countFromDataFilter = (String) request.getAttribute("count");

    String MD5 = (String) request.getAttribute("HashInputMD5");
    String Sha1 = (String) request.getAttribute("HashInputSha1");
%>
<!doctype html >
<html>
<head>
    <meta charset="UTF-8" />
    <title>JSP basics</title>
<%--    <style>--%>
<%--        input[type=radio] {--%>
<%--            visibility: hidden;--%>
<%--        }--%>
<%--        input[type=radio]:checked + label {--%>
<%--            border: 1px solid salmon;--%>
<%--            font-weight: bold;--%>
<%--        }--%>
<%--        label {--%>
<%--            cursor: pointer;--%>
<%--            font-size: larger;--%>
<%--            font-variant: all-petite-caps;--%>
<%--        }--%>
<%--    </style>--%>

    <link rel="stylesheet" href="<%=home%>/css/style.css">
    <!-- Compiled and minified CSS -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/css/materialize.min.css">

    <!-- Compiled and minified JavaScript -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/js/materialize.min.js"></script>
</head>


<body>

<jsp:include page="/WEB-INF/head/headerfragment.jsp"/>

<a href="<%=home%>/filters">Web-filters</a>
<br/>
<a href="<%=home%>/servlet">Web-servlets</a>
<br/>
<a href="<%=home%>/guice.jsp">Инверсия управления</a>
<br/>

<h1> Homeworks </h1>
<div>
    <p>На стартовой странице вывести данные о кол-ве записей в БД</p>
    Count :  <%= countFromDataFilter %><br/><br/>
</div>

<div>
<p>Cоздать форму для хеширования введенной пользователем строки</p>
<form method="post" action="">
    <div class="row">
        <div class="input-field col s3">
            <label for="Hash">Hash</label>
            <br/>
            <input name="HashInput" id="Hash" type="text">
            <button class="col">Submit</button>
        </div>
    </div>
</form>
<%if(MD5 != null || Sha1 !=null){%>
<div>
    <p>
        MD5: <%=MD5%>
    </p>
    <p>
        Sha1: <%=Sha1%>
    </p>
</div>
<%}%>
</div>

<div>
<h2>JSP - Java Server Pages</h2>
<p>
    1. Новый проект и запуск:
    Проект создаем по шаблону Web-App (JSP,...)
    либо по архетипу Maven (...-webapp)
    Признаки правильной установки:
    наличие папки webapp, в ней папка WEB-INF и файл index.jsp
    (возможно index.html, тогда его нужно переименовать в index.jsp)
    В папке webapp создаем папку img, добавляем в нее картинки
</p>
<p>
    2. Конфигурация запуска
    Для запуска веб-проектов есть несколько серверов (веб-сервер + сервер приложения)
    <img src="<%=home%>/img/glassfish.jpg" alt="Glassfish server" />
    <img src="<%=home%>/img/tomcat.jpg" alt="Tomcat server" />
    Их нужно установить (отдельно, с IDE обычно не поставляются)
    В конфигурации запуска нужно выбрать расположение сервера и артефакт: то, что
    будет деплоиться-выгружаться на сервер.
</p>
<p>
    3. Кодировка
    Устанавливаем кодировку всех файлов проекта: File - Settings - Editor>File Encodings
    Выставляем все на UTF-8
    Указываем кодировку для браузера: &lt;meta charset="UTF-8" />
    Указываем кодировку для "сборщика" &lt;%@ page contentType="text/html;charset=UTF-8" %>
</p>
<p>
    Суть JSP - "смешивание" возможностей Java и HTML.
    &lt;% ... %&gt; - контейнер для Java кода,
    <% int x = 10 ; %>
    &lt;%= ... %&gt; - выражение (вывод результата)
    x = <%= x %>
</p>
<p>
    Основными дополнениями можно считать:
    подключение файлов и как следствие разбиение страниц
    <jsp:include page="content/fragment.jsp"/>
    Условная верстка
        <% if(x < 10) { %>
    <b> x < 10 </b>
        <% } else { %>
    <i> x >= 10 </i>
        <% } %>
    <br/>
    Циклы и обработка массивов
        <% String[] arr = new String[] { "Some", "Words", "in", "array" } ; %>
<h3>Содержимое массива: </h3>
<% for( String str : arr ) { %>
<b><%= str %></b><br/>
<% } %>
Задание: создать массив допустимых языков сайта, создать элемент
переключения (выбора) языка<br/>
<% for( String lang : langs ) { %>
<input type="radio" name="lang" id="lang-<%=lang%>" />
<label for="lang-<%=lang%>"><%= lang %></label>
<br/>
<% } %>
</p>

<p>
    Задание: создать новую страницу с формой для регистрации
    В качестве фрагмента использовать footer.jsp
    (такой же подключить к главной странице)
    Обеспечить защиту footer.jsp от прямого доступа,
    на главной странице поставить ссылку на форму
</p>
<%--<button><a href="http://localhost:8080/java_webBasics_war_exploded/reg">Форма регистрации</a></button>--%>
</div>

</body>
</html>
