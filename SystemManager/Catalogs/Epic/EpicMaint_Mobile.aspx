<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="EpicMaint_Mobile.aspx.cs" Inherits="SystemManager.Catalogs.Epic.EpicMaint_Mobile" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>SYM Epic Maint</title>
    
    <!-- Mobile layout -->
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>

    <link href="../../Styles/FixDiv.css" rel="Stylesheet" type="text/css" />
    <script src="../../scripts/FixDiv.js" type="text/javascript"></script>	
</head>
<body>
    <form id="form1" runat="server">
    
        <div id="divHeader" class="divHeader">

            <div id="divHiddens">

                <asp:HiddenField ID="hdnCompId" runat="server" Value="2" />
                <asp:HiddenField ID="hdnUserId" runat="server" Value="2" />
                <asp:HiddenField ID="hdnEpicId" runat="server" Value="1002" />

            </div>

            <div id="divKeyFields"

            </div>

        </div>

        <div id="divBody" class="divBody" onscroll="fgvDivRepplyScroll('divBody', 'divHeader')">

            <div id="divCode">
                <asp:TextBox ID="txtCode" runat="server"></asp:TextBox>
            </div>

            <div id="divName">
                <asp:TextBox ID="txtName" runat="server"></asp:TextBox>
            </div>

            <div id="divDescr">
                <asp:TextBox ID="txtDescr" runat="server"></asp:TextBox>
            </div>

        </div>

        <div id="divFooter" class="divFooter">

            <div id="divButtons">

                <asp:Button ID="btnSave" runat="server" Text="Save" OnClick="btnSave_Click" />

            </div>

            <div id="divDataSources">

                <asp:SqlDataSource ID="srcEpic" runat="server" ConnectionString="<%$ ConnectionStrings:SystemManager %>" SelectCommand="SELECT E.Id,E.Code
FROM sym.Epic E
WHERE E.CompId =  @CompId
AND E.IsClose = 0 -- Open">
                <SelectParameters>
                    <asp:Parameter DbType="Int16" Name="CompId" />
                </SelectParameters>
                </asp:SqlDataSource>

            </div>

        </div>    

    </form>
</body>
</html>
