using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

namespace SystemManager.Catalogs.Epic
{
    public partial class CalendarPeriod : System.Web.UI.UserControl
    {
        public string colorDiv { get { return ViewState["colordiv"].ToString(); } }

        // Define control parameters.
        public int vciCompId { get; set; }
        public int vciEpicId { get; set; }
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
                hdnEpicId.Value = vciEpicId.ToString();

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
                    ViewState["colordiv"] = "#6699FF";
                }

                // In Month only there is EndDate.
                if (vciPeriodTypeId == 2)
                {
                    btnRemoveStart.Visible = true;
                    btnNext.Visible = true;
                    ViewState["colordiv"] = "#6699FF";
                }

                // In Month there is both StartDate and EndDate.
                if (vciPeriodTypeId == 3)
                {
                    btnBack.Visible = true;
                    btnNext.Visible = true;
                    ViewState["colordiv"] = "#6699FF";
                }

                // In Month there is'nt StartDate neither EndDate (in range).                                
                if (vciPeriodTypeId == 4)
                {
                    // Required to center bar.
                    lblMonthType.Visible = true;
                    lblMonthType.Text = "X";
                    lblMonthType.ForeColor = System.Drawing.ColorTranslator.FromHtml("#6699FF");

                    ViewState["colordiv"] = "#6699FF";
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
            srcEpicEndDateNextMonthUpd.UpdateParameters["pCompId"].DefaultValue = hdnCompId.Value;
            srcEpicEndDateNextMonthUpd.UpdateParameters["pEpicId"].DefaultValue = hdnEpicId.Value;
            srcEpicEndDateNextMonthUpd.UpdateParameters["pUserId"].DefaultValue = "1";
            srcEpicEndDateNextMonthUpd.Update();            
            Page.Response.Redirect(Page.Request.Url.ToString(), true);
        }

        protected void btnBack_Click(object sender, ImageClickEventArgs e)
        {
            srcEpicStartDatePriorMonthUpd.UpdateParameters["pCompId"].DefaultValue = hdnCompId.Value;
            srcEpicStartDatePriorMonthUpd.UpdateParameters["pEpicId"].DefaultValue = hdnEpicId.Value;            
            srcEpicStartDatePriorMonthUpd.UpdateParameters["pUserId"].DefaultValue = "1";
            srcEpicStartDatePriorMonthUpd.Update();
            Page.Response.Redirect(Page.Request.Url.ToString(), true);
        }

        protected void btnRemoveStart_Click(object sender, ImageClickEventArgs e)
        {
            srcEpicEndDatePriorMonthUpd.UpdateParameters["pCompId"].DefaultValue = hdnCompId.Value;
            srcEpicEndDatePriorMonthUpd.UpdateParameters["pEpicId"].DefaultValue = hdnEpicId.Value;
            srcEpicEndDatePriorMonthUpd.UpdateParameters["pUserId"].DefaultValue = "1";
            srcEpicEndDatePriorMonthUpd.Update();
            Page.Response.Redirect(Page.Request.Url.ToString(), true);
        }

        protected void btnRemoveEnd_Click(object sender, ImageClickEventArgs e)
        {            
            srcEpicStartDateNextMonthUpd.UpdateParameters["pCompId"].DefaultValue = hdnCompId.Value;
            srcEpicStartDateNextMonthUpd.UpdateParameters["pEpicId"].DefaultValue = hdnEpicId.Value;
            srcEpicStartDateNextMonthUpd.UpdateParameters["pUserId"].DefaultValue = "1";
            srcEpicStartDateNextMonthUpd.Update();
            Page.Response.Redirect(Page.Request.Url.ToString(), true);
        }
    }
}