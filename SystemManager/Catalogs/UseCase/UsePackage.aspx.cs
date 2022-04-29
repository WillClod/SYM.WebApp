using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

namespace SystemManager.Catalogs.UseCase
{
    public partial class UsePackage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // On Create page.
            if (!IsPostBack)
            {
                // Fill combos.
                cmbSystem.DataBind();
                cmbApplication.DataBind();
                cmbUseType.DataBind();

                // Fill grid.
                pcvGridList();
            }           
        }


        protected void cmbSystem_SelectedIndexChanged(object sender, EventArgs e)
        {
            cmbApplication.DataBind();
            pcvGridList();
        }

        protected void cmbApplication_SelectedIndexChanged(object sender, EventArgs e)
        {
            pcvGridList();
        }

        protected void cmxUseCaseType_SelectedIndexChanged(object sender, EventArgs e)
        {
            pcvGridList();
        }

        protected void btnCancel_Click(object sender, ImageClickEventArgs e)
        {
            grdUsePackage.EditIndex = -1;
        }

        protected void grdUsePackage_RowCommand(object sender, GridViewCommandEventArgs e)
        {

            // If row save button click ... 
            if ((e.CommandName == "SavePackage") && (e.CommandArgument != ""))
            {
                // Get row controls.
                TextBox txtNumber = (TextBox)grdUsePackage.Rows[Convert.ToInt32(e.CommandArgument)].FindControl("txtNumber");
                TextBox txtFunction = (TextBox)grdUsePackage.Rows[Convert.ToInt32(e.CommandArgument)].FindControl("txtFunction");
                HiddenField hdnApplicationCode = (HiddenField)grdUsePackage.Rows[Convert.ToInt32(e.CommandArgument)].FindControl("hdnApplicationCode");
                HiddenField hdnUseTypeCode = (HiddenField)grdUsePackage.Rows[Convert.ToInt32(e.CommandArgument)].FindControl("hdnUseTypeCode");
                HiddenField hdnId = (HiddenField)grdUsePackage.Rows[Convert.ToInt32(e.CommandArgument)].FindControl("hdnId");
                DropDownList cmbUseType = (DropDownList)grdUsePackage.Rows[Convert.ToInt32(e.CommandArgument)].FindControl("cmbUseType");

                // Data validations.
                // ...

                // If new ...
                if (hdnId.Value == "0") 
                {
                    // Set var.
                    string vlsApplicationCode = "";
                    string vlsUseTypeCode = "";

                    // Get Application code.
                    srcGetApplicationCode.SelectParameters["ApplicationId"].DefaultValue = cmbApplication.SelectedValue;
                    DataView dv = (DataView)srcGetApplicationCode.Select(DataSourceSelectArguments.Empty);
                    if (dv != null)
                    {
                        DataTable dt = dv.ToTable();
                        vlsApplicationCode = dt.Rows[0]["Code"].ToString();
                    }

                    // Get Use Type code.
                    srcGetUseTypeCode.SelectParameters["UseTypeId"].DefaultValue = cmbUseType.SelectedValue;
                    dv = (DataView)srcGetUseTypeCode.Select(DataSourceSelectArguments.Empty);
                    if (dv != null)
                    {
                        DataTable dt = dv.ToTable();
                        vlsUseTypeCode = dt.Rows[0]["Code"].ToString();
                    }

                    // Insert record.
                    srcUsePackage.InsertParameters["CompanyId"].DefaultValue = "1";
                    srcUsePackage.InsertParameters["ApplicationId"].DefaultValue = cmbApplication.SelectedValue;
                    srcUsePackage.InsertParameters["UseTypeId"].DefaultValue = cmbUseType.SelectedValue;
                    srcUsePackage.InsertParameters["UseStatusId"].DefaultValue = "1";
                    srcUsePackage.InsertParameters["Number"].DefaultValue = txtNumber.Text;                    
                    srcUsePackage.InsertParameters["Function"].DefaultValue = txtFunction.Text;
                    srcUsePackage.InsertParameters["Name"].DefaultValue = vlsApplicationCode + "." + vlsUseTypeCode + "." + txtNumber.Text + " " + txtFunction.Text;
                    srcUsePackage.InsertParameters["Description"].DefaultValue = "";
                    srcUsePackage.InsertParameters["IsActive"].DefaultValue = "1";
                    srcUsePackage.InsertParameters["CreateUserId"].DefaultValue = "2";                   
                    srcUsePackage.Insert();
                }
                else // If edit ... 
                {
                    // Update record.
                    srcUsePackage.UpdateParameters["CompanyId"].DefaultValue = "1";
                    srcUsePackage.UpdateParameters["Id"].DefaultValue = hdnId.Value;
                    srcUsePackage.UpdateParameters["Number"].DefaultValue = txtNumber.Text;
                    srcUsePackage.UpdateParameters["Function"].DefaultValue = txtFunction.Text;
                    srcUsePackage.UpdateParameters["Name"].DefaultValue = hdnApplicationCode.Value + "." + hdnUseTypeCode.Value + "." + txtNumber.Text + " " + txtFunction.Text;
                    srcUsePackage.UpdateParameters["UserId"].DefaultValue = "2";
                    srcUsePackage.UpdateParameters["UseTypeId"].DefaultValue = cmbUseType.SelectedValue;
                    srcUsePackage.Update();
                }

                // Remove row edit view.
                grdUsePackage.EditIndex = -1;
                grdUsePackage.DataBind();
            }
        }

        public void pcvGridList()
        {
            grdUsePackage.DataBind();
        }

        protected void grdUsePackage_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                // Get controls.
                ImageButton btnSave = (ImageButton)e.Row.FindControl("btnSave");

                // Set controls.
                if (btnSave != null)
                {
                    //btnSave.Attributes["onclick"] = ClientScript.GetPostBackClientHyperlink(grdUsePackage, "SavePackage$" + e.Row.DataItemIndex, true);
                    btnSave.CommandName = "SavePackage";
                    btnSave.CommandArgument = e.Row.DataItemIndex.ToString();
                }
            }
        }

        protected void cmbUseType_DataBound(object sender, EventArgs e)
        {
            // Add all item. 
            ListItem listItem = new ListItem();
            listItem.Text = "Todos";
            listItem.Value = "-1";
            cmbUseType.Items.Insert(0, listItem);
        }

        protected void lnkNew_Click(object sender, EventArgs e)
        {
            // Set as edit last row (new).
            grdUsePackage.EditIndex = grdUsePackage.Rows.Count - 1;
        }

        protected void grdUsePackage_DataBound(object sender, EventArgs e)
        {
            // Set Variables.
            HiddenField hdnUsePackageId;
            UsePackageCase _UsePackageCase;

            foreach (GridViewRow gvRow in grdUsePackage.Rows)
            {
                /*
                for (int i = 0; i < gvRow.Cells.Count; i++)
                {
                    // Get control cell.
                    hdnUsePackageId = (HiddenField)gvRow.FindControl("hdnUsePackageId" + i.ToString());

                    if (hdnUsePackageId != null)
                    {
                        // Refresh user control.                    
                        _UsePackageCase = (UsePackageCase)gvRow.FindControl("UsePackageCase" + i.ToString());
                        _UsePackageCase.vciUsePackageId = Convert.ToInt32(hdnUsePackageId.Value);
                        _UsePackageCase.vcbRefresh = true;
                    }
                }
                */

                // Get control cell.
                hdnUsePackageId = (HiddenField)gvRow.FindControl("hdnUsePackageId");

                if (hdnUsePackageId != null)
                {
                    // Refresh user control.                    
                    _UsePackageCase = (UsePackageCase)gvRow.FindControl("UsePackageCase");
                    _UsePackageCase.vciUsePackageId = Convert.ToInt32(hdnUsePackageId.Value);
                    _UsePackageCase.vcbRefresh = true;
                }
            }
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

    }
}