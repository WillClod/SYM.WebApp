<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="EpicList.aspx.cs" Inherits="SystemManager.Catalogs.Epic.EpicList" %>

<%@ Register src="EpicMonthList.ascx" tagname="EpicMonthList" tagprefix="uc1" %>

<%@ Register src="CapabilityList.ascx" tagname="CapabilityList" tagprefix="uc2" %>
<%@ Register Src="~/Catalogs/Epic/CapabilityMonthList.ascx" TagPrefix="uc1" TagName="CapabilityMonthList" %>


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

        <asp:HiddenField ID="hdnCompId" runat="server" Value="2" />
        <asp:HiddenField ID="hdnUserId" runat="server" Value="2" />



        <div id="divHeader" class="divHeader">

<%--        <div id="divTitle">
                <asp:Label ID="lblFormTitle" runat="server" Text="Caso de Uso"></asp:Label>
            </div>
            <div id="divName">
                <asp:Label ID="lblName" runat="server" Text="Nombre Caso de Uso"></asp:Label>
            </div>
            <div id="divType">
                <asp:Label ID="lblType" runat="server" Text="Tipo"></asp:Label>
            </div>
            <div id="divDescription" >
                <asp:Label ID="lblDescription" runat="server" Text="Descripción Caso de Uso"></asp:Label>
            </div>
            <div id="divFlow">
                <asp:DropDownList ID="cmbFlow" runat="server" DataSourceID="srcFlow" DataTextField="Name" DataValueField="Id"></asp:DropDownList>
            </div>--%>
        </div>
        <div id="divBody" class="divBody" onscroll="fgvDivRepplyScroll('divBody', 'divHeader')">
            <div id="divGrid">

                <%-- 
                <asp:GridView ID="grdEpicType" runat="server" AutoGenerateColumns="False" DataSourceID="srcEpicType">
                    <Columns>
                        <asp:BoundField DataField="EpicTypeCode" HeaderText="EpicTypeCode" ReadOnly="True" SortExpression="EpicTypeCode" />
                        <asp:BoundField DataField="EpicTypeDesc" HeaderText="EpicTypeDesc" ReadOnly="True" SortExpression="EpicTypeDesc" />
                    </Columns>
                </asp:GridView>
                --%>

                <asp:GridView ID="grdEpic" runat="server" DataSourceID="srcEpic" AutoGenerateColumns="False" GridLines="None" OnDataBound="grdEpic_DataBound" OnRowCommand="grdEpic_RowCommand" OnRowDataBound="grdEpic_RowDataBound">
                    <Columns>
                        <asp:TemplateField HeaderText="EpicData">
                            <EditItemTemplate>
                                <asp:HiddenField ID="hdnEpicId" runat="server" Value='<%# Eval("EpicId") %>' />

                                <asp:ImageButton ID="ibtShowCapabilityEdit" runat="server" ImageUrl="~/Images/IconDown16.png" />
                                <asp:DropDownList ID="cmbEpicType" runat="server" DataSourceID="srcEpicType" DataTextField="EpicTypeCode" DataValueField="EpicTypeId" SelectedValue='<%# Eval("EpicTypeId") %>' OnDataBound="cmbEpicType_DataBound"></asp:DropDownList>
                                
                                <asp:TextBox ID="txtEpicCode" runat="server" Text='<%# Eval("EpicCode") %>' OnTextChanged="txtEpicCode_TextChanged"></asp:TextBox>
                                <!--<asp:TextBox ID="txtEpicName" runat="server" Text='<%# Eval("EpicName") %>' ToolTip="Epic Name"></asp:TextBox>-->
                                
                                <asp:ImageButton ID="btnCancel" runat="server" ImageUrl="~/Images/IconCancel16.png" OnClick="btnCancel_Click" />
                                <asp:ImageButton ID="btnSave" runat="server" ImageUrl="~/Images/IconOK16.png" OnClick="btnSave_Click" />
                            </EditItemTemplate>
                            <ItemTemplate>
                                <div id="divHiddens">
                                    <asp:HiddenField ID="hdnEpicId" runat="server" Value='<%# Eval("EpicId") %>' />                                
                                </div>
                                <div id="divControls">
                                    <asp:ImageButton ID="ibtShowCapability" runat="server" ImageUrl="~/Images/IconDown16.png" />
                                    <asp:LinkButton ID="lnkEpicCode" runat="server" CommandName="Edit" Text='<%# Eval("EpicCode") %>'></asp:LinkButton>
                                </div>                              
                                <div id="divCapability" style="margin-left: 40px">
                                    <uc2:CapabilityList ID="ctrCapabilityList" runat="server" />
                                </div>                                
                            </ItemTemplate>
                            <ItemStyle VerticalAlign="Top" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="EpicMonths">
                            <HeaderTemplate>
                                <asp:GridView ID="grdMonthTitle" runat="server" AutoGenerateColumns="False" DataSourceID="srcMonthTitleSel" ShowHeader="False" GridLines="None">
                                    <Columns>
                                        <asp:BoundField DataField="January" HeaderText="January" ReadOnly="True" SortExpression="January">
                                        <ItemStyle Width="50px" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="February" HeaderText="February" ReadOnly="True" SortExpression="February">
                                        <ItemStyle Width="50px" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="March" HeaderText="March" ReadOnly="True" SortExpression="March">
                                        <ItemStyle Width="50px" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="April" HeaderText="April" ReadOnly="True" SortExpression="April">
                                        <ItemStyle Width="50px" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="May" HeaderText="May" ReadOnly="True" SortExpression="May">
                                        <ItemStyle Width="50px" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="June" HeaderText="June" ReadOnly="True" SortExpression="June">
                                        <ItemStyle Width="50px" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="July" HeaderText="July" ReadOnly="True" SortExpression="July">
                                        <ItemStyle Width="50px" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="August" HeaderText="August" ReadOnly="True" SortExpression="August">
                                        <ItemStyle Width="50px" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="September" HeaderText="September" ReadOnly="True" SortExpression="September">
                                        <ItemStyle Width="50px" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="October" HeaderText="October" ReadOnly="True" SortExpression="October">
                                        <ItemStyle Width="50px" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="November" HeaderText="November" ReadOnly="True" SortExpression="November">
                                        <ItemStyle Width="50px" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="December" HeaderText="December" ReadOnly="True" SortExpression="December">
                                        <ItemStyle Width="50px" />
                                        </asp:BoundField>
                                    </Columns>
                                    <RowStyle Width="50px" />
                                </asp:GridView>
                            </HeaderTemplate>
                            <ItemTemplate>                       
                                <uc1:EpicMonthList ID="ctrEpicMonthList" runat="server" />
                                <uc1:CapabilityMonthList runat="server" id="ctrCapabilityMonthList" />
                            </ItemTemplate>
                            <ItemStyle BorderStyle="None" VerticalAlign="Top" />
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
                <asp:LinkButton ID="lnkAddEpic" runat="server" OnClick="lnkAddEpic_Click">Agregar Epic</asp:LinkButton>
            </div>
        </div>
        <div id="divFooter" class="divFooter">
            <div id="divAdd">

            </div>
            <div id="divDataSources">                
                <asp:SqlDataSource ID="srcEpic" runat="server" ConnectionString="<%$ ConnectionStrings:SystemManager %>" SelectCommand="EXEC sym.EpicQuickSel @CompId, null" UpdateCommand="EXEC sym.EpicQuickUpd 
