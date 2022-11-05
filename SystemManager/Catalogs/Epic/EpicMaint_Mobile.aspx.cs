using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

namespace SystemManager.Catalogs.Epic
{
    public partial class EpicMaint_Mobile: System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // On Create page.
            if (!IsPostBack)
            {                
                // Get id;
                if (Request.QueryString["EpicId"] != null)
                {
                    hdnEpicId.Value = Request.QueryString["EpicId"];
                }

                // Fill combos.
                /*
                srcEpic.SelectParameters["CompId"].DefaultValue = hdnCompId.Value;
                cmbEpic.DataBind();
                */

                // Get record info if not for new.
                if(hdnEpicId.Value != "0")
                {
                    srcFeatureQuick.SelectParameters["FeatureId"].DefaultValue = hdnFeatureId.Value;
                    srcFeatureQuick.SelectParameters["CompId"].DefaultValue = hdnCompId.Value;
                    DataView dv = (DataView)srcFeatureQuick.Select(DataSourceSelectArguments.Empty);
                    if (dv != null)
                    {
                        DataTable dt = dv.ToTable();
                        if(dt.Rows.Count > 0)
                        {                            
                            txtCode.Text = dt.Rows[0]["Code"].ToString();
                            txtName.Text = dt.Rows[0]["Name"].ToString();
                            txtDescr.Text = dt.Rows[0]["Descr"].ToString();

                            cmbEpic.SelectedValue = dt.Rows[0]["EpicId"].ToString();
                            
                            srcCapability.SelectParameters["CompId"].DefaultValue = hdnCompId.Value;
                            srcCapability.SelectParameters["EpicId"].DefaultValue = cmbEpic.SelectedValue;
                            cmbCapability.DataBind();
                            cmbCapability.SelectedValue = dt.Rows[0]["CapabilityId"].ToString();
                        }
                        
                    }
                }
                
            }

        }

        /*
        protected void cmbEpic_DataBound(object sender, EventArgs e)
        {
            // Add item empty. 
            ListItem listItem = new ListItem();
            listItem.Text = "";
            listItem.Value = "*";
            cmbEpic.Items.Insert(0, listItem);
        }
        */

        /*
        protected void cmbCapability_DataBound(object sender, EventArgs e)
        {
            // Add item empty. 
            ListItem listItem = new ListItem();
            listItem.Text = "";
            listItem.Value = "*";
            cmbCapability.Items.Insert(0, listItem);
        }
        */

        /*
        protected void cmbEpic_SelectedIndexChanged(object sender, EventArgs e)
        {
            if(cmbEpic.SelectedValue == "*")
            {
                srcCapability.SelectParameters["CompId"].DefaultValue = "0";
                srcCapability.SelectParameters["EpicId"].DefaultValue = "0";                
            }
            else{ 
                srcCapability.SelectParameters["CompId"].DefaultValue = hdnCompId.Value;
                srcCapability.SelectParameters["EpicId"].DefaultValue = cmbEpic.SelectedValue;                
            }
            cmbCapability.DataBind();

        }
        */

        protected void btnSave_Click(object sender, EventArgs e)
        {
            if(hdnEpicId.Value == "0")
            {
                // Insert record.                   
                srcFeatureQuick.InsertParameters["CompId"].DefaultValue = hdnCompId.Value;
                srcFeatureQuick.InsertParameters["CapabilityId"].DefaultValue = cmbCapability.SelectedValue;
                srcFeatureQuick.InsertParameters["Code"].DefaultValue = txtCode.Text;
                srcFeatureQuick.InsertParameters["Name"].DefaultValue = txtName.Text;
                srcFeatureQuick.InsertParameters["Descr"].DefaultValue = txtDescr.Text;
                srcFeatureQuick.InsertParameters["UserId"].DefaultValue = hdnUserId.Value;

                try
                {                
                    srcFeatureQuick.Insert();
                }
                catch (Exception x)
                {
                    pcvAlert(x.Message);
                    return;
                }

            }
            else
            {
                // Update record.                   
                srcFeatureQuick.UpdateParameters["CompId"].DefaultValue = hdnCompId.Value;
                srcFeatureQuick.UpdateParameters["Id"].DefaultValue = hdnFeatureId.Value;
                srcFeatureQuick.UpdateParameters["CapabilityId"].DefaultValue = cmbCapability.SelectedValue;
                srcFeatureQuick.UpdateParameters["Code"].DefaultValue = txtCode.Text;
                srcFeatureQuick.UpdateParameters["Name"].DefaultValue = txtName.Text;
                srcFeatureQuick.UpdateParameters["Descr"].DefaultValue = txtDescr.Text;
                srcFeatureQuick.UpdateParameters["UserId"].DefaultValue = hdnUserId.Value;

                try
                {
                    srcFeatureQuick.Update();
                }
                catch (Exception x)
                {
                    pcvAlert(x.Message);
                    return;
                }
                
            }

            // OK Result.
            pcvAlert("Registro guardado");

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