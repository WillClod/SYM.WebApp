using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

namespace SystemManager.Catalogs.UseCase
{
    public partial class UsePackageCase : System.Web.UI.UserControl
    {
        public int vciUsePackageId { get; set; }

        private bool _vcbRefresh;
        public bool vcbRefresh
        {
            get { return _vcbRefresh; }
            set
            {
                _vcbRefresh = value;

                // Refresh grid.
                srcUseCase.SelectParameters["UsePackageId"].DefaultValue = vciUsePackageId.ToString();
                hdnUsePackageId.Value = vciUsePackageId.ToString();
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnCancel_Click(object sender, ImageClickEventArgs e)
        {
            grdUseCase.EditIndex = -1;
        }

        protected void lnkNew_Click(object sender, EventArgs e)
        {
            // Set as edit last row (new).
            grdUseCase.EditIndex = grdUseCase.Rows.Count - 1;
        }

        protected void grdUseCase_RowDataBound(object sender, GridViewRowEventArgs e)
        {
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
        }

        protected void grdUseCase_RowCommand(object sender, GridViewCommandEventArgs e)
        {
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