@pCompId ,
@pEpicId,
@pEpicCode,
@pEpicName,
@pEpicTypeId,
@pUserId
" InsertCommand="EXEC sym.EpicQuickIns 
@pCompId,
@pEpicCode,
@pEpicName,
@pEpicTypeId,
@pUserId">
                    <InsertParameters>
                        <asp:Parameter DbType="Int32" Name="pCompId" />
                        <asp:Parameter DbType="String" Name="pEpicCode" />
                        <asp:Parameter DbType="String" Name="pEpicName" />
                        <asp:Parameter DbType="Int32" Name="pEpicTypeId" />
                        <asp:Parameter DbType="Int32" Name="pUserId" />
                    </InsertParameters>
                    <SelectParameters>
                        <asp:Parameter DbType="Int32" Name="CompId" />
                    </SelectParameters>
                    <UpdateParameters>
                        <asp:Parameter DbType="Int32" Name="pCompId" />
                        <asp:Parameter DbType="Int32" Name="pEpicId" />
                        <asp:Parameter DbType="String" Name="pEpicCode" />
                        <asp:Parameter DbType="String" Name="pEpicName" />
                        <asp:Parameter DbType="Int32" Name="pEpicTypeId" />
                        <asp:Parameter DbType="Int32" Name="pUserId" />
                    </UpdateParameters>
                </asp:SqlDataSource>
                <asp:SqlDataSource ID="srcEpicType" runat="server" ConnectionString="<%$ ConnectionStrings:SystemManager %>" SelectCommand="SELECT
ET.Id AS EpicTypeId,
ET.Code AS EpicTypeCode, 
ET.Descr AS EpicTypeDesc
FROM sym.EpicType ET 
WHERE ET.CompId = @CompId
AND IsActive = 1
ORDER BY Seq

">
                    <SelectParameters>
                        <asp:Parameter Name="CompId" DbType="Int32" />
                    </SelectParameters>
                </asp:SqlDataSource>
                <asp:SqlDataSource ID="srcEpicTypeInEpics" runat="server" ConnectionString="<%$ ConnectionStrings:SystemManager %>" SelectCommand="SELECT
MIN(ET.Code) AS EpicTypeCode, 
MIN(ET.Descr) AS EpicTypeDesc
FROM sym.EpicType ET 
INNER JOIN sym.Epic E ON E.CompId = ET.CompId AND EpicTypeId = ET.Id
WHERE ET.CompId = @CompId
GROUP BY ET.Id
">
                    <SelectParameters>
                        <asp:Parameter Name="CompId" DbType="Int32" />
                    </SelectParameters>
                </asp:SqlDataSource>

                <asp:SqlDataSource ID="srcMonthTitleSel" runat="server" ConnectionString="<%$ ConnectionStrings:SystemManager %>" SelectCommand="EXEC sym.MonthTitleSel 1"></asp:SqlDataSource>

            </div>
        </div>    
    </div>
    </form>
</body>
</html>
