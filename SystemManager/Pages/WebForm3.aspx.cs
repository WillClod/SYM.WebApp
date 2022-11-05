using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Pages
{
    public partial class WebForm3 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //btnAceptar.Attributes.Add("onClick", "javascript: return btnTest_OnClick();");

        }

        protected void btnAceptar_Click(object sender, EventArgs e)
        {
            //Page.ClientScript.RegisterStartupScript(this.GetType(), "ErrorAlert", "alert('" + txtNombre.Text + "');", true);
        }
    }
}