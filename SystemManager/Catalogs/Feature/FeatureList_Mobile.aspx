<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="FeatureList_Mobile.aspx.cs" Inherits="SystemManager.Catalogs.Feature.FeatureList_Mobile" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">

    <title>SYM Feature List</title>
    
    <!-- Mobile layout -->
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>

    <!-- Page Style -->     
    <link href="~/Styles/PageMobile.css" rel="Stylesheet" type="text/css"/>

    <!-- Fix Divs -->
    <link href="~/Styles/FixDiv.css" rel="Stylesheet" type="text/css"/>
    <script src="~/scripts/FixDiv.js" type="text/javascript"></script>	

    <!-- Bootstrap -->
    <link rel="stylesheet" href="https://netdna.bootstrapcdn.com/bootstrap/3.0.3/css/bootstrap.min.css"/>       

</head>
<body>
    <form id="form1" runat="server">
    
        <div id="divHeader" class="divHeader">

            <div id="divHiddens">

                <asp:HiddenField ID="hdnCompId" runat="server" Value="2" />
                <asp:HiddenField ID="hdnUserId" runat="server" Value="2" />
                <asp:HiddenField ID="hdnEpicId" runat="server" Value="1002" />
                <asp:HiddenField ID="hdnCapabilityId" runat="server" Value="4" />
                <asp:HiddenField ID="hdnFeatureId" runat="server" Value="8" />

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

                <asp:SqlDataSource ID="srcCapability" runat="server" ConnectionString="<%$ ConnectionStrings:SystemManager %>" ProviderName="<%$ ConnectionStrings:SystemManager.ProviderName %>" SelectCommand="SELECT C.Id, C.Code
FROM sym.Capability C
WHERE C.CompId =  @CompId
AND C.EpicId = @EpicId
AND C.IsClose = 0 -- Open">
                    <SelectParameters>
                        <asp:Parameter DbType="Int32" Name="CompId" />
                        <asp:Parameter DbType="Int32" Name="EpicId" />
                    </SelectParameters>
                </asp:SqlDataSource>

                <asp:SqlDataSource ID="srcFeatureQuick" runat="server" ConnectionString="<%$ ConnectionStrings:SystemManager %>" ProviderName="<%$ ConnectionStrings:SystemManager.ProviderName %>" SelectCommand="EXEC sym.FeatureQuickSel1
