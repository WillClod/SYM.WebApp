<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="UsePackage.aspx.cs" Inherits="SystemManager.Catalogs.UseCase.UsePackage" EnableEventValidation = "false" %>

<%@ Register Src="~/Catalogs/UseCase/UsePackageCase.ascx" TagPrefix="uc1" TagName="UsePackageCase" %>

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
            <div id="divFilter">
                
                <div id="divFilterSystem" style="float: left">
                    <div>
                        <asp:Label ID="lblSystem" runat="server" Text="Sistema"></asp:Label>
                    </div>
                    <div>
                        <asp:DropDownList ID="cmbSystem" runat="server" DataSourceID="srcSystem" DataTextField="Code" DataValueField="Id" OnSelectedIndexChanged="cmbSystem_SelectedIndexChanged" AutoPostBack="True"></asp:DropDownList>
                    </div>
                </div>
                <div id="divFilterApplication" style="float: left">
                    <div>
                        <asp:Label ID="lblApplication" runat="server" Text="Aplicación"></asp:Label>
                    </div>
                    <div>
                        <asp:DropDownList ID="cmbApplication" runat="server" DataSourceID="srcApplication" DataTextField="Code" DataValueField="Id" AutoPostBack="True" OnSelectedIndexChanged="cmbApplication_SelectedIndexChanged"></asp:DropDownList>
                    </div>

                </div>
                <div id="divFilterType" >
                    <div>
                        <asp:Label ID="lblUseCaseType" runat="server" Text="Tipo"></asp:Label>
                    </div>
                    <div>
                        <asp:DropDownList ID="cmbUseType" runat="server" DataSourceID="srcUseType" DataTextField="Type" DataValueField="Id" AutoPostBack="True" OnSelectedIndexChanged="cmxUseCaseType_SelectedIndexChanged" OnDataBound="cmbUseType_DataBound"></asp:DropDownList>
                    </div>
                </div>

            </div>            
        </div>
        <div id="divBody" class="divBody" onscroll="fgvDivRepplyScroll('divBody', 'divHeader')">
            <div id="divGrid">
                <asp:GridView ID="grdUsePackage" runat="server" DataSourceID="srcUsePackage" AutoGenerateColumns="False" OnRowCommand="grdUsePackage_RowCommand" OnRowDataBound="grdUsePackage_RowDataBound" GridLines="None" ShowHeader="False" OnDataBound="grdUsePackage_DataBound">
                    <Columns>
                        <asp:TemplateField>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtNumber" runat="server" Height="16px" Text='<%# Eval("Number") %>' Width="16px"></asp:TextBox>
                                <asp:TextBox ID="txtFunction" runat="server" Height="16px" Text='<%# Eval("Function") %>' Width="121px"></asp:TextBox>
                                <asp:DropDownList ID="cmbUseType" runat="server" DataSourceID="srcUseType" DataTextField="Type" DataValueField="Id" SelectedValue='<%# Eval("UseTypeId") %>'>
                                </asp:DropDownList>
                                <asp:ImageButton ID="btnCancel" runat="server" ImageUrl="~/Images/IconCancel16.png" OnClick="btnCancel_Click" />
                                <asp:ImageButton ID="btnSave" runat="server" ImageUrl="~/Images/IconOK16.png" />
                                <asp:SqlDataSource ID="srcUseType" runat="server" ConnectionString="<%$ ConnectionStrings:ApplicationConnectionString %>" SelectCommand="SELECT [Id], [Type] FROM sm.[UseType]"></asp:SqlDataSource>
                                <asp:HiddenField ID="hdnId" runat="server" Value='<%# Eval("Id") %>' />
                                <asp:HiddenField ID="hdnApplicationCode" runat="server" Value='<%# Eval("ApplicationCode") %>' />
                                <asp:HiddenField ID="hdnUseTypeCode" runat="server" Value='<%# Eval("UseTypeCode") %>' />
                            </EditItemTemplate>
                            <ItemTemplate>
                                <div id="divUsePackage">
                                    <asp:LinkButton ID="lnkNumber" runat="server" CommandName="Edit" Text='<%# Eval("Number") %>' Font-Bold="True"></asp:LinkButton>
                                    &nbsp;<asp:LinkButton ID="lnkFunction" runat="server" CommandName="Edit" Text='<%# Eval("Function") %>' Font-Bold="True"></asp:LinkButton>
                                    &nbsp;<asp:Label ID="lblUseType" runat="server" Text='<%# Eval("UseType") %>'></asp:Label>
                                </div>
                                <div id="divUseCase">
                                    <asp:HiddenField ID="hdnUsePackageId" runat="server" Value='<%# Eval("Id") %>' />
                                    <uc1:UsePackageCase runat="server" ID="UsePackageCase" />
                                </div>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </div>
        </div>
        <div id="divFooter" class="divFooter">
            <div id="divAdd">
                    <asp:LinkButton ID="lnkNew" runat="server" OnClick="lnkNew_Click" Font-Bold="True">Nuevo Paquete de Uso</asp:LinkButton>
            </div>
            <div id="divDataSource">
            <asp:SqlDataSource ID="srcSystem" runat="server" ConnectionString="<%$ ConnectionStrings:ApplicationConnectionString %>" SelectCommand="SELECT * FROM sm.System"></asp:SqlDataSource>
            <asp:SqlDataSource ID="srcApplication" runat="server" ConnectionString="<%$ ConnectionStrings:ApplicationConnectionString %>" SelectCommand="SELECT Id, CompanyId, SystemId, Code, Name, Description, OwnerUserId, IsActive, CreateUserId, CreateDateTime, ModifyUserId, ModifyDateTime, InactiveUserId, InactiveDateTime FROM sm.Application WHERE (SystemId = @SystemId)">
                <SelectParameters>
                    <asp:ControlParameter ControlID="cmbSystem" Name="SystemId" PropertyName="SelectedValue" />
                </SelectParameters>
            </asp:SqlDataSource>
            <asp:SqlDataSource ID="srcUseType" runat="server" ConnectionString="<%$ ConnectionStrings:ApplicationConnectionString %>" SelectCommand="SELECT * FROM sm.UseType" ProviderName="<%$ ConnectionStrings:ApplicationConnectionString.ProviderName %>"></asp:SqlDataSource>
                <asp:SqlDataSource ID="srcUseCase" runat="server" ConnectionString="<%$ ConnectionStrings:ApplicationConnectionString %>" SelectCommand="SELECT * FROM sm.UseCase"></asp:SqlDataSource>
            <asp:SqlDataSource ID="srcUsePackage" runat="server" ConnectionString="<%$ ConnectionStrings:ApplicationConnectionString %>" SelectCommand="(
    SELECT 
    P.Id,
    P.Number, P.[Function],
    ShortName = P.Number + ' ' + P.[Function],
    P.UseTypeId,
    UseType = T.[Type],
    P.IsActive,
    ApplicationCode = A.Code,
    UseTypeCode = T.Code,
    T.Sequence
    FROM sm.UsePackage P
    INNER JOIN sm.UseType T ON T.CompanyId = P.CompanyId
					    AND T.Id = P.UseTypeId
    INNER JOIN sm.Application A ON A.CompanyId = P.CompanyId
					    AND A.Id = P.ApplicationId
    WHERE (P.ApplicationId = @ApplicationId) 
    AND ( (@UseTypeId = -1) OR (P.UseTypeId = @UseTypeId))
    UNION
    SELECT
    Id = 0,
    Number = '', 
    [Function] = '',
    ShortName = '',
    UseTypeId = 1,
    UseType = '',
    IsActive = 1,
    ApplicationCode = '',
    UseTypeCode = '',
    [Sequence] = 999999999
    )
    ORDER BY Sequence, UseType, Number, [Function]
    " UpdateCommand="UPDATE sm.UsePackage SET 
    Number = @Number,
    [Function] = @Function,
    [Name] = @Name,
    ModifyUserId = @UserId,
    ModifyDateTime = GETDATE(),
    UseTypeId = @UseTypeId
    WHERE Id = @Id
    AND CompanyId = @CompanyId" InsertCommand="INSERT sm.UsePackage(
    CompanyId,	ApplicationId,	UseTypeId,		UseStatusId,		Number,
    [Function],	[Name],			[Description],	IsActive,			CreateUserId,
    CreateDateTime)
    VALUES(
    @CompanyId,	@ApplicationId,	@UseTypeId,		@UseStatusId,		@Number,
    @Function,	@Name,			@Description,	@IsActive,			@CreateUserId,
    GETDATE())
    ">
                <InsertParameters>
                    <asp:Parameter Name="CompanyId" Type="Int64" />
                    <asp:Parameter Name="ApplicationId" Type="Int64" />
                    <asp:Parameter Name="UseTypeId" Type="Int64" />
                    <asp:Parameter Name="UseStatusId" Type="Int64" />
                    <asp:Parameter Name="Number" Type="String" />
                    <asp:Parameter Name="Function" Type="String" />
                    <asp:Parameter Name="Name" Type="String" />
                    <asp:Parameter Name="Description" Type="String" />
                    <asp:Parameter Name="IsActive" Type="Byte" />
                    <asp:Parameter Name="CreateUserId" Type="Int64" />
                </InsertParameters>
                <SelectParameters>
                    <asp:ControlParameter ControlID="cmbApplication" Name="ApplicationId" PropertyName="SelectedValue" />
                    <asp:ControlParameter ControlID="cmbUseType" Name="UseTypeId" PropertyName="SelectedValue" />
                </SelectParameters>
                <UpdateParameters>
                    <asp:Parameter Name="Number" Type="String" />
                    <asp:Parameter Name="Function" Type="String" />
                    <asp:Parameter Name="Name" Type="String" />
                    <asp:Parameter Name="UserId" Type="Int64" />
                    <asp:Parameter Name="Id" Type="Int64" />
                    <asp:Parameter Name="CompanyId" Type="Int64" />
                    <asp:Parameter Name="UseTypeId" Type="Int64" />
                </UpdateParameters>
                </asp:SqlDataSource>
            <asp:SqlDataSource ID="srcGetApplicationCode" runat="server" ConnectionString="<%$ ConnectionStrings:ApplicationConnectionString %>" SelectCommand="SELECT Code
    FROM sm.Application 
    WHERE Id = @ApplicationId">
                <SelectParameters>
                    <asp:Parameter Name="ApplicationId" Type="Int64" />
                </SelectParameters>
            </asp:SqlDataSource>
            <asp:SqlDataSource ID="srcGetUseTypeCode" runat="server" ConnectionString="<%$ ConnectionStrings:ApplicationConnectionString %>" SelectCommand="SELECT Code 
    FROM sm.UseType
    WHERE Id = @UseTypeId">
                <SelectParameters>
                    <asp:Parameter Name="UseTypeId" Type="Int64" />
                </SelectParameters>
                </asp:SqlDataSource>
        </div>        
        </div>
    </div>
    </form>
</body>
</html>
