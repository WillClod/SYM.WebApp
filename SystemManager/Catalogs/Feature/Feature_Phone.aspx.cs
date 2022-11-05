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
    public partial class Feature_Phone: System.Web.UI.Page
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
                /*
                if (Request.QueryString["FeatureId"] != null)
                {
                    hdnFeatureId.Value = Request.QueryString["FeatureId"];
                }
                */

                // Fill combos.
                srcEpic.SelectParameters["CompId"].DefaultValue = hdnCompId.Value;
                cmbEpic.DataBind();


                // Set Epic and Features received.
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

                    // List Mian Grid.
                    pcvListMainGrid();

                }

            }

        }

        protected void cmbEpic_DataBound(object sender, EventArgs e)
        {
            // Add item empty. 
            ListItem listItem = new ListItem();
            listItem.Text = "";
            listItem.Value = "*";
            cmbEpic.Items.Insert(0, listItem);
        }

        protected void cmbCapability_DataBound(object sender, EventArgs e)
        {
            // Add item empty. 
            ListItem listItem = new ListItem();
            listItem.Text = "";
            listItem.Value = "*";
            cmbCapability.Items.Insert(0, listItem);
        }

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

        protected void cmbCapability_SelectedIndexChanged(object sender, EventArgs e)
        {
            // List Mian Grid.
            pcvListMainGrid();
        }

        public void pcvListMainGrid()
        {
            // Fill Grid.
            if (cmbCapability.SelectedValue != "*")
            {
                srcFeatureQuick.SelectParameters["CompId"].DefaultValue = hdnCompId.Value;
                srcFeatureQuick.SelectParameters["CapabilityId"].DefaultValue = cmbCapability.SelectedValue;
                srcFeatureQuick.SelectParameters["ListBackLogStatus"].DefaultValue = "true";
                srcFeatureQuick.SelectParameters["ListOnProcessStatus"].DefaultValue = "true";
                srcFeatureQuick.SelectParameters["ListCompleteStatus"].DefaultValue = "true";
                gvwMain.DataBind();
            }
        }

        protected void gvwMain_RowCommand(object sender, GridViewCommandEventArgs e)
        {

            if (e.CommandName == "Select")
            {
                // Load page to edit record.
                HiddenField hdnFeatureId = (HiddenField)gvwMain.Rows[Convert.ToInt32(e.CommandArgument)].FindControl("hdnFeatureId");
                
                // Load Maint Page.
                Server.Transfer("FeatureMaint_Mobile.aspx?EpicId=" + cmbEpic.SelectedValue + "&CapabilityId=" + cmbCapability.SelectedValue + "&FeatureID=" + hdnFeatureId.Value);
            }

        }


        protected void gvwMain_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                // Get controls.
                LinkButton lnkCode = (LinkButton)e.Row.FindControl("lnkCode");

                // Set row id.
                //lnkCode.Attributes["onclick"] = ClientScript.GetPostBackClientHyperlink(gvwMain, "Select$" + e.Row.DataItemIndex, true);
                lnkCode.CommandArgument = e.Row.DataItemIndex.ToString();

            }

        }

        protected void btnNew_Click(object sender, ImageClickEventArgs e)
        {
            // Load Maint Page.
            Server.Transfer("FeatureMaint_Mobile.aspx?EpicId=" + cmbEpic.SelectedValue + "&CapabilityId=" + cmbCapability.SelectedValue + "&FeatureID=0");
        }
    }
}