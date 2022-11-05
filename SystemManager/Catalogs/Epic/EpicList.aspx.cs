using System.Linq;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

using System;
namespace SystemManager.Catalogs.Epic
{
    public partial class EpicList: System.Web.UI.Page
    {        

        protected void Page_Load(object sender, EventArgs e)
        {
            // On Create page.
            if (!IsPostBack)
            {
                /*
                // Get Use Case id;
                if (Request.QueryString["UseCaseId"] != null)
                {
                    hdnUseCaseId.Value = Request.QueryString["UseCaseId"];
                }

                // Get Use Case info.                    
                srcUseCase.SelectParameters["UseCaseId"].DefaultValue = hdnUseCaseId.Value;
                DataView dv = (DataView)srcUseCase.Select(DataSourceSelectArguments.Empty);
                if (dv != null)
                {
                    DataTable dt = dv.ToTable();
                    lblName.Text = dt.Rows[0]["Name"].ToString();
                    lblType.Text = dt.Rows[0]["Type"].ToString();
                    lblDescription.Text = dt.Rows[0]["Description"].ToString();
                }

                // Fill combos.
                srcFlow.SelectParameters["UseCaseId"].DefaultValue = hdnUseCaseId.Value;
                cmbFlow.DataBind();
                */

                // Fill combos.
                srcEpicType.SelectParameters["CompId"].DefaultValue = hdnCompId.Value;
                //cmbFlow.DataBind();

                // Fill Grid.
                srcEpic.SelectParameters["CompId"].DefaultValue = hdnCompId.Value;
                //srcEpic.SelectParameters["EpicId"].DefaultValue = null;
                grdEpic.DataBind();
                
            }

        }

        protected void btnCancel_Click(object sender, ImageClickEventArgs e)
        {
            grdEpic.EditIndex = -1;
            lnkAddEpic.Visible = true;
        }

        protected void grdEpic_DataBound(object sender, EventArgs e)
        {
            // Set Variables.
            HiddenField hdnEpicId;
            ImageButton ibtShowCapability;
            EpicMonthList _EpicMonthList;
            CapabilityList _CapabilityList;
            CapabilityMonthList _CapabilityMonthList;

            foreach (GridViewRow gvRow in grdEpic.Rows)
            {
                // Get control cell.
                hdnEpicId = (HiddenField)gvRow.FindControl("hdnEpicId");
                ibtShowCapability = (ImageButton)gvRow.FindControl("ibtShowCapability");


                if (hdnEpicId != null)
                {
                    // Refresh user control.                    
                    _EpicMonthList = (EpicMonthList)gvRow.FindControl("ctrEpicMonthList");
                    _EpicMonthList.vciCompId = Convert.ToInt32(hdnCompId.Value);
                    _EpicMonthList.vciEpicId = Convert.ToInt32(hdnEpicId.Value);
                    _EpicMonthList.vciYearId = 2022;
                    _EpicMonthList.vcbRefresh = true;

                    //if(ibtShowCapability != null)
                    //if (ibtShowCapability.ImageUrl == "~/Images/IconDown16.png") 
                    //{ 
                        // Refresh user control.                    
                        _CapabilityList = (CapabilityList)gvRow.FindControl("ctrCapabilityList");
                        if(_CapabilityList != null)
                        { 
                            _CapabilityList.vciEpicId = Convert.ToInt32(hdnEpicId.Value);
                            _CapabilityList.vcbRefresh = true;
                        }

                        // Refresh user control.                    
                        _CapabilityMonthList = (CapabilityMonthList)gvRow.FindControl("ctrCapabilityMonthList");
                        if (_CapabilityMonthList != null)
                        {
                            _CapabilityMonthList.vciEpicId = Convert.ToInt32(hdnEpicId.Value);
                            _CapabilityMonthList.vciYearId = DateTime.Now.Year;
                            _CapabilityMonthList.vcbRefresh = true;
                        }
                    //}

                }
            }

        }

        protected void lnkAddEpic_Click(object sender, EventArgs e)
        {
            // Set as edit last row (new).
            grdEpic.EditIndex = grdEpic.Rows.Count - 1;
            lnkAddEpic.Visible = false;
        }

        protected void btnSave_Click(object sender, ImageClickEventArgs e)
        {
            grdEpic.EditIndex = -1;
            lnkAddEpic.Visible = true;
        }

