<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="UsePackageCase.ascx.cs" Inherits="SystemManager.Catalogs.UseCase.UsePackageCase" %>
<asp:HiddenField ID="hdnUsePackageId" runat="server" />
<asp:GridView ID="grdUseCase" runat="server" AutoGenerateColumns="False" DataKeyNames="Id" DataSourceID="srcUseCase" OnRowCommand="grdUseCase_RowCommand" OnRowDataBound="grdUseCase_RowDataBound">
    <Columns>
        <asp:TemplateField HeaderText="Número">
            <EditItemTemplate>
                <asp:TextBox ID="txtNumber" runat="server" Text='<%# Eval("Number") %>'></asp:TextBox>
                <asp:HiddenField ID="hdnId" runat="server" Value='<%# Eval("Id") %>' />
            </EditItemTemplate>
            <ItemTemplate>
                <asp:LinkButton ID="lnkNumber" runat="server" Text='<%# Eval("Number") %>' CommandName="Edit"></asp:LinkButton>
                &nbsp;&nbsp;
                <asp:HiddenField ID="hdnId" runat="server" Value='<%# Eval("Id") %>' />
            </ItemTemplate>
        </asp:TemplateField>
        <asp:TemplateField HeaderText="Función">
            <EditItemTemplate>
                <asp:TextBox ID="txtFunction" runat="server" Text='<%# Eval("Function") %>'></asp:TextBox>
            </EditItemTemplate>
            <ItemTemplate>
                <asp:LinkButton ID="lnkFunction" runat="server" CommandName="Edit" Text='<%# Eval("Function") %>'></asp:LinkButton>
            </ItemTemplate>
        </asp:TemplateField>
        <asp:TemplateField HeaderText="Descripción">
            <EditItemTemplate>
                <asp:TextBox ID="txtDescription" runat="server" Text='<%# Eval("Description") %>'></asp:TextBox>
            </EditItemTemplate>
            <ItemTemplate>
                <asp:Label ID="lblDescription" runat="server" Text='<%# Eval("Description") %>'></asp:Label>
            </ItemTemplate>
        </asp:TemplateField>
        <asp:TemplateField HeaderText="Estatus">
            <EditItemTemplate>
                <asp:DropDownList ID="cmbStatus" runat="server" DataSourceID="srcUseStatus" DataTextField="Code" DataValueField="Id" SelectedValue='<%# Eval("UseStatusId") %>'>
                </asp:DropDownList>
            </EditItemTemplate>
            <ItemTemplate>
                <asp:Label ID="lblStatus" runat="server" Text='<%# Eval("UseStatusCode") %>'></asp:Label>
            </ItemTemplate>
        </asp:TemplateField>
        <asp:TemplateField HeaderText="Acción">
            <EditItemTemplate>
                <asp:ImageButton ID="btnCancel" runat="server" ImageUrl="~/Images/IconCancel16.png" OnClick="btnCancel_Click" />
                &nbsp;<asp:ImageButton ID="btnSave" runat="server" ImageUrl="~/Images/IconOK16.png" />
            </EditItemTemplate>
            <ItemTemplate>
                <asp:ImageButton ID="btnEdit" runat="server" ImageUrl="~/Images/IconEdit16.png" />
            </ItemTemplate>
        </asp:TemplateField>
    </Columns>
</asp:GridView>
<div id="divAdd">
            <asp:LinkButton ID="lnkNew" runat="server" OnClick="lnkNew_Click">Nuevo Caso de Uso</asp:LinkButton>
</div>
<div id = "divDataSource">
            <asp:SqlDataSource ID="srcUseCase" runat="server" ConnectionString="<%$ ConnectionStrings:ApplicationConnectionString %>" SelectCommand="(
SELECT
Sequence = 1,
UC.Id,
UC.Number,
UC.[Function],
UC.[Description],
UC.UseStatusId,
UseStatusCode = US.Code
FROM sm.UseCase UC
INNER JOIN sm.UseStatus US ON US.Id = UC.UseStatusId
WHERE UC.UsePackageId = @UsePackageId 
UNION
SELECT
Sequence = 2,
Id = 0,
Number = '', 
[Function] = '',
[Description] = '',
UseStatusId = 1,
UseStatusCode = ''
)
ORDER BY Sequence, Number,  [Function]
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
                    <asp:Parameter Name="UsePackageId" Type="Int64" />
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
            <asp:SqlDataSource ID="srcUseStatus" runat="server" ConnectionString="<%$ ConnectionStrings:ApplicationConnectionString %>" SelectCommand="SELECT Id, Code 
FROM sm.UseStatus
ORDER BY Sequence ">
</asp:SqlDataSource>        
            <asp:SqlDataSource ID="srcUsePackage" runat="server" ConnectionString="<%$ ConnectionStrings:ApplicationConnectionString %>" SelectCommand="SELECT ApplicationName = A.Code + '.' + T.Code + '.' + P.Number, P.[Function]  
FROM sm.UsePackage P
INNER JOIN sm.Application A ON A.Id = P.ApplicationId 
INNER JOIN sm.UseType T ON T.Id = P.UseTypeId
WHERE P.Id = @Id
">
                <SelectParameters>
                    <asp:Parameter Name="Id" Type="Int64" />
                </SelectParameters>
</asp:SqlDataSource>        
</div>