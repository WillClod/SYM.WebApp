using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

namespace SystemManager.Catalogs.Epic
{
    public partial class CapabilityMonth : System.Web.UI.UserControl
    {
        public string colorDiv { get { return ViewState["colordiv"].ToString(); } }

        // Define control parameters.
        public int vciCompId { get; set; }
        public int vciCapabilityId { get; set; }
        public int vciPeriodTypeId { get; set; }
        
        // Refresh method.
        private bool _vcbRefresh;
        public bool vcbRefresh
        {
            get { return _vcbRefresh; }
            set
            {
                _vcbRefresh = value;

                hdnCompId.Value = vciCompId.ToString();
                hdnCapabilityId.Value = vciCapabilityId.ToString();

                // Set values.
                //lblMonthType.Text = vciPeriodTypeId.ToString();
                lblMonthType.Text = "";
                lblMonthType.Visible = false;
                btnBack.Visible = false;
                btnRemoveStart.Visible = false;
                btnRemoveEnd.Visible = false;
                btnNext.Visible = false;
                ViewState["colordiv"] = "";

                // In Month only there is StartDate.
                if (vciPeriodTypeId == 1)
                {
                    btnBack.Visible = true;
                    btnRemoveEnd.Visible = true;
                    ViewState["colordiv"] = "#99FF99";
                }

                // In Month only there is EndDate.
                if (vciPeriodTypeId == 2)
                {
                    btnRemoveStart.Visible = true;
                    btnNext.Visible = true;
                    ViewState["colordiv"] = "#99FF99";
                }

                // In Month there is both StartDate and EndDate.
                if (vciPeriodTypeId == 3)
                {
                    btnBack.Visible = true;
                    btnNext.Visible = true;
                    ViewState["colordiv"] = "#99FF99";
                }

                // In Month there is'nt StartDate neither EndDate (in range).                                
                if (vciPeriodTypeId == 4)
                {
                    // Required to center bar.
                    lblMonthType.Visible = true;
                    lblMonthType.Text = "X";
                    lblMonthType.ForeColor = System.Drawing.ColorTranslator.FromHtml("#99FF99");

                    ViewState["colordiv"] = "#99FF99";
                }
                
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

        protected void btnNext_Click(object sender, ImageClickEventArgs e)
        {
            srcCapabilityEndDateNextMonthUpd.UpdateParameters["pCompId"].DefaultValue = hdnCompId.Value;
            srcCapabilityEndDateNextMonthUpd.UpdateParameters["pCapabilityId"].DefaultValue = hdnCapabilityId.Value;
            srcCapabilityEndDateNextMonthUpd.UpdateParameters["pUserId"].DefaultValue = "1";
            srcCapabilityEndDateNextMonthUpd.Update();            
            Page.Response.Redirect(Page.Request.Url.ToString(), true);
        }

        protected void btnBack_Click(object sender, ImageClickEventArgs e)
        {
            srcCapabilityStartDatePriorMonthUpd.UpdateParameters["pCompId"].DefaultValue = hdnCompId.Value;
            srcCapabilityStartDatePriorMonthUpd.UpdateParameters["pCapabilityId"].DefaultValue = hdnCapabilityId.Value;            
            srcCapabilityStartDatePriorMonthUpd.UpdateParameters["pUserId"].DefaultValue = "1";
            srcCapabilityStartDatePriorMonthUpd.Update();
            Page.Response.Redirect(Page.Request.Url.ToString(), true);
        }

        protected void btnRemoveStart_Click(object sender, ImageClickEventArgs e)
        {
            srcCapabilityEndDatePriorMonthUpd.UpdateParameters["pCompId"].DefaultValue = hdnCompId.Value;
            srcCapabilityEndDatePriorMonthUpd.UpdateParameters["pCapabilityId"].DefaultValue = hdnCapabilityId.Value;
            srcCapabilityEndDatePriorMonthUpd.UpdateParameters["pUserId"].DefaultValue = "1";
            srcCapabilityEndDatePriorMonthUpd.Update();
            Page.Response.Redirect(Page.Request.Url.ToString(), true);
        }

        protected void btnRemoveEnd_Click(object sender, ImageClickEventArgs e)
        {            
            srcCapabilityStartDateNextMonthUpd.UpdateParameters["pCompId"].DefaultValue = hdnCompId.Value;
            srcCapabilityStartDateNextMonthUpd.UpdateParameters["pCapabilityId"].DefaultValue = hdnCapabilityId.Value;
            srcCapabilityStartDateNextMonthUpd.UpdateParameters["pUserId"].DefaultValue = "1";
            srcCapabilityStartDateNextMonthUpd.Update();
            Page.Response.Redirect(Page.Request.Url.ToString(), true);
        }
    }
}