@CompId,
@CapabilityId,
@ListBackLogStatus,
@ListOnProcessStatus,
@ListCompleteStatus " InsertCommand="EXEC sym.FeatureQuickIns @CompId, @CapabilityId, @Code, @Name, @Descr, @UserId" UpdateCommand="EXEC sym.FeatureQuickUpd @CompId, @Id, @CapabilityId, @Code, @Name, @Descr, @UserId">
                    <InsertParameters>
                        <asp:Parameter DbType="Int32" Name="CompId" />
                        <asp:Parameter DbType="Int64" Name="CapabilityId" />
                        <asp:Parameter DbType="String" Name="Code" />
                        <asp:Parameter DbType="String" Name="Name" />
                        <asp:Parameter DbType="Int32" Name="UserId" />
                        <asp:Parameter DbType="String" Name="Descr" />
                    </InsertParameters>
                    <SelectParameters>
                        <asp:Parameter DbType="Int32" Name="CompId" />
                        <asp:Parameter DbType="Int64" Name="CapabilityId" />
                        <asp:Parameter DbType="Boolean" Name="ListBackLogStatus" />
                        <asp:Parameter DbType="Boolean" Name="ListOnProcessStatus" />
                        <asp:Parameter DbType="Boolean" Name="ListCompleteStatus" />
                    </SelectParameters>
                    <UpdateParameters>
                        <asp:Parameter DbType="Int32" Name="CompId" />
                        <asp:Parameter DbType="Int64" Name="Id" />
                        <asp:Parameter DbType="Int64" Name="CapabilityId" />
                        <asp:Parameter DbType="String" Name="Code" />
                        <asp:Parameter DbType="String" Name="Name" />
                        <asp:Parameter DbType="String" Name="Descr" />
                        <asp:Parameter DbType="Int32" Name="UserId" />
                    </UpdateParameters>
                </asp:SqlDataSource>

            </div>

            <div id="divPageBar" class="divPageBar">

               <div id="divLeftButton" class="divLeft">
                   <asp:ImageButton ID="btnBack" runat="server" 
                        ImageUrl="~/Images/Back48.png" Visible="False" ToolTip="Regresar" />
               </div>

               <div id="divRigthButton" class="divRight">
                   <asp:ImageButton ID="btnNew" runat="server" 
                        ImageUrl="~/Images/New48.png" OnClick="btnNew_Click" ToolTip="Nuevo" />
               </div>
                            
               <div id="divTitle" class="divTitle">
                   <asp:Label ID="lblTitle" class="lblTitle" runat="server" Text="Features"></asp:Label>
               </div>

        </div>

            <div id="divFilters" class="divRow" style="margin-right: 10px; margin-left: 10px">

                <div id="divEpic" class ="divRow21">
                    <div>
                        <asp:Label ID="lblEpic" class="lbl" runat="server" Text="Epic" Width="100%"></asp:Label>
                    </div>
                    <div>
                        <asp:DropDownList ID="cmbEpic" class="cmb" runat="server" DataSourceID="srcEpic" DataTextField="Code" DataValueField="Id" OnDataBound="cmbEpic_DataBound" AutoPostBack="True" OnSelectedIndexChanged="cmbEpic_SelectedIndexChanged" Width="100%" ></asp:DropDownList>        
                    </div>
                </div>

                <div id="divCapability" class="divRow22">
                    <div>
                        <asp:Label ID="lblCapability" class="lbl" runat="server" Text="Capability" Width="100%"></asp:Label>
                    </div>
                    <div>
                        <asp:DropDownList ID="cmbCapability" class="cmb" runat="server" DataSourceID="srcCapability" DataTextField="Code" DataValueField="Id" OnDataBound="cmbCapability_DataBound" AutoPostBack="True" OnSelectedIndexChanged="cmbCapability_SelectedIndexChanged" Width="100%"></asp:DropDownList>
                    </div>
                </div>

            </div>

        </div>

        <div id="divBody" class="divBody" onscroll="fgvDivRepplyScroll('divBody', 'divHeader')">

            <div id="divGrid">

                <asp:GridView ID="gvwMain" runat="server" AutoGenerateColumns="False" DataSourceID="srcFeatureQuick" GridLines="None" OnRowCommand="gvwMain_RowCommand" OnRowDataBound="gvwMain_RowDataBound" Font-Names="Arial" Font-Size="Larger" Width="100%">
                    <Columns>
                        <asp:TemplateField HeaderText="Status">
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("FeatureStatusCode") %>'></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="Label1" runat="server" Text='<%# Bind("FeatureStatusCode") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Feature">
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("FeatureCode") %>'></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:HiddenField ID="hdnFeatureId" runat="server" Value='<%# Bind("FeatureId") %>' />
                                <asp:LinkButton ID="lnkCode" runat="server" CommandName="Select" Text='<%# Bind("FeatureCode") %>'></asp:LinkButton>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Owner">
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox3" runat="server" Text='<%# Bind("Owner") %>'></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="Label3" runat="server" Text='<%# Bind("Owner") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Start">
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox4" runat="server" Text='<%# Bind("StartDate") %>'></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="Label4" runat="server" Text='<%# Bind("StartDate", "{0:dd/MM/yy}") %>'></asp:Label>
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Center" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="End">
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox5" runat="server" Text='<%# Bind("EndDate") %>'></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="Label5" runat="server" Text='<%# Bind("EndDate", "{0:dd/MM/yy}") %>'></asp:Label>
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Center" />
                        </asp:TemplateField>
                    </Columns>
            </asp:GridView>

            </div>

        </div>

        <div id="divFooter" class="divFooter2">

        </div>    

    </form>
</body>
</html>
