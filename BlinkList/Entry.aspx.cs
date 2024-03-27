using System;
using System.Configuration;
using System.Management;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Threading.Tasks;

namespace BlinkList
{
    public partial class Entry : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
           
        }

        protected void Login_Event(object sender, EventArgs e)
        {
            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["BlinkList_db"].ToString()))
            {
                con.Open();
                using (SqlCommand cmd = new SqlCommand("ProcLogin", con))
                {
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@UserEmail", tbEmail.Text);
                    cmd.Parameters.AddWithValue("@UserPassword", tbPassword.Text);
                    SqlDataReader dr = cmd.ExecuteReader();
                    if (dr.Read() && dr["UserExist"].ToString() == "True")
                    {
                        Session["User"] = new Dictionary<string, string>() { {"UserName", dr["UserName"].ToString() },
                            {"UserEmail", dr["UserEmail"].ToString() }
                        };
                        //ScriptManager.RegisterStartupScript(this, GetType(), "Login", "var newUser = { email: '"+tbEmail.Text+"', password: '"+tbPassword.Text+"' }; localStorage.setItem(\"users\", JSON.stringify(newUser));", true);
                        Response.Redirect("BlinkList.aspx");
                    }
                }
            }
        }

        protected void Register_Event(object sender, EventArgs e)
        {
            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["BlinkList_db"].ToString()))
            {
                con.Open();
                using (SqlCommand cmd = new SqlCommand("ProcRegister", con))
                {
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@UserEmail", tbEmailReg.Text);
                    cmd.Parameters.AddWithValue("@UserName", tbUsernameReg.Text);
                    cmd.Parameters.AddWithValue("@UserPassword", tbPasswordReg.Text);
                    SqlDataReader dr = cmd.ExecuteReader();
                    if (dr.Read() && dr["UserExist"].ToString() != "True")
                    {
                        Response.Redirect("BlinkList.aspx");
                    }
                }
            }
        }
    }
}