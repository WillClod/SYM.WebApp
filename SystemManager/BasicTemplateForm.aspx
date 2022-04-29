<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="BasicTemplateForm.aspx.cs" Inherits="SystemManager.BasicTemplateForm" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="../../Styles/FixDiv.css" rel="Stylesheet" type="text/css" />
    <script src="../../scripts/FixDiv.js" type="text/javascript"></script>	
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <div id="divHeader" class="divHeader">

        </div>
        <div id="divBody" class="divBody" onscroll="fgvDivRepplyScroll('divBody', 'divHeader')">

        </div>
        <div id="divFooter" class="divFooter">

        </div>
    </div>
    </form>
</body>
</html>
