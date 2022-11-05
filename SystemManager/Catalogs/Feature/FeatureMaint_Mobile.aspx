<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="FeatureMaint_Mobile.aspx.cs" Inherits="SystemManager.Catalogs.Feature.FeatureMaint_Mobile" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">

    <title>SYM Feature Maint</title>
    
    <!-- Mobile layout -->
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/> 
    
    <!-- Fix Divs -->
    <link href="~/Styles/FixDiv.css" rel="Stylesheet" type="text/css" />
    <script src="~/scripts/FixDiv.js" type="text/javascript"></script>	

    <!-- Page Style -->     
    <link href="~/Styles/PageMobile.css" rel="Stylesheet" type="text/css"/>

    <!-- Bootstrap -->
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.1.0/jquery.js"></script>
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.6.4/js/bootstrap-datepicker.min.js"></script>
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.6.4/locales/bootstrap-datepicker.es.min.js" charset="UTF-8"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.6.4/css/bootstrap-datepicker3.css"/>
    <link rel="stylesheet" href="https://netdna.bootstrapcdn.com/bootstrap/3.0.3/css/bootstrap.min.css"/>       
    <script type="text/javascript">

        // Set bootstrap datepicker to date field.
        $(function () {
            $("#txtStartDate").datepicker({
                language: 'es',
                format: "dd/mm/yyyy"
            });
        });

        $(function () {
            $("#txtEndDate").datepicker({
                language: 'es',
                format: "dd/mm/yyyy"
            });
        });

        function btnTest_OnClick() {
            alert("Hola");
        }

    </script>

</head>
<body>
    <form id="form1" runat="server">
    
        <div id="divHeader" class="divHeader">

            <div id="divHiddens">

                <asp:HiddenField ID="hdnCompId" runat="server" Value="2" />
                <asp:HiddenField ID="hdnUserId" runat="server" Value="2" />
                <asp:HiddenField ID="hdnEpicId" runat="server" Value="1002" />
                <asp:HiddenField ID="hdnCapabilityId" runat="server" Value="4" />               
                <asp:HiddenField ID="hdnFeatureId" runat="server" Value="11" />

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

                <asp:SqlDataSource ID="srcFeatureQuick" runat="server" ConnectionString="<%$ ConnectionStrings:SystemManager %>" ProviderName="<%$ ConnectionStrings:SystemManager.ProviderName %>" SelectCommand="EXEC sym.FeatureQuickSel2 @CompId, @FeatureId" InsertCommand="EXEC sym.FeatureQuickIns @CompId, @CapabilityId, @Code, @Name, @Descr, @StatusId, @StartDate, @EndDate, @UserId" UpdateCommand="EXEC sym.FeatureQuickUpd @CompId, @Id, @CapabilityId, @Code, @Name, @Descr, @StatusId, @StartDate, @EndDate, @UserId">
                    <InsertParameters>
                        <asp:Parameter DbType="Int32" Name="CompId" />
                        <asp:Parameter DbType="Int64" Name="CapabilityId" />
                        <asp:Parameter DbType="String" Name="Code" />
                        <asp:Parameter DbType="String" Name="Name" />
                        <asp:Parameter DbType="Int32" Name="UserId" />
                        <asp:Parameter DbType="String" Name="Descr" />
                        <asp:Parameter DbType="Int16" Name="StatusId" />
                        <asp:Parameter DbType="DateTime" Name="StartDate" />
                        <asp:Parameter DbType="DateTime" Name="EndDate" />
                    </InsertParameters>
                    <SelectParameters>
                        <asp:Parameter DbType="Int32" Name="CompId" />
                        <asp:Parameter DbType="Int64" Name="FeatureId" />
                    </SelectParameters>
                    <UpdateParameters>
                        <asp:Parameter DbType="Int32" Name="CompId" />
                        <asp:Parameter DbType="Int64" Name="Id" />
                        <asp:Parameter DbType="Int64" Name="CapabilityId" />
                        <asp:Parameter DbType="String" Name="Code" />
                        <asp:Parameter DbType="String" Name="Name" />
                        <asp:Parameter DbType="String" Name="Descr" />
                        <asp:Parameter DbType="Int32" Name="UserId" />
                        <asp:Parameter DbType="Int16" Name="StatusId" />
                        <asp:Parameter DbType="DateTime" Name="StartDate" />
                        <asp:Parameter DbType="DateTime" Name="EndDate" />
                    </UpdateParameters>
                </asp:SqlDataSource>

                <asp:SqlDataSource ID="srcMainStatus" runat="server" ConnectionString="<%$ ConnectionStrings:SystemManager %>" ProviderName="<%$ ConnectionStrings:SystemManager.ProviderName %>" SelectCommand="SELECT Id, Code 
