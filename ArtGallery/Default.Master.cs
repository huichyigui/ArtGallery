using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

namespace ArtGallery
{
    public partial class Default : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Request.Url.AbsoluteUri.ToString().Contains("Default.aspx"))
            {
            }
            else
            {
                HttpCookie cookie = Request.Cookies["Gender"];
                Control ctrBanner;
                if (cookie != null)
                {
                    if (cookie.Value == "Male")
                    {
                        ctrBanner = LoadControl("~/UserControls/SliderMaleControl.ascx");
                    }
                    else if (cookie.Value == "Female")
                    {
                        ctrBanner = LoadControl("~/UserControls/SliderFemaleControl.ascx");
                    } 
                    else
                    {
                        ctrBanner = LoadControl("~/UserControls/SliderUserControl.ascx");
                    }
                }
                else
                {
                    ctrBanner = LoadControl("~/UserControls/SliderUserControl.ascx");
                }
                pnlSliderUC.Controls.Add(ctrBanner);
            }

            // Counting No. of Artworks Present in Shopping Cart
            DataTable dt = new DataTable();
            dt = (DataTable)Session["buyArtwork"];

            if (dt != null)
            {
                int intRow = dt.Rows.Count;
                int i = 0;
                int countCart = 0;
                while (i < intRow)
                {
                    countCart += Convert.ToInt16(dt.Rows[i]["Quantity"].ToString());
                    i++;
                }
                lblCartCount.Text = countCart.ToString();
            }
            else
            {
                lblCartCount.Text = "0";
            }

            // // Counting No. of Products Present in Wishlist
            DataTable dt2 = new DataTable();
            dt2 = (DataTable)Session["WishlistArt"];
            if (dt2 != null)
            {
                lblWishlistCount.Text = dt2.Rows.Count.ToString();
            }
            else
            {
                lblWishlistCount.Text = "0";
            }

            if (Session["username"] != null)
            {
                btnLogin.Visible = false;
                btnLogout.Visible = true;
            }
            else
            {
                btnLogin.Visible = true;
                btnLogout.Visible = false;
            }
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            Response.Redirect("Login.aspx");
        }

        protected void btnLogout_Click(object sender, EventArgs e)
        {
            Session.Clear();
            Session.Abandon();
            Response.Cookies["ASP.NET_SessionId"].Value = string.Empty;
            Response.Cookies["ASP.NET_SessionId"].Expires = DateTime.Now.AddDays(-1);
            Response.Redirect("Default.aspx");
        }

        protected void Menu1_MenuItemDataBound(object sender, MenuEventArgs e)
        {
            if (SiteMap.CurrentNode != null)
            {
                if (e.Item.Text == SiteMap.CurrentNode.Title)
                {
                    if (e.Item.Parent != null)
                    {
                        e.Item.Parent.Selected = true;
                    }
                    else
                    {
                        e.Item.Selected = true;
                    }
                }
            }
        }
    }
}