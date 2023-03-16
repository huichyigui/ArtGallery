using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;

namespace ArtGallery
{
    public partial class Login : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(Connection.GetConnectionString());
        protected void Page_Load(object sender, EventArgs e)
        {
            txtUsername.Focus();
            if (!IsPostBack)
            {
                if (Session["username"] != null)
                {
                    Response.Redirect("Default.aspx");
                }
            }

            HttpCookie cookie = HttpContext.Current.Request.Cookies["UserType"];
            string strSrc = "";
            if (cookie != null)
            {
                string strUserType = Request.Cookies["UserType"].Value;

                if (strUserType == "ArtLover")
                {
                    strSrc = "~/UserControls/ArtLoverLoginAds.ascx";
                }
                else if (strUserType == "Artist")
                {
                    strSrc = "~/UserControls/ArtistAds.ascx";
                }
            }
            else
            {
                strSrc = "~/UserControls/AnonymousLoginAds.ascx";
            }
            Control ctrBanner = LoadControl(strSrc);
            AdsPlaceHolder.Controls.Add(ctrBanner);
        }

        protected void chkViewPw_CheckedChanged(object sender, EventArgs e)
        {
            if (chkViewPw.Checked == true)
            {
                txtPassword.TextMode = TextBoxMode.SingleLine;
            }
            else
            {
                txtPassword.TextMode = TextBoxMode.Password;
            }
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            try
            {
                String query;
                con.Open();

                if (ddlUserType.SelectedIndex == 1)
                {
                    query = "SELECT COUNT(1) FROM Users WHERE Username=@username AND Password=@password AND RoleType='Artist'";
                    Session["usertype"] = "Artist";
                }
                else
                {
                    query = "SELECT COUNT(1) FROM Users WHERE Username=@username AND Password=@password AND RoleType='Customer'";
                    Session["usertype"] = "Customer";
                }

                SqlCommand sqlCmd = new SqlCommand(query, con);
                sqlCmd.Parameters.AddWithValue("@username", txtUsername.Text.Trim());
                sqlCmd.Parameters.AddWithValue("@password", txtPassword.Text.Trim());
                int count = Convert.ToInt32(sqlCmd.ExecuteScalar());
                con.Close();

                if (count == 1)
                {
                    Session["username"] = txtUsername.Text.Trim();
                    Session["buyArtwork"] = null;
                    Session["WishlistArt"] = null;

                    String getEmailAndGenderQuery = "SELECT EmailAddress, Gender FROM Users WHERE Username=@username";
                    SqlCommand cmd = new SqlCommand(getEmailAndGenderQuery, con);
                    cmd.Parameters.AddWithValue("@username", txtUsername.Text.Trim());
                    con.Open();
                    SqlDataReader dr = cmd.ExecuteReader();
                    dr.Read();
                    Session["userEmail"] = dr[0].ToString();

                    //Add in Gender cookies for displaying user control cookies in default homepage
                    String gender = dr[1].ToString();
                    HttpCookie cookie = new HttpCookie("Gender", gender);
                    cookie.Expires = DateTime.Now.AddDays(30);
                    Response.Cookies.Add(cookie);
                    con.Close();

                    FillSavedCart();
                    FillWishlist();

                    if (ddlUserType.SelectedIndex == 1)
                    {
                        HttpCookie cookies = new HttpCookie("UserType", "Artist");
                        cookies.Expires = DateTime.Now.AddDays(30);
                        Response.Cookies.Add(cookies);
                        Response.Redirect("~/Artist/Dashboard.aspx");
                    }
                    else
                    {
                        HttpCookie cookies = new HttpCookie("UserType", "ArtLover");
                        cookies.Expires = DateTime.Now.AddDays(30);
                        Response.Cookies.Add(cookies);
                        Response.Redirect("Default.aspx");
                    }
                }
                else
                {
                    lblError.Visible = true;
                }
            }
            catch (Exception ex)
            {
                Response.Write(ex.Message);
            }
        }

        private void FillSavedCart()
        {
            DataTable dt = new DataTable();
            DataRow dr;
            dt.Columns.Add("No");
            dt.Columns.Add("ArtworkId");
            dt.Columns.Add("Name");
            dt.Columns.Add("ImageUrl");
            dt.Columns.Add("Price");
            dt.Columns.Add("Quantity");
            dt.Columns.Add("TotalPrice");

            SqlDataAdapter da = new SqlDataAdapter("SELECT c.ArtworkId, a.Name, a.ImageUrl, a.Price, c.Quantity FROM Carts c, Artworks a WHERE c.ArtworkId = a.ArtworkId AND c.Username=@Username", con);
            da.SelectCommand.Parameters.AddWithValue("@Username", Session["username"]);
            DataSet ds = new DataSet();
            da.Fill(ds);
            if (ds.Tables[0].Rows.Count > 0)
            {
                int i = 0;
                int counter = ds.Tables[0].Rows.Count;
                while (i < counter)
                {
                    dr = dt.NewRow();
                    dr["No"] = i + 1;
                    dr["ArtworkId"] = ds.Tables[0].Rows[i]["ArtworkId"].ToString();
                    dr["Name"] = ds.Tables[0].Rows[i]["Name"].ToString();
                    dr["ImageUrl"] = ds.Tables[0].Rows[i]["ImageUrl"].ToString();
                    dr["Price"] = ds.Tables[0].Rows[i]["Price"].ToString();
                    dr["Quantity"] = ds.Tables[0].Rows[i]["Quantity"].ToString();

                    double dblPrice = Convert.ToDouble(ds.Tables[0].Rows[i]["Price"].ToString());
                    int intQuantity = Convert.ToInt16(ds.Tables[0].Rows[i]["Quantity"].ToString());
                    double dblTotalPrice = dblPrice * intQuantity;
                    dr["TotalPrice"] = dblTotalPrice;
                    dt.Rows.Add(dr);
                    i++;
                }
            }
            else
            {
                Session["buyArtwork"] = null;
            }
            Session["buyArtwork"] = dt;
        }

        private void FillWishlist()
        {
            DataTable dt = new DataTable();
            DataRow dr;
            dt.Columns.Add("No");
            dt.Columns.Add("ArtworkId");
            dt.Columns.Add("Name");
            dt.Columns.Add("ImageUrl");
            dt.Columns.Add("Price");

            SqlDataAdapter da = new SqlDataAdapter("select a.ArtworkId, a.Name, a.ImageUrl, a.Price from Artworks a, Wishlists w where a.ArtworkId=w.ArtworkId AND w.Username=@username;", con);
            da.SelectCommand.Parameters.AddWithValue("@username", Session["username"]);
            DataSet ds = new DataSet();
            da.Fill(ds);
            if (ds.Tables[0].Rows.Count > 0)
            {
                int i = 0;
                int counter = ds.Tables[0].Rows.Count;
                while (i < counter)
                {
                    dr = dt.NewRow();
                    dr["No"] = i + 1;
                    dr["ArtworkId"] = ds.Tables[0].Rows[i]["ArtworkId"].ToString();
                    dr["Name"] = ds.Tables[0].Rows[i]["Name"].ToString();
                    dr["ImageUrl"] = ds.Tables[0].Rows[i]["ImageUrl"].ToString();
                    dr["Price"] = ds.Tables[0].Rows[i]["Price"].ToString();
                    dt.Rows.Add(dr);
                    i++;
                }
            }
            else
            {
                Session["WishlistArt"] = null;
            }
            Session["WishlistArt"] = dt;
        }
    }
}