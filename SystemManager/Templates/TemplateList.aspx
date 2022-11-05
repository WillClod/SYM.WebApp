<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="TemplateList.aspx.cs" Inherits="SystemManager.Templates.TemplateList" %>

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
        <asp:HiddenField ID="hdnUseCaseId" runat="server" />
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
                <asp:GridView ID="grdStep" runat="server" DataSourceID="srcEpic" AutoGenerateColumns="False" DataKeyNames="Id">
                    <Columns>
                        <asp:BoundField DataField="Id" HeaderText="Id" InsertVisible="False" ReadOnly="True" SortExpression="Id" />
                        <asp:BoundField DataField="Num" HeaderText="Num" SortExpression="Num" />
                        <asp:BoundField DataField="Code" HeaderText="Code" SortExpression="Code" />
                        <asp:BoundField DataField="Name" HeaderText="Name" SortExpression="Name" />
                        <asp:BoundField DataField="LongName" HeaderText="LongName" SortExpression="LongName" />
                        <asp:BoundField DataField="Descr" HeaderText="Descr" SortExpression="Descr" />
                        <asp:BoundField DataField="EpicTypeId" HeaderText="EpicTypeId" SortExpression="EpicTypeId" />
                        <asp:BoundField DataField="BasicStatusId" HeaderText="BasicStatusId" SortExpression="BasicStatusId" />
                        <asp:BoundField DataField="ProductOwnerUserId" HeaderText="ProductOwnerUserId" SortExpression="ProductOwnerUserId" />
                        <asp:BoundField DataField="PlanStartDate" HeaderText="PlanStartDate" SortExpression="PlanStartDate" />
                        <asp:BoundField DataField="PlanDurDays" HeaderText="PlanDurDays" SortExpression="PlanDurDays" />
                        <asp:BoundField DataField="PlanEndDate" HeaderText="PlanEndDate" SortExpression="PlanEndDate" />
                        <asp:BoundField DataField="ApplyStartDate" HeaderText="ApplyStartDate" SortExpression="ApplyStartDate" />
                        <asp:BoundField DataField="ApplyDurDays" HeaderText="ApplyDurDays" SortExpression="ApplyDurDays" />
                        <asp:BoundField DataField="ApplyEndDate" HeaderText="ApplyEndDate" SortExpression="ApplyEndDate" />
                        <asp:CheckBoxField DataField="IsClose" HeaderText="IsClose" SortExpression="IsClose" />
                        <asp:BoundField DataField="CreateUserId" HeaderText="CreateUserId" SortExpression="CreateUserId" />
                        <asp:BoundField DataField="CreateDateTime" HeaderText="CreateDateTime" SortExpression="CreateDateTime" />
                        <asp:BoundField DataField="ModifyUserId" HeaderText="ModifyUserId" SortExpression="ModifyUserId" />
                    </Columns>
                </asp:GridView>
            </div>
        </div>
        <div id="divFooter" class="divFooter">
            <div id="divAdd">

            </div>
            <div id="divDataSources">

            <asp:SqlDataSource ID="srcUseCase" runat="server" ConnectionString="<%$ ConnectionStrings:ApplicationConnectionString %>" SelectCommand="SELECT
UC.[Name],
UC.[Description],
UseStatusCode = US.Code,
UT.Type
FROM sm.UseCase UC
INNER JOIN sm.UseStatus US ON US.Id = UC.UseStatusId
INNER JOIN sm.UsePackage UP ON UP.Id = UC.UsePackageId 
INNER JOIN sm.UseType UT ON UT.id = UP.UseTypeId
WHERE UC.Id = @UseCaseId 
" InsertCommand="INSERT sm.UseCase(
CompanyId,	UsePackageId,	UseStatusId,	Number,				[Function],	
[Name],		[Description],	IsActive,		CreateUserId,		CreateDateTime)
VALUES(
@CompanyId,	@UsePackageId,	@UseStatusId,	@Number,			@Function,	
@Name,		@Description,	@IsActive,		@CreateUserId,		GETDATE())" UpdateCommand="UPDATE sm.UseCase SET 
Number = @Number,
[Function] = @Function,
[Name] = @Name,
[Description] = @Description,
ModifyUserId = @UserId,
ModifyDateTime = GETDATE(),
UseStatusId = @UseStatusId
WHERE Id = @Id
AND CompanyId = @CompanyId">
                <InsertParameters>
                    <asp:Parameter Name="CompanyId" Type="Int64" />
                    <asp:Parameter Name="UsePackageId" Type="Int64" />
                    <asp:Parameter Name="UseStatusId" Type="Int64" />
                    <asp:Parameter Name="Number" Type="String" />
                    <asp:Parameter Name="Function" Type="String" />
                    <asp:Parameter Name="Name" Type="String" />
                    <asp:Parameter Name="Description" Type="String" />
                    <asp:Parameter Name="IsActive" Type="Byte" />
                    <asp:Parameter Name="CreateUserId" Type="Int64" />
                </InsertParameters>
                <SelectParameters>
                    <asp:Parameter Name="UseCaseId" Type="Int64" />
                </SelectParameters>
                <UpdateParameters>
                    <asp:Parameter Name="Number" Type="String" />
                    <asp:Parameter Name="Function" Type="String" />
                    <asp:Parameter Name="Name" Type="String" />
                    <asp:Parameter Name="Description" Type="String" />
                    <asp:Parameter Name="UserId" Type="Int64" />
                    <asp:Parameter Name="UseStatusId" Type="Int64" />
                    <asp:Parameter Name="Id" Type="Int64" />
                    <asp:Parameter Name="CompanyId" Type="Int64" />
                </UpdateParameters>
</asp:SqlDataSource>        
            <asp:SqlDataSource ID="srcFlow" runat="server" ConnectionString="<%$ ConnectionStrings:ApplicationConnectionString %>" SelectCommand="SELECT Id, Name
FROM sm.Flow
WHERE UseCaseId = @UseCaseId
">
                <SelectParameters>
                    <asp:Parameter Name="UseCaseId" Type="Int64" />
                </SelectParameters>
                </asp:SqlDataSource>
            <asp:SqlDataSource ID="srcEpic" runat="server" ConnectionString="<%$ ConnectionStrings:SystemManager %>" SelectCommand="SELECT * 
FROM sym.Epic
">
                </asp:SqlDataSource>
            </div>
        </div>    
    </div>
    </form>
</body>
</html>
