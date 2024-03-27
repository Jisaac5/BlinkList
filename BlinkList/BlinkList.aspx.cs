using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace BlinkList
{
    public partial class BlinkList : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["User"] != null)
            {
                isLoggedIn.Value = "True";
            }
            else
            {
                isLoggedIn.Value = "False";
            }
        }

        protected void Signout_Event(object sender, EventArgs e)
        {
            Session.Abandon();
            Response.Redirect("~/BlinkList.aspx");
        }
    }
}