FROM sym.MainStatus
ORDER BY Seq"></asp:SqlDataSource>

            </div>

            <div id="divPageBar" class="divPageBar">

               <div id="divLeftButton" class="divLeft">
                   <asp:ImageButton ID="btnBack" runat="server" 
                        ImageUrl="~/Images/Back48.png" ToolTip="Regresar" OnClick="btnBack_Click" />
               </div>

               <div id="divRigthButton" class="divRight">
                   <asp:ImageButton ID="ImageButton1" runat="server" 
                        ImageUrl="~/Images/Done48.png" onclick="btnSave_Click" ToolTip="Guardar" />
               </div>
                            
               <div id="divTitle" class="divTitle">
                   <asp:Label ID="lblTitle" class="lblTitle" runat="server" Text="Feature"></asp:Label>
               </div>

           </div>
                       
            <div id="divKeyFields" class="divRow">   

                <div class="divRow21">
                    <div>
                        <asp:Label ID="lblEpic" class="lbl" runat="server" Text="Epic" Width="100%"></asp:Label>
                    </div>
                    <div>
                        <asp:DropDownList ID="cmbEpic" class="cmb" runat="server" DataSourceID="srcEpic" DataTextField="Code" DataValueField="Id" OnDataBound="cmbEpic_DataBound" AutoPostBack="True" OnSelectedIndexChanged="cmbEpic_SelectedIndexChanged" Width="100%"></asp:DropDownList>                                    
                    </div>
                </div>

                <div class="divRow22">
                    <div>
                        <asp:Label ID="lblCapability" class="lbl" runat="server" Text="Capability" Width="100%"></asp:Label>
                    </div>
                    <div>
                        <asp:DropDownList ID="cmbCapability" class="cmb" runat="server" DataSourceID="srcCapability" DataTextField="Code" DataValueField="Id" OnDataBound="cmbCapability_DataBound" Width="100%"></asp:DropDownList>
                    </div>
                </div>
            </div>

        </div>
    
        <div id="divBody" class="divBody" onscroll="fgvDivRepplyScroll('divBody', 'divHeader')">

            <div id="divDates" class="divRow">
            
                <div id="divStartDate" class="divRow21">
                    <div>
                        <asp:Label ID="lblStartDate" class="lbl" runat="server" Text="Inicio" Width="100%"></asp:Label>
                    </div>
                    <div>  
                        <asp:TextBox ID="txtStartDate" class="txt" runat="server" 
                        ReadOnly="True">Fri 21 Dic 2012</asp:TextBox>               
                    </div>
                </div>

                <div id="divEndDate" class="divRow22">
                    <div>
                        <asp:Label ID="lblEndDate" class="lbl" runat="server" Text="Fin" Width="100%"></asp:Label>
                    </div>
                    <div>  
                        <asp:TextBox ID="txtEndDate" class="txt" runat="server"  
                          ReadOnly="True">Fri 21 Dic 2012</asp:TextBox>               
                    </div>
                </div>
            </div>
            
            <div id="divStatus" class="divRow">
                <div>
                    <asp:Label ID="lblStatus" class="lbl" runat="server" Text="Estatus" Width="100%"></asp:Label>
                </div>
                <div>
                    <asp:DropDownList ID="cmbStatus" class="cmb" runat="server" DataSourceID="srcMainStatus" DataTextField="Code" DataValueField="Id" Width="100%"></asp:DropDownList>
                </div>
            </div>

            <div id="divCode" class="divRow">               
                <div>
                    <asp:Label ID="lblCode" class="lbl" runat="server" Text="Codigo" Width="100%"></asp:Label>
                </div>
                <div>
                    <asp:TextBox ID="txtCode" class="txt" runat="server"></asp:TextBox>
                </div>
            </div>

            <div id="divName" class="divRow">
                <div>
                    <asp:Label ID="lblName" class="lbl" runat="server" Text="Nombre" Width="100%"></asp:Label>
                </div>
                <div>
                    <asp:TextBox ID="txtName" class="txt" runat="server"></asp:TextBox>
                </div>
            </div>

            <div id="divDescr" class="divRow">
                <div>
                    <asp:Label ID="lblDescr" class="lbl" runat="server" Text="Descripciòn" Width="100%"></asp:Label>
                </div>
                <div>
                    <asp:TextBox ID="txtDescr" class="txt" runat="server" Width="100%"></asp:TextBox>
                </div>
            </div>

        </div>
                      
        <div id="divFooter" class="divFooter" style="margin-top: 10px; margin-left: 10px">

        </div>    

    </form>
</body>
</html>