        protected void grdEpic_RowCommand(object sender, GridViewCommandEventArgs e)
        {

            // If row save button click ... 
            if ((e.CommandName == "Save") && (e.CommandArgument != ""))
            {
                // Get row controls.
                HiddenField hdnEpicId = (HiddenField)grdEpic.Rows[Convert.ToInt32(e.CommandArgument)].FindControl("hdnEpicId");
                TextBox txtEpicCode = (TextBox)grdEpic.Rows[Convert.ToInt32(e.CommandArgument)].FindControl("txtEpicCode");
                //TextBox txtEpicName = (TextBox)grdEpic.Rows[Convert.ToInt32(e.CommandArgument)].FindControl("txtEpicName");
                DropDownList cmbEpicType = (DropDownList)grdEpic.Rows[Convert.ToInt32(e.CommandArgument)].FindControl("cmbEpicType");

                // Data validations.
                // ...

                // If new ...
                if (hdnEpicId.Value == "0")
                {
                    // Set variables.
                    /*
                    string vlsApplicationCode = "";
                    string vlsUseTypeCode = "";
                    */

                    // Get Application code.
                    /*
                    srcGetApplicationCode.SelectParameters["ApplicationId"].DefaultValue = cmbApplication.SelectedValue;
                    DataView dv = (DataView)srcGetApplicationCode.Select(DataSourceSelectArguments.Empty);
                    if (dv != null)
                    {
                        DataTable dt = dv.ToTable();
                        vlsApplicationCode = dt.Rows[0]["Code"].ToString();
                    }
                    */

                    // Get Use Type code.
                    /*
                    srcGetUseTypeCode.SelectParameters["UseTypeId"].DefaultValue = cmbUseType.SelectedValue;
                    dv = (DataView)srcGetUseTypeCode.Select(DataSourceSelectArguments.Empty);
                    if (dv != null)
                    {
                        DataTable dt = dv.ToTable();
                        vlsUseTypeCode = dt.Rows[0]["Code"].ToString();
                    }
                    */

                    // Insert record.                   
                    srcEpic.InsertParameters["pCompId"].DefaultValue = hdnCompId.Value;                    
                    srcEpic.InsertParameters["pEpicCode"].DefaultValue = txtEpicCode.Text;
                    //srcEpic.InsertParameters["pEpicName"].DefaultValue = txtEpicName.Text;
                    srcEpic.InsertParameters["pEpicName"].DefaultValue = txtEpicCode.Text;
                    srcEpic.InsertParameters["pEpicTypeId"].DefaultValue = cmbEpicType.SelectedValue; ;
                    srcEpic.InsertParameters["pUserId"].DefaultValue = hdnUserId.Value;
                    srcEpic.Insert();

                }
                else // If edit ... 
                {
                    // Update record.
                    srcEpic.UpdateParameters["pCompId"].DefaultValue = hdnCompId.Value;
                    srcEpic.UpdateParameters["pEpicId"].DefaultValue = hdnEpicId.Value;
                    srcEpic.UpdateParameters["pEpicCode"].DefaultValue = txtEpicCode.Text;
                    //srcEpic.UpdateParameters["pEpicName"].DefaultValue = txtEpicName.Text;
                    srcEpic.UpdateParameters["pEpicName"].DefaultValue = txtEpicCode.Text;
                    srcEpic.UpdateParameters["pEpicTypeId"].DefaultValue = cmbEpicType.SelectedValue; ;
                    srcEpic.UpdateParameters["pUserId"].DefaultValue = hdnUserId.Value;
                    srcEpic.Update();
                }
                

                // Remove row edit view.
                grdEpic.EditIndex = -1;
                grdEpic.DataBind();
            }


        }

        protected void grdEpic_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                // Get controls.
                ImageButton btnSave = (ImageButton)e.Row.FindControl("btnSave");

                // Set controls.
                if (btnSave != null)
                {
                    //btnSave.Attributes["onclick"] = ClientScript.GetPostBackClientHyperlink(grdUsePackage, "SavePackage$" + e.Row.DataItemIndex, true);
                    btnSave.CommandName = "Save";
                    btnSave.CommandArgument = e.Row.DataItemIndex.ToString();
                }
            }
        }

        protected void cmbEpicType_DataBound(object sender, EventArgs e)
        {
            // Add all item. 
            ListItem listItem = new ListItem();
            listItem.Text = "";
            listItem.Value = "0";
            //cmbEpicType.Items.Insert(0, listItem);
        }

        protected void txtEpicCode_TextChanged(object sender, EventArgs e)
        {

        }
    }
}