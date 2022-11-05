<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="EpicMonthList.ascx.cs" Inherits="SystemManager.Catalogs.Epic.EpicMonthList" %>
<%@ Register Src="~/Catalogs/Epic/CalendarPeriod.ascx" TagPrefix="uc1" TagName="CalendarPeriod" %>

<div id="divGrid">
    <asp:HiddenField ID="hdnEpicId" runat="server" />
    <asp:GridView ID="grdEpicMonthList" runat="server" AutoGenerateColumns="False" DataSourceID="srcEpicMonthSel" ShowHeader="False" OnDataBound="grdEpicMonthList_DataBound" GridLines="None">
        <Columns>
            <asp:TemplateField HeaderText="January" SortExpression="January">
                <EditItemTemplate>
                    <asp:Label ID="Label1" runat="server" Text='<%# Eval("January") %>'></asp:Label>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:HiddenField ID="hdnPeriodTypeId01" runat="server" Value='<%# Eval("January") %>' />
                    <uc1:calendarperiod runat="server" id="ctrCalendarPeriod01" />
                </ItemTemplate>
                <ItemStyle HorizontalAlign="Center" Width="50px" />
            </asp:TemplateField>
            <asp:TemplateField HeaderText="February" SortExpression="February">
                <EditItemTemplate>
                    <asp:Label ID="Label2" runat="server" Text='<%# Eval("February") %>'></asp:Label>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:HiddenField ID="hdnPeriodTypeId02" runat="server" Value='<%# Eval("February") %>' />
                    <uc1:calendarperiod runat="server" id="ctrCalendarPeriod02" />
                </ItemTemplate>
                <ItemStyle HorizontalAlign="Center" Width="50px" />
            </asp:TemplateField>
            <asp:TemplateField HeaderText="March" SortExpression="March">
                <EditItemTemplate>
                    <asp:Label ID="Label3" runat="server" Text='<%# Eval("March") %>'></asp:Label>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:HiddenField ID="hdnPeriodTypeId03" runat="server" Value='<%# Eval("March") %>' />
                    <uc1:calendarperiod runat="server" id="ctrCalendarPeriod03" />
                </ItemTemplate>
                <ItemStyle HorizontalAlign="Center" Width="50px" />
            </asp:TemplateField>
            <asp:TemplateField HeaderText="April" SortExpression="April">
                <EditItemTemplate>
                    <asp:Label ID="Label4" runat="server" Text='<%# Eval("April") %>'></asp:Label>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:HiddenField ID="hdnPeriodTypeId04" runat="server" Value='<%# Eval("April") %>' />
                    <uc1:calendarperiod runat="server" id="ctrCalendarPeriod04" />
                </ItemTemplate>
                <ItemStyle HorizontalAlign="Center" Width="50px" />
            </asp:TemplateField>
            <asp:TemplateField HeaderText="May" SortExpression="May">
                <EditItemTemplate>
                    <asp:Label ID="Label5" runat="server" Text='<%# Eval("May") %>'></asp:Label>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:HiddenField ID="hdnPeriodTypeId05" runat="server" Value='<%# Eval("May") %>' />
                    <uc1:calendarperiod runat="server" id="ctrCalendarPeriod05" />
                </ItemTemplate>
                <ItemStyle HorizontalAlign="Center" Width="50px" />
            </asp:TemplateField>
            <asp:TemplateField HeaderText="June" SortExpression="June">
                <EditItemTemplate>
                    <asp:Label ID="Label6" runat="server" Text='<%# Eval("June") %>'></asp:Label>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:HiddenField ID="hdnPeriodTypeId06" runat="server" Value='<%# Eval("June") %>' />
                    <uc1:calendarperiod runat="server" id="ctrCalendarPeriod06" />
                </ItemTemplate>
                <ItemStyle HorizontalAlign="Center" Width="50px" />
            </asp:TemplateField>
            <asp:TemplateField HeaderText="July" SortExpression="July">
                <EditItemTemplate>
                    <asp:Label ID="Label7" runat="server" Text='<%# Eval("July") %>'></asp:Label>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:HiddenField ID="hdnPeriodTypeId07" runat="server" Value='<%# Eval("July") %>' />
                    <uc1:calendarperiod runat="server" id="ctrCalendarPeriod07" />
                </ItemTemplate>
                <ItemStyle HorizontalAlign="Center" Width="50px" />
            </asp:TemplateField>
            <asp:TemplateField HeaderText="August" SortExpression="August">
                <EditItemTemplate>
                    <asp:Label ID="Label8" runat="server" Text='<%# Eval("August") %>'></asp:Label>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:HiddenField ID="hdnPeriodTypeId08" runat="server" Value='<%# Eval("August") %>' />
                    <uc1:calendarperiod runat="server" id="ctrCalendarPeriod08" />
                </ItemTemplate>
                <ItemStyle HorizontalAlign="Center" Width="50px" />
            </asp:TemplateField>
            <asp:TemplateField HeaderText="September" SortExpression="September">
                <EditItemTemplate>
                    <asp:Label ID="Label9" runat="server" Text='<%# Eval("September") %>'></asp:Label>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:HiddenField ID="hdnPeriodTypeId09" runat="server" Value='<%# Eval("September") %>' />
                    <uc1:calendarperiod runat="server" id="ctrCalendarPeriod09" />
                </ItemTemplate>
                <ItemStyle HorizontalAlign="Center" Width="50px" />
            </asp:TemplateField>
            <asp:TemplateField HeaderText="October" SortExpression="October">
                <EditItemTemplate>
                    <asp:Label ID="Label10" runat="server" Text='<%# Eval("October") %>'></asp:Label>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:HiddenField ID="hdnPeriodTypeId10" runat="server" Value='<%# Eval("October") %>' />
                    <uc1:calendarperiod runat="server" id="ctrCalendarPeriod10" />
                </ItemTemplate>
                <ItemStyle HorizontalAlign="Center" Width="50px" />
            </asp:TemplateField>
            <asp:TemplateField HeaderText="November" SortExpression="November">
                <EditItemTemplate>
                    <asp:Label ID="Label11" runat="server" Text='<%# Eval("November") %>'></asp:Label>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:HiddenField ID="hdnPeriodTypeId11" runat="server" Value='<%# Eval("November") %>' />
                    <uc1:calendarperiod runat="server" id="ctrCalendarPeriod11" />
                </ItemTemplate>
                <ItemStyle HorizontalAlign="Center" Width="50px" />
            </asp:TemplateField>
            <asp:TemplateField HeaderText="December" SortExpression="December">
                <EditItemTemplate>
                    <asp:Label ID="Label12" runat="server" Text='<%# Eval("December") %>'></asp:Label>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:HiddenField ID="hdnPeriodTypeId12" runat="server" Value='<%# Eval("December") %>' />
                    <uc1:calendarperiod runat="server" id="ctrCalendarPeriod12" />
                </ItemTemplate>
                <ItemStyle HorizontalAlign="Center" Width="50px" />
            </asp:TemplateField>
        </Columns>
    </asp:GridView>
</div>
<div id = "divDataSource">
            <asp:SqlDataSource ID="srcEpicMonthSel" runat="server" ConnectionString="<%$ ConnectionStrings:SystemManager %>" SelectCommand="EXEC sym.EpicMonthSel @CompId, @EpicId, @YearId">
                <SelectParameters>
                    <asp:Parameter DbType="Int32" Name="CompId" />
                    <asp:Parameter DbType="Int32" Name="EpicId" />
                    <asp:Parameter DbType="Int16" Name="YearId" />
                </SelectParameters>
            </asp:SqlDataSource>
</div>
