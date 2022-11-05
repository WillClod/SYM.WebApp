<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="CapabilityList.ascx.cs" Inherits="SystemManager.Catalogs.Epic.CapabilityList" %>
<div id = "divHidden">
    <asp:HiddenField ID="hdnEpicId" runat="server" />
</div>
<div id="divGrid">
    
    <asp:GridView ID="grdCapability" runat="server" AutoGenerateColumns="False" DataSourceID="srcCapability" GridLines="None" ShowHeader="False">
        <Columns>
            <asp:TemplateField HeaderText="CapabiltyInfo">
                <ItemTemplate>
                    <asp:LinkButton ID="lnkCapabilityName" runat="server" CommandName="Edit" Text='<%# Eval("CapabilityCode") %>'></asp:LinkButton>                    
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>
    
</div>
<div id = "divDataSource">
    
                <asp:SqlDataSource ID="srcCapability" runat="server" ConnectionString="<%$ ConnectionStrings:SystemManager %>" ProviderName="<%$ ConnectionStrings:SystemManager.ProviderName %>" SelectCommand="(
SELECT
1 AS DataSetType,
C.Id AS CapabilityId,
C.Num AS CapabilityNum,
C.Code AS CapabilityCode,
C.Name AS CapabilityName,
MS.Code AS CapabilityStatus,
T.Code AS DevTeamCode,
C.PlanStartDate AS StartDate,
C.PlanEndDate AS EndDate
FROM sym.Capability C
INNER JOIN sym.MainStatus MS ON MS.Id = C.MainStatusId
LEFT  JOIN sym.Team T ON T.CompId = C.CompId AND T.Id = C.DevTeamId
WHERE EpicId = @EpicId
UNION
SELECT 
2 AS DataSetType,
0 AS CapabilityId,
'' AS CapabilityNum,
'' AS CapabilityCode,
'' AS CapabilityName,
'' AS CapabilityStatus,
'' AS DevTeamCode,
NULL AS StartDate,
NULL AS EndDate
)
">
                    <SelectParameters>
                        <asp:Parameter DbType="Int32" Name="EpicId" />
                    </SelectParameters>
                </asp:SqlDataSource>
    
</div>
