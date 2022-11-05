using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Threading;     // For set Culture.
using System.Globalization; // For set Culture.

namespace SystemManager.Catalogs.Feature
{
    public partial class FeatureMaint_Mobile: System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            // Set culture.
            Thread.CurrentThread.CurrentCulture = CultureInfo.CreateSpecificCulture("es-Mx");
            Thread.CurrentThread.CurrentUICulture = new CultureInfo("es-MX");

            // On Create page.
            if (!IsPostBack)
            {                
                // Get id;
                if (Request.QueryString["FeatureId"] != null)
                {
                    hdnFeatureId.Value = Request.QueryString["FeatureId"];
                }

                // Fill combos.
                srcEpic.SelectParameters["CompId"].DefaultValue = hdnCompId.Value;
                cmbEpic.DataBind();

                // Get record info if for edit.
                if(hdnFeatureId.Value != "0")
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

                            cmbStatus.SelectedValue = dt.Rows[0]["StatusId"].ToString();

                            DateTime vldDate = Convert.ToDateTime(dt.Rows[0]["StartDate"].ToString());
                            txtStartDate.Text = vldDate.ToString("dd/MM/yyyy");

                            vldDate = Convert.ToDateTime(dt.Rows[0]["EndDate"].ToString());
                            txtEndDate.Text = vldDate.ToString("dd/MM/yyyy");

                        }
                        
                    }

                    // Disable key combos.
                    cmbEpic.Enabled = false;
                    cmbCapability.Enabled = false;
                }
                else // If is for new.
                {
                    // Set Epic and Features selected from list page.
                    if (Request.QueryString["EpicId"] != null)
                    {
                        hdnEpicId.Value = Request.QueryString["EpicId"];

                        cmbEpic.SelectedValue = hdnEpicId.Value;

                        srcCapability.SelectParameters["CompId"].DefaultValue = hdnCompId.Value;
                        srcCapability.SelectParameters["EpicId"].DefaultValue = cmbEpic.SelectedValue;
                        cmbCapability.DataBind();

                        if (Request.QueryString["CapabilityId"] != null)
                        {
                            hdnCapabilityId.Value = Request.QueryString["CapabilityId"];
                            cmbCapability.SelectedValue = hdnCapabilityId.Value;
                        }


                        DateTime vldToday = DateTime.Today;                        
                        txtStartDate.Text = vldToday.ToString("dd/MM/yyyy");
                        txtEndDate.Text = vldToday.ToString("dd/MM/yyyy");

                    }

                }
                
            }

        }

        protected void cmbEpic_DataBound(object sender, EventArgs e)
        {
            // Add item empty. 
            ListItem listItem = new ListItem();
            listItem.Text = "Seleccionar";
            listItem.Value = "0";
            cmbEpic.Items.Insert(0, listItem);
        }

        protected void cmbCapability_DataBound(object sender, EventArgs e)
        {
            // Add item empty. 
            ListItem listItem = new ListItem();
            listItem.Text = "Seleccionar";
            listItem.Value = "0";
            cmbCapability.Items.Insert(0, listItem);
        }

        protected void cmbEpic_SelectedIndexChanged(object sender, EventArgs e)
        {
            if(cmbEpic.SelectedValue == "0")
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

        protected void btnBack_Click(object sender, ImageClickEventArgs e)
        {
            // Load List Page.
            Server.Transfer("FeatureList_Mobile.aspx?EpicId=" + cmbEpic.SelectedValue + "&CapabilityId=" + cmbCapability.SelectedValue);
        }

        protected void btnSave_Click(object sender, ImageClickEventArgs e)
        {
            if (hdnFeatureId.Value == "0")
            {
                // Insert record.                   
                srcFeatureQuick.InsertParameters["CompId"].DefaultValue = hdnCompId.Value;
                srcFeatureQuick.InsertParameters["CapabilityId"].DefaultValue = cmbCapability.SelectedValue;
                srcFeatureQuick.InsertParameters["Code"].DefaultValue = txtCode.Text;
                srcFeatureQuick.InsertParameters["Name"].DefaultValue = txtName.Text;
                srcFeatureQuick.InsertParameters["Descr"].DefaultValue = txtDescr.Text;
                srcFeatureQuick.InsertParameters["StatusId"].DefaultValue = cmbStatus.SelectedValue;

                string vlsStartDate = Request.Form[txtStartDate.UniqueID];
                srcFeatureQuick.InsertParameters["StartDate"].DefaultValue = vlsStartDate;

                string vlsEndDate = Request.Form[txtEndDate.UniqueID];
                srcFeatureQuick.InsertParameters["EndDate"].DefaultValue = vlsEndDate;

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
                srcFeatureQuick.UpdateParameters["StatusId"].DefaultValue = cmbStatus.SelectedValue;
                srcFeatureQuick.UpdateParameters["Descr"].DefaultValue = txtDescr.Text;

                string vlsStartDate = Request.Form[txtStartDate.UniqueID];
                srcFeatureQuick.UpdateParameters["StartDate"].DefaultValue = vlsStartDate;

                string vlsEndDate = Request.Form[txtEndDate.UniqueID];
                srcFeatureQuick.UpdateParameters["EndDate"].DefaultValue = vlsEndDate;

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
    }
}