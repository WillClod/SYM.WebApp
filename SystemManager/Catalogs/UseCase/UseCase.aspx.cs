﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

namespace SystemManager.Catalogs.UseCase
{
    public partial class UseCase : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // On Create page.
            if (!IsPostBack)
            {
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

                // Fill Grid.
                srcEpic.SelectParameters["FlowId"].DefaultValue = cmbFlow.SelectedValue;
                grdStep.DataBind();

            }

        }
    }
}