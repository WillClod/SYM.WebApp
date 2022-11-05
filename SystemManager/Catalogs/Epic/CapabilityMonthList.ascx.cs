using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

namespace SystemManager.Catalogs.Epic
{
    public partial class CapabilityMonthList : System.Web.UI.UserControl
    {
        // Define control parameters.
        public int vciCompId { get; set; }
        public int vciEpicId { get; set; }
        public int vciYearId { get; set; }

        // Refresh method.
        private bool _vcbRefresh;
        public bool vcbRefresh
        {
            get { return _vcbRefresh; }
            set
            {
                _vcbRefresh = value;

                // Refresh grid.                
                srcCapabilityMonthSel.SelectParameters["CompId"].DefaultValue = vciCompId.ToString();
                srcCapabilityMonthSel.SelectParameters["EpicId"].DefaultValue = vciEpicId.ToString();
                srcCapabilityMonthSel.SelectParameters["YearId"].DefaultValue = vciYearId.ToString();
                hdnEpicId.Value = vciEpicId.ToString();
                
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnCancel_Click(object sender, ImageClickEventArgs e)
        {
            /*
            grdUseCase.EditIndex = -1;
            */
        }

        protected void lnkNew_Click(object sender, EventArgs e)
        {
            // Set as edit last row (new).
            /*
            grdUseCase.EditIndex = grdUseCase.Rows.Count - 1;
            */
        }

        protected void grdUseCase_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            /*
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                // Get controls.
                ImageButton btnSave = (ImageButton)e.Row.FindControl("btnSave");
                ImageButton btnEdit = (ImageButton)e.Row.FindControl("btnEdit");

                // Set controls.
                if (btnSave != null)
                {
                    btnSave.CommandName = "Save";
                    btnSave.CommandArgument = e.Row.DataItemIndex.ToString();
                }

                if (btnEdit != null)
                {
                    btnEdit.CommandName = "EditUseCase";
                    btnEdit.CommandArgument = e.Row.DataItemIndex.ToString();
                }
            }
            */
        }

        protected void grdUseCase_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            /*
            // If row edit button click ... 
            if ((e.CommandName == "EditUseCase") && (e.CommandArgument != ""))
            {
                //pcvAlert("Edit Use Case");

                // Get row controls.
                HiddenField hdnId = (HiddenField)grdUseCase.Rows[Convert.ToInt32(e.CommandArgument)].FindControl("hdnId");

                // Show edit page.
                Server.Transfer("UseCase.aspx?UseCaseId=" + hdnId.Value);
            }

            // If row save button click ... 
            if ((e.CommandName == "Save") && (e.CommandArgument != ""))
            {
                // Get row controls.
                TextBox txtNumber = (TextBox)grdUseCase.Rows[Convert.ToInt32(e.CommandArgument)].FindControl("txtNumber");
                TextBox txtFunction = (TextBox)grdUseCase.Rows[Convert.ToInt32(e.CommandArgument)].FindControl("txtFunction");
                TextBox txtDescription = (TextBox)grdUseCase.Rows[Convert.ToInt32(e.CommandArgument)].FindControl("txtDescription");
                HiddenField hdnId = (HiddenField)grdUseCase.Rows[Convert.ToInt32(e.CommandArgument)].FindControl("hdnId");
                DropDownList cmbStatus = (DropDownList)grdUseCase.Rows[Convert.ToInt32(e.CommandArgument)].FindControl("cmbStatus");

                // Data validations.
                // ...


                // Set var.
                string vlsApplicationName = "";
                string vlsApplicationFunction = "";

                // Get Application info.                    
                srcUsePackage.SelectParameters["Id"].DefaultValue = hdnUsePackageId.Value;
                DataView dv = (DataView)srcUsePackage.Select(DataSourceSelectArguments.Empty);
                if (dv != null)
                {
                    DataTable dt = dv.ToTable();
                    vlsApplicationName = dt.Rows[0]["ApplicationName"].ToString();
                    vlsApplicationFunction = dt.Rows[0]["Function"].ToString();
                }

                // If new ...
                if (hdnId.Value == "0")
                {                   
                    // Insert record.
                    srcUseCase.InsertParameters["CompanyId"].DefaultValue = "1";
                    srcUseCase.InsertParameters["UsePackageId"].DefaultValue = hdnUsePackageId.Value;
                    srcUseCase.InsertParameters["UseStatusId"].DefaultValue = cmbStatus.SelectedValue;
                    srcUseCase.InsertParameters["Number"].DefaultValue = txtNumber.Text;
                    srcUseCase.InsertParameters["Function"].DefaultValue = txtFunction.Text;
                    srcUseCase.InsertParameters["Name"].DefaultValue = vlsApplicationName + "." + txtNumber.Text + " " + txtFunction.Text;
                    srcUseCase.InsertParameters["Description"].DefaultValue = txtDescription.Text;
                    srcUseCase.InsertParameters["IsActive"].DefaultValue = "1";
                    srcUseCase.InsertParameters["CreateUserId"].DefaultValue = "2";
                    srcUseCase.Insert();
                    
                }
                else // If edit ... 
                {
                    // Update record.
                    srcUseCase.UpdateParameters["CompanyId"].DefaultValue = "1";
                    srcUseCase.UpdateParameters["Id"].DefaultValue = hdnId.Value;
                    srcUseCase.UpdateParameters["Number"].DefaultValue = txtNumber.Text;
                    srcUseCase.UpdateParameters["Function"].DefaultValue = txtFunction.Text;
                    srcUseCase.UpdateParameters["Description"].DefaultValue = txtDescription.Text;
                    srcUseCase.UpdateParameters["Name"].DefaultValue = vlsApplicationName + "." + txtNumber.Text + " " + txtFunction.Text;
                    srcUseCase.UpdateParameters["UserId"].DefaultValue = "2";
                    srcUseCase.UpdateParameters["UseStatusId"].DefaultValue = cmbStatus.SelectedValue;
                    srcUseCase.Update();
                }

                // Remove row edit view.
                grdUseCase.EditIndex = -1;
                grdUseCase.DataBind();
            }
            */

        }

