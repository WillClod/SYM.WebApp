<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="EpicMonth.ascx.cs" Inherits="SystemManager.Catalogs.Epic.EpicMonth" %>
<div id="divPeriod" style="border-width: 2px; border-color: #0000FF; background-color: <%=this.colorDiv%>; height: 16px;" >
    
    <div id="divHiddens">
        <asp:HiddenField ID="hdnCompId" runat="server" />
        <asp:HiddenField ID="hdnEpicId" runat="server" />        
    </div> 

    <div id="divDataSources">
        <asp:SqlDataSource ID="srcEpicStartDatePriorMonthUpd" runat="server" ConnectionString="<%$ ConnectionStrings:SystemManager %>" ProviderName="<%$ ConnectionStrings:SystemManager.ProviderName %>" UpdateCommand="EXEC sym.EpicStartDatePriorMonthUpd @pCompId, @pEpicId, @pUserId">
            <UpdateParameters>
                <asp:Parameter DbType="Int32" Name="pCompId" />
                <asp:Parameter DbType="Int32" Name="pEpicId" />
                <asp:Parameter DbType="Int32" Name="pUserId" />
            </UpdateParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="srcEpicStartDateNextMonthUpd" runat="server" ConnectionString="<%$ ConnectionStrings:SystemManager %>" ProviderName="<%$ ConnectionStrings:SystemManager.ProviderName %>" UpdateCommand="EXEC sym.EpicStartDateNextMonthUpd @pCompId, @pEpicId, @pUserId">
            <UpdateParameters>
                <asp:Parameter DbType="Int32" Name="pCompId" />
                <asp:Parameter DbType="Int32" Name="pEpicId" />
                <asp:Parameter DbType="Int32" Name="pUserId" />
            </UpdateParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="srcEpicEndDatePriorMonthUpd" runat="server" ConnectionString="<%$ ConnectionStrings:SystemManager %>" ProviderName="<%$ ConnectionStrings:SystemManager.ProviderName %>" UpdateCommand="EXEC sym.EpicEndDatePriorMonthUpd @pCompId, @pEpicId, @pUserId">
            <UpdateParameters>
                <asp:Parameter DbType="Int32" Name="pCompId" />
                <asp:Parameter DbType="Int32" Name="pEpicId" />
                <asp:Parameter DbType="Int32" Name="pUserId" />
            </UpdateParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="srcEpicEndDateNextMonthUpd" runat="server" ConnectionString="<%$ ConnectionStrings:SystemManager %>" ProviderName="<%$ ConnectionStrings:SystemManager.ProviderName %>" UpdateCommand="EXEC sym.EpicEndDateNextMonthUpd @pCompId, @pEpicId, @pUserId">
            <UpdateParameters>
                <asp:Parameter DbType="Int32" Name="pCompId" />
                <asp:Parameter DbType="Int32" Name="pEpicId" />
                <asp:Parameter DbType="Int32" Name="pUserId" />
            </UpdateParameters>
        </asp:SqlDataSource>
    </div>
        
    <div id="divStartPeriod" style="float: left; vertical-align: middle; margin-top: 0px;">
        <asp:ImageButton ID="btnBack" runat="server" ImageUrl="~/Images/IconBack16.png" ImageAlign="Top" OnClick="btnBack_Click" />
        <asp:ImageButton ID="btnRemoveStart" runat="server" ImageUrl="~/Images/IconBack16.png" ImageAlign="Top" OnClick="btnRemoveStart_Click" />
    </div>
    <div id="divContinuePeriod" style="float: left; vertical-align: middle; margin-top: 0px;">
        <asp:Label ID="lblMonthType" runat="server" Text="Type" Height="16px"></asp:Label>
    </div>
    <div id="divEndPeriod" style="float: right; vertical-align: middle; margin-top: 0px;">
        <asp:ImageButton ID="btnRemoveEnd" runat="server" ImageUrl="~/Images/IconNext16.png" ImageAlign="Top" OnClick="btnRemoveEnd_Click" />
        <asp:ImageButton ID="btnNext" runat="server" ImageUrl="~/Images/IconNext16.png" ImageAlign="Top" OnClick="btnNext_Click" />
    </div>


</div>