        public void pcvAlert(string vpsMessage)
        {
            // Cleans the message to allow single quotation marks 
            string vlsCleanMessage = vpsMessage.Replace("'", " ");
            vlsCleanMessage = vlsCleanMessage.Replace("\n", "\\n");
            vlsCleanMessage = vlsCleanMessage.Replace("\r", "\\r");
            string vlsScript = "<script language=JavaScript>alert('" + vpsMessage + "');</script>";

            // Gets the executing web page 
            Page page = HttpContext.Current.CurrentHandler as Page;

            // Checks if the handler is a Page and that the script isn't allready on the Page 
            if (page != null && !page.ClientScript.IsClientScriptBlockRegistered("alert"))
            {
                Page.ClientScript.RegisterStartupScript(this.GetType(), "ErrorAlert", "alert('" + vlsCleanMessage + "');", true);
            }
        }

        protected void grdCapabilityMonthList_DataBound(object sender, EventArgs e)
        {
            // Set Variables.
            HiddenField hdnCapabilityId;
            HiddenField hdnPeriodTypeId01;
            HiddenField hdnPeriodTypeId02;
            HiddenField hdnPeriodTypeId03;
            HiddenField hdnPeriodTypeId04;
            HiddenField hdnPeriodTypeId05;
            HiddenField hdnPeriodTypeId06;
            HiddenField hdnPeriodTypeId07;
            HiddenField hdnPeriodTypeId08;
            HiddenField hdnPeriodTypeId09;
            HiddenField hdnPeriodTypeId10;
            HiddenField hdnPeriodTypeId11;
            HiddenField hdnPeriodTypeId12;
            CapabilityMonth _CapabilityMonth;

            foreach (GridViewRow gvRow in grdCapabilityMonthList.Rows)
            {
                // Get control cell.
                hdnCapabilityId = (HiddenField)gvRow.FindControl("hdnCapabilityId");
                hdnPeriodTypeId01 = (HiddenField)gvRow.FindControl("hdnPeriodTypeId01");
                hdnPeriodTypeId02 = (HiddenField)gvRow.FindControl("hdnPeriodTypeId02");
                hdnPeriodTypeId03 = (HiddenField)gvRow.FindControl("hdnPeriodTypeId03");
                hdnPeriodTypeId04 = (HiddenField)gvRow.FindControl("hdnPeriodTypeId04");
                hdnPeriodTypeId05 = (HiddenField)gvRow.FindControl("hdnPeriodTypeId05");
                hdnPeriodTypeId06 = (HiddenField)gvRow.FindControl("hdnPeriodTypeId06");
                hdnPeriodTypeId07 = (HiddenField)gvRow.FindControl("hdnPeriodTypeId07");
                hdnPeriodTypeId08 = (HiddenField)gvRow.FindControl("hdnPeriodTypeId08");
                hdnPeriodTypeId09 = (HiddenField)gvRow.FindControl("hdnPeriodTypeId09");
                hdnPeriodTypeId10 = (HiddenField)gvRow.FindControl("hdnPeriodTypeId10");
                hdnPeriodTypeId11 = (HiddenField)gvRow.FindControl("hdnPeriodTypeId11");
                hdnPeriodTypeId12 = (HiddenField)gvRow.FindControl("hdnPeriodTypeId12");

                if (hdnPeriodTypeId01 != null)
                {
                    // Refresh user control.                    
                    _CapabilityMonth = (CapabilityMonth)gvRow.FindControl("ctrCapabilityMonth01");
                    _CapabilityMonth.vciCompId = vciCompId;
                    _CapabilityMonth.vciCapabilityId = Convert.ToInt32(hdnCapabilityId.Value);                    
                    _CapabilityMonth.vciPeriodTypeId = Convert.ToInt32(hdnPeriodTypeId01.Value);                    
                    _CapabilityMonth.vcbRefresh = true;
                }

                if (hdnPeriodTypeId02 != null)
                {
                    // Refresh user control.                    
                    _CapabilityMonth = (CapabilityMonth)gvRow.FindControl("ctrCapabilityMonth02");
                    _CapabilityMonth.vciCompId = vciCompId;
                    _CapabilityMonth.vciCapabilityId = Convert.ToInt32(hdnCapabilityId.Value);
                    _CapabilityMonth.vciPeriodTypeId = Convert.ToInt32(hdnPeriodTypeId02.Value);
                    _CapabilityMonth.vcbRefresh = true;
                }

                if (hdnPeriodTypeId03 != null)
                {
                    // Refresh user control.                    
                    _CapabilityMonth = (CapabilityMonth)gvRow.FindControl("ctrCapabilityMonth03");
                    _CapabilityMonth.vciCompId = vciCompId;
                    _CapabilityMonth.vciCapabilityId = Convert.ToInt32(hdnCapabilityId.Value);
                    _CapabilityMonth.vciPeriodTypeId = Convert.ToInt32(hdnPeriodTypeId03.Value);
                    _CapabilityMonth.vcbRefresh = true;
                }

                if (hdnPeriodTypeId04 != null)
                {
                    // Refresh user control.                    
                    _CapabilityMonth = (CapabilityMonth)gvRow.FindControl("ctrCapabilityMonth04");
                    _CapabilityMonth.vciCompId = vciCompId;
                    _CapabilityMonth.vciCapabilityId = Convert.ToInt32(hdnCapabilityId.Value);
                    _CapabilityMonth.vciPeriodTypeId = Convert.ToInt32(hdnPeriodTypeId04.Value);
                    _CapabilityMonth.vcbRefresh = true;
                }

                if (hdnPeriodTypeId05 != null)
                {
                    // Refresh user control.                    
                    _CapabilityMonth = (CapabilityMonth)gvRow.FindControl("ctrCapabilityMonth05");
                    _CapabilityMonth.vciCompId = vciCompId;
                    _CapabilityMonth.vciCapabilityId = Convert.ToInt32(hdnCapabilityId.Value);
                    _CapabilityMonth.vciPeriodTypeId = Convert.ToInt32(hdnPeriodTypeId05.Value);                 
                    _CapabilityMonth.vcbRefresh = true;
                }

                if (hdnPeriodTypeId06 != null)
                {
                    // Refresh user control.                    
                    _CapabilityMonth = (CapabilityMonth)gvRow.FindControl("ctrCapabilityMonth06");
                    _CapabilityMonth.vciCompId = vciCompId;
                    _CapabilityMonth.vciCapabilityId = Convert.ToInt32(hdnCapabilityId.Value);
                    _CapabilityMonth.vciPeriodTypeId = Convert.ToInt32(hdnPeriodTypeId06.Value);
                    _CapabilityMonth.vcbRefresh = true;
                }

                if (hdnPeriodTypeId07 != null)
                {
                    // Refresh user control.                    
                    _CapabilityMonth = (CapabilityMonth)gvRow.FindControl("ctrCapabilityMonth07");
                    _CapabilityMonth.vciCompId = vciCompId;
                    _CapabilityMonth.vciCapabilityId = Convert.ToInt32(hdnCapabilityId.Value);
                    _CapabilityMonth.vciPeriodTypeId = Convert.ToInt32(hdnPeriodTypeId07.Value);
                    _CapabilityMonth.vcbRefresh = true;
                }

                if (hdnPeriodTypeId08 != null)
                {
                    // Refresh user control.                    
                    _CapabilityMonth = (CapabilityMonth)gvRow.FindControl("ctrCapabilityMonth08");
                    _CapabilityMonth.vciCompId = vciCompId;
                    _CapabilityMonth.vciCapabilityId = Convert.ToInt32(hdnCapabilityId.Value);
                    _CapabilityMonth.vciPeriodTypeId = Convert.ToInt32(hdnPeriodTypeId08.Value);
                    _CapabilityMonth.vcbRefresh = true;
                }

                if (hdnPeriodTypeId09 != null)
                {
                    // Refresh user control.                    
                    _CapabilityMonth = (CapabilityMonth)gvRow.FindControl("ctrCapabilityMonth09");
                    _CapabilityMonth.vciCompId = vciCompId;
                    _CapabilityMonth.vciCapabilityId = Convert.ToInt32(hdnCapabilityId.Value);
                    _CapabilityMonth.vciPeriodTypeId = Convert.ToInt32(hdnPeriodTypeId09.Value);
                    _CapabilityMonth.vcbRefresh = true;
                }

                if (hdnPeriodTypeId10 != null)
                {
                    // Refresh user control.                    
                    _CapabilityMonth = (CapabilityMonth)gvRow.FindControl("ctrCapabilityMonth10");
                    _CapabilityMonth.vciCompId = vciCompId;
                    _CapabilityMonth.vciCapabilityId = Convert.ToInt32(hdnCapabilityId.Value);
                    _CapabilityMonth.vciPeriodTypeId = Convert.ToInt32(hdnPeriodTypeId10.Value);
                    _CapabilityMonth.vcbRefresh = true;
                }

                if (hdnPeriodTypeId11 != null)
                {
                    // Refresh user control.                    
                    _CapabilityMonth = (CapabilityMonth)gvRow.FindControl("ctrCapabilityMonth11");
                    _CapabilityMonth.vciCompId = vciCompId;
                    _CapabilityMonth.vciCapabilityId = Convert.ToInt32(hdnCapabilityId.Value);
                    _CapabilityMonth.vciPeriodTypeId = Convert.ToInt32(hdnPeriodTypeId11.Value);
                    _CapabilityMonth.vcbRefresh = true;
                }

                if (hdnPeriodTypeId12 != null)
                {
                    // Refresh user control.                    
                    _CapabilityMonth = (CapabilityMonth)gvRow.FindControl("ctrCapabilityMonth12");
                    _CapabilityMonth.vciCompId = vciCompId;
                    _CapabilityMonth.vciCapabilityId = Convert.ToInt32(hdnCapabilityId.Value);
                    _CapabilityMonth.vciPeriodTypeId = Convert.ToInt32(hdnPeriodTypeId12.Value);
                    _CapabilityMonth.vcbRefresh = true;
                }

            }
        }
    